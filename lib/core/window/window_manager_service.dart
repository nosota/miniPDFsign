import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:window_manager/window_manager.dart';

import '../platform/open_pdf_files_channel.dart';
import '../platform/settings_singleton_channel.dart';
import 'window_arguments.dart';
import 'window_broadcast.dart';

/// Extension to add close functionality to WindowController.
/// The desktop_multi_window package doesn't provide a built-in close method.
// extension WindowControllerClose on WindowController {
//   /// Closes this window by invoking the native close method.
//   Future<void> close() {
//     return invokeMethod('window_close');
//   }
// }

/// Service for managing multiple windows in the application.
///
/// Handles creation of new PDF viewer windows and window lifecycle.
class WindowManagerService {
  WindowManagerService._() {
    _initSettingsBroadcastListeners();
  }

  static final WindowManagerService instance = WindowManagerService._();

  /// Tracks IDs of currently open PDF viewer windows.
  final Set<String> _openWindows = {};

  /// Tracks the ID of the currently open Settings window (singleton).
  /// Updated via broadcast when Settings opens/closes from any window.
  String? _settingsWindowId;

  /// Flag to prevent race condition when creating Settings window.
  bool _isCreatingSettingsWindow = false;

  /// Initialize broadcast listeners for Settings tracking across engines.
  void _initSettingsBroadcastListeners() {
    WindowBroadcast.setOnSettingsOpened((windowId) {
      _settingsWindowId = windowId;
      if (kDebugMode) {
        print('Received settingsOpened broadcast: $windowId');
      }
    });
    WindowBroadcast.setOnSettingsClosed(() {
      _settingsWindowId = null;
      if (kDebugMode) {
        print('Received settingsClosed broadcast');
      }
    });
  }

  /// Tracks whether Welcome window is hidden.
  /// Once hidden (by opening PDF or closing Welcome while other windows exist),
  /// Welcome never shows again until app restart.
  bool _welcomeHidden = false;

  /// Gets the set of currently open window IDs.
  Set<String> get openWindows => Set.unmodifiable(_openWindows);

  /// Initializes the window manager for the main window.
  Future<void> initializeMainWindow() async {
    await windowManager.ensureInitialized();

    final windowOptions = WindowOptions(
      size: const Size(900, 700),
      minimumSize: const Size(600, 400),
      center: true,
      backgroundColor: const Color(0xFFE5E5E5),
      titleBarStyle: TitleBarStyle.normal,
      title: 'PDFSign',
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  /// Initializes a sub-window (PDF viewer window).
  Future<void> initializeSubWindow({required String title}) async {
    await windowManager.ensureInitialized();
    await windowManager.setTitle(title);
  }

  /// Initializes the settings window with fixed size.
  ///
  /// Settings window: 650x500, not resizable, no minimize button.
  Future<void> initializeSettingsWindow({required String title}) async {
    await windowManager.ensureInitialized();

    const windowSize = Size(650, 500);

    await windowManager.setTitle(title);
    await windowManager.setSize(windowSize);
    await windowManager.setMinimumSize(windowSize);
    await windowManager.setMaximumSize(windowSize);
    await windowManager.setResizable(false);
    await windowManager.setMinimizable(false);
    await windowManager.center();
  }

  /// Creates a new window to display a PDF file.
  ///
  /// If the file is already open in another window, focuses that window instead.
  /// When the first PDF window is created, the Welcome window is automatically
  /// hidden and never shown again until app restart.
  ///
  /// Returns the window ID if successful, null otherwise.
  Future<String?> createPdfWindow(String filePath) async {
    try {
      // Check if this file is already open
      final existingWindowId =
          await OpenPdfFilesChannel.getWindowIdForFile(filePath);

      if (existingWindowId != null) {
        // File is already open - try to focus the existing window
        final focused = await OpenPdfFilesChannel.focusPdfWindow(filePath);

        if (focused) {
          if (kDebugMode) {
            print('File already open, focused existing window: $filePath');
          }
          return existingWindowId;
        }

        // Window not found (might have been closed) - continue to create new
        if (kDebugMode) {
          print('Existing window not found, creating new: $filePath');
        }
      }

      final fileName = path.basename(filePath);

      final arguments = WindowArguments.pdfViewer(
        filePath: filePath,
        fileName: fileName,
      );

      final configuration = WindowConfiguration(
        arguments: arguments.toJson(),
        hiddenAtLaunch: false,
      );

      final window = await WindowController.create(configuration);

      final windowId = window.windowId;
      _openWindows.add(windowId);

      // Register the file as open with native storage
      await OpenPdfFilesChannel.registerPdfFile(filePath, windowId);

      // Hide Welcome window when first PDF opens (from any window)
      // Uses broadcast to notify Welcome window to hide itself
      if (!_welcomeHidden) {
        _welcomeHidden = true;
        await WindowBroadcast.broadcastHideWelcome();
        if (kDebugMode) {
          print('Welcome window hide broadcast sent (first PDF opened)');
        }
      }

      // Show the window
      await window.show();

      if (kDebugMode) {
        print('Created PDF window $windowId for: $filePath');
      }

      return windowId;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to create PDF window: $e');
      }
      return null;
    }
  }

  /// Creates or focuses the Settings window (singleton pattern).
  ///
  /// Uses native-side storage to enforce singleton across all Flutter engines.
  /// If Settings window is already open, focuses it and returns its ID.
  /// Otherwise creates a new Settings window.
  /// Returns the window ID if successful, null otherwise.
  Future<String?> createSettingsWindow() async {
    if (kDebugMode) {
      print('>>> createSettingsWindow called, _isCreating=$_isCreatingSettingsWindow');
    }

    // Prevent race condition within this engine
    if (_isCreatingSettingsWindow) {
      if (kDebugMode) {
        print('>>> Settings window creation already in progress, IGNORING');
      }
      return null;
    }

    _isCreatingSettingsWindow = true;
    if (kDebugMode) {
      print('>>> _isCreatingSettingsWindow set to TRUE');
      try {
        final currentWindow = await WindowController.fromCurrentEngine();
        print('>>> Current engine windowId: ${currentWindow.windowId}');
      } catch (_) {}
    }

    try {
      // Check native-side storage for existing Settings window
      // This is the source of truth shared across all Flutter engines
      final existingId = await SettingsSingletonChannel.getSettingsWindowId();

      if (existingId != null) {
        if (kDebugMode) {
          print('>>> Native reports Settings exists: $existingId');
        }

        // Verify the window still exists by checking native window list
        final allWindows = await WindowController.getAll();
        final windowExists = allWindows.any((w) => w.windowId == existingId);

        if (windowExists) {
          // Focus the existing Settings window using Flutter's WindowController
          try {
            final window = WindowController.fromWindowId(existingId);
            await window.show();
            if (kDebugMode) {
              print('>>> Focused existing Settings window via WindowController');
            }
            _settingsWindowId = existingId;
            return existingId;
          } catch (e) {
            if (kDebugMode) {
              print('>>> Failed to focus Settings: $e');
            }
          }
        }

        // Window no longer exists, clear native ID
        if (kDebugMode) {
          print('>>> Settings window $existingId no longer exists, clearing');
        }
        await SettingsSingletonChannel.clearSettingsWindowId();
      }

      // Create new Settings window
      final arguments = WindowArguments.settings();

      final configuration = WindowConfiguration(
        arguments: arguments.toJson(),
        hiddenAtLaunch: false,
      );

      final window = await WindowController.create(configuration);
      _settingsWindowId = window.windowId;

      // Register with native-side storage
      await SettingsSingletonChannel.setSettingsWindowId(_settingsWindowId!);

      // Show the window
      await window.show();

      if (kDebugMode) {
        print('Created settings window $_settingsWindowId');
      }

      return _settingsWindowId;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to create settings window: $e');
      }
      return null;
    } finally {
      _isCreatingSettingsWindow = false;
    }
  }

