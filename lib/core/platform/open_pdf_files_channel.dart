import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Channel for tracking open PDF files across all Flutter engines.
///
/// Uses native-side storage to prevent opening the same file twice.
/// When a file is already open, the existing window is brought to front.
///
/// Usage:
/// ```dart
/// // Check if file is already open
/// final existingWindowId = await OpenPdfFilesChannel.getWindowIdForFile(filePath);
/// if (existingWindowId != null) {
///   await OpenPdfFilesChannel.focusPdfWindow(filePath);
///   return existingWindowId;
/// }
///
/// // Create new window and register
/// final window = await WindowController.create(configuration);
/// await OpenPdfFilesChannel.registerPdfFile(filePath, window.windowId);
/// ```
class OpenPdfFilesChannel {
  OpenPdfFilesChannel._();

  static const _channel = MethodChannel('com.pdfsign/open_pdf_files');

  /// Gets the window ID for a file if it's already open.
  /// Returns null if the file is not currently open.
  static Future<String?> getWindowIdForFile(String filePath) async {
    if (kDebugMode) {
      print('OpenPdfFilesChannel.getWindowIdForFile: $filePath');
    }
    try {
      final result = await _channel.invokeMethod<String?>(
        'getWindowIdForFile',
        filePath,
      );
      if (kDebugMode) {
        print('OpenPdfFilesChannel.getWindowIdForFile: result=$result');
      }
      return result;
    } catch (e) {
      if (kDebugMode) {
        print('OpenPdfFilesChannel.getWindowIdForFile ERROR: $e');
      }
      return null;
    }
  }

  /// Registers a PDF file as open with its window ID.
  /// Call this after creating a new PDF window.
  static Future<void> registerPdfFile(String filePath, String windowId) async {
    try {
      await _channel.invokeMethod('registerPdfFile', {
        'filePath': filePath,
        'windowId': windowId,
      });
      if (kDebugMode) {
        print('OpenPdfFilesChannel.registerPdfFile: $filePath -> $windowId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('OpenPdfFilesChannel.registerPdfFile error: $e');
      }
    }
  }

  /// Unregisters a PDF file when its window closes.
  /// Call this when a PDF window is destroyed.
  static Future<void> unregisterPdfFile(String filePath) async {
    try {
      await _channel.invokeMethod('unregisterPdfFile', filePath);
      if (kDebugMode) {
        print('OpenPdfFilesChannel.unregisterPdfFile: $filePath');
      }
    } catch (e) {
      if (kDebugMode) {
        print('OpenPdfFilesChannel.unregisterPdfFile error: $e');
      }
    }
  }

  /// Attempts to focus the window displaying the specified file.
  /// Returns true if the window was found and focused, false otherwise.
  static Future<bool> focusPdfWindow(String filePath) async {
    try {
      final result = await _channel.invokeMethod<bool>(
            'focusPdfWindow',
            filePath,
          ) ??
          false;
      if (kDebugMode) {
        print('OpenPdfFilesChannel.focusPdfWindow: $filePath -> $result');
      }
      return result;
    } catch (e) {
      if (kDebugMode) {
        print('OpenPdfFilesChannel.focusPdfWindow error: $e');
      }
      return false;
    }
  }
}
