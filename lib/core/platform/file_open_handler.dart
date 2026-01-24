import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

import 'package:pdfsign/core/window/window_manager_service.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';
import 'package:pdfsign/domain/repositories/recent_files_repository.dart';

/// Handles file open requests from macOS Finder.
///
/// When user opens PDF via Finder (double-click, "Open With", drag to Dock),
/// macOS sends the file path to this handler via platform channel.
class FileOpenHandler {
  FileOpenHandler._();

  static const _channel = MethodChannel('com.pdfsign/file_handler');
  static bool _initialized = false;
  static RecentFilesRepository? _recentFilesRepository;
  static VoidCallback? _onHideWelcome;

  /// Initializes the file open handler.
  ///
  /// Call this once from WelcomeApp.initState() after Flutter is ready.
  /// [recentFilesRepository] is used to add opened files to recent files list.
  /// [onHideWelcome] is called when Welcome window should be hidden - this
  /// allows WelcomeApp to update its focus state and stop rendering menu.
  static Future<void> init({
    required RecentFilesRepository recentFilesRepository,
    VoidCallback? onHideWelcome,
  }) async {
    if (_initialized) return;
    _initialized = true;
    _recentFilesRepository = recentFilesRepository;
    _onHideWelcome = onHideWelcome;

    // Set up handler for incoming file open requests from macOS
    _channel.setMethodCallHandler(_handleMethodCall);

    // Signal to macOS that Flutter is ready to receive files
    try {
      await _channel.invokeMethod('ready');
      if (kDebugMode) {
        print('FileOpenHandler: signaled ready to macOS');
      }
    } catch (e) {
      if (kDebugMode) {
        print('FileOpenHandler: failed to signal ready: $e');
      }
    }
  }

  static Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'openFile':
        final filePath = call.arguments as String?;
        if (filePath == null || filePath.isEmpty) {
          if (kDebugMode) {
            print('FileOpenHandler: received null or empty file path');
          }
          return null;
        }
        // Repository handles its own synchronization via internal lock
        await _openFile(filePath);
        return null;

      default:
        throw PlatformException(
          code: 'UNSUPPORTED',
          message: 'Method ${call.method} not supported',
        );
    }
  }

  static Future<void> _openFile(String filePath) async {
    if (kDebugMode) {
      print('FileOpenHandler: opening file: $filePath');
    }

    // Validate file exists
    final file = File(filePath);
    if (!await file.exists()) {
      if (kDebugMode) {
        print('FileOpenHandler: file does not exist: $filePath');
      }
      return;
    }

    // Validate it's a PDF
    if (!filePath.toLowerCase().endsWith('.pdf')) {
      if (kDebugMode) {
        print('FileOpenHandler: not a PDF file: $filePath');
      }
      return;
    }

    // Open in new window (or focus existing if already open)
    final windowId =
        await WindowManagerService.instance.createPdfWindow(filePath);

    if (windowId == null) {
      if (kDebugMode) {
        print('FileOpenHandler: failed to create window for: $filePath');
      }
      return;
    }

    // Add to recent files BEFORE hiding Welcome window.
    // This ensures the SharedPreferences write completes while Welcome
    // is still active. Writing after hide() can fail silently.
    final fileName = filePath.split('/').last;
    if (_recentFilesRepository != null) {
      final result = await _recentFilesRepository!.addRecentFile(
        RecentFile(
          path: filePath,
          fileName: fileName,
          lastOpened: DateTime.now(),
          pageCount: 0,
          isPasswordProtected: false,
        ),
      );

      result.fold(
        (failure) {
          if (kDebugMode) {
            print('FileOpenHandler: failed to add to recent files: '
                '${failure.message}');
          }
        },
        (_) {
          if (kDebugMode) {
            print('FileOpenHandler: added to recent files: $fileName');
          }
        },
      );
    } else {
      if (kDebugMode) {
        print('FileOpenHandler: warning - repository is null, '
            'cannot add to recent files');
      }
    }

    // Hide Welcome window AFTER adding to recent files.
    // Use callback to update WelcomeApp's focus state (stops menu rendering).
    // The broadcast in createPdfWindow doesn't reach Welcome because it excludes self.
    if (_onHideWelcome != null) {
      _onHideWelcome!();
    } else {
      // Fallback if callback not set
      WindowManagerService.instance.setWelcomeHidden();
      await windowManager.hide();
    }
    if (kDebugMode) {
      print('FileOpenHandler: Welcome window hidden');
    }
  }
}