  /// Checks if the Settings window is still alive by querying all windows.
  Future<bool> _isSettingsWindowAlive() async {
    if (_settingsWindowId == null) return false;

    try {
      // Get all currently open windows
      final allWindows = await WindowController.getAll();
      final allWindowIds = allWindows.map((w) => w.windowId).toList();

      final exists = allWindowIds.contains(_settingsWindowId);

      if (kDebugMode) {
        print(
          'Settings window $_settingsWindowId exists: $exists '
          '(all windows: $allWindowIds)',
        );
      }

      return exists;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking if settings window exists: $e');
      }
      return false;
    }
  }

  /// Clears the Settings window ID when the window is closed.
  void clearSettingsWindowId() {
    _settingsWindowId = null;
    if (kDebugMode) {
      print('Settings window ID cleared');
    }
  }

  /// Brings the existing Settings window to front.
  Future<void> _bringSettingsWindowToFront() async {
    if (_settingsWindowId == null) return;

    try {
      final window = WindowController.fromWindowId(_settingsWindowId!);
      await window.show();

      if (kDebugMode) {
        print('Brought settings window to front: $_settingsWindowId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error bringing settings window to front: $e');
      }
    }
  }

  /// Registers a window as open.
  void registerWindow(String windowId) {
    _openWindows.add(windowId);
  }

  /// Unregisters a window when it closes.
  void unregisterWindow(String windowId) {
    _openWindows.remove(windowId);
    if (kDebugMode) {
      print('Unregistered PDF window: $windowId, remaining: $_openWindows');
    }
  }

  /// Checks if there are any open PDF viewer windows.
  bool get hasOpenWindows => _openWindows.isNotEmpty;

  /// Checks if the Settings window is currently open.
  bool get hasSettingsWindow => _settingsWindowId != null;

  /// Checks if Welcome window is hidden.
  bool get isWelcomeHidden => _welcomeHidden;

  /// Marks Welcome window as hidden.
  /// Called when PDF opens or when user closes Welcome while other windows exist.
  void setWelcomeHidden() {
    _welcomeHidden = true;
    if (kDebugMode) {
      print('Welcome window marked as hidden');
    }
  }

  /// Closes all open PDF viewer windows.
  Future<void> closeAllWindows() async {
    final windowIds = List<String>.from(_openWindows);
    for (final windowId in windowIds) {
      try {
        final controller = WindowController.fromWindowId(windowId);
        await controller.hide();
      } catch (_) {
        // Window may already be closed
      }
    }
    _openWindows.clear();
  }

  /// Closes the current window.
  ///
  /// Uses windowManager.close() which triggers onWindowClose() callback,
  /// allowing each window to handle its own cleanup and close behavior.
  Future<void> closeCurrentWindow() async {
    await windowManager.close();
  }

  /// Gets all window controllers.
  Future<List<WindowController>> getAllWindows() async {
    return WindowController.getAll();
  }
}
