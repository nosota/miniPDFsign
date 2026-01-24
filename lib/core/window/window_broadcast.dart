import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Callback type for dirty state changes.
typedef DirtyStateCallback = void Function(String windowId, bool isDirty);

/// Callback type for responding to dirty state requests.
typedef DirtyStateResponseCallback = void Function();

/// Callback type for Settings window opened event.
typedef SettingsOpenedCallback = void Function(String windowId);

/// Service for broadcasting messages between windows.
///
/// Uses desktop_multi_window's native inter-window communication
/// which is reliable across different Flutter engines.
class WindowBroadcast {
  WindowBroadcast._();

  static VoidCallback? _onUnitChanged;
  static VoidCallback? _onLocaleChanged;
  static VoidCallback? _onSaveAll;
  static VoidCallback? _onCloseAll;
  static VoidCallback? _onShowWelcome;
  static VoidCallback? _onHideWelcome;
  static DirtyStateCallback? _onDirtyStateChanged;
  static DirtyStateResponseCallback? _onRequestDirtyStates;
  static SettingsOpenedCallback? _onSettingsOpened;
  static VoidCallback? _onSettingsClosed;
  static bool _initialized = false;

  /// Sets callback for when size unit changes in another window.
  static void setOnUnitChanged(VoidCallback? callback) {
    _onUnitChanged = callback;
  }

  /// Sets callback for when locale changes in another window.
  static void setOnLocaleChanged(VoidCallback? callback) {
    _onLocaleChanged = callback;
  }

  /// Sets callback for when Save All is triggered from another window.
  static void setOnSaveAll(VoidCallback? callback) {
    _onSaveAll = callback;
  }

  /// Sets callback for when Close All is triggered from another window.
  ///
  /// PDF windows should close themselves without showing save dialog
  /// (the dialog was already shown by the initiating window).
  static void setOnCloseAll(VoidCallback? callback) {
    _onCloseAll = callback;
  }

  /// Sets callback for when Welcome window should be shown.
  ///
  /// Called when a sub-window is about to close and there are no other
  /// visible windows. Prevents macOS from terminating the app.
  static void setOnShowWelcome(VoidCallback? callback) {
    _onShowWelcome = callback;
  }

  /// Sets callback for when Welcome window should be hidden.
  ///
  /// Called when a PDF window opens from any window (not just Welcome).
  /// Welcome hides permanently and never shows again until app restart.
  static void setOnHideWelcome(VoidCallback? callback) {
    _onHideWelcome = callback;
  }

  /// Sets callback for when a window's dirty state changes.
  ///
  /// The callback receives the windowId and its new dirty state.
  static void setOnDirtyStateChanged(DirtyStateCallback? callback) {
    _onDirtyStateChanged = callback;
  }

  /// Sets callback for when another window requests dirty states.
  ///
  /// PDF windows should respond by broadcasting their current dirty state.
  static void setOnRequestDirtyStates(DirtyStateResponseCallback? callback) {
    _onRequestDirtyStates = callback;
  }

  /// Sets callback for when Settings window opens.
  ///
  /// The callback receives the Settings window ID.
  static void setOnSettingsOpened(SettingsOpenedCallback? callback) {
    _onSettingsOpened = callback;
  }

  /// Sets callback for when Settings window closes.
  static void setOnSettingsClosed(VoidCallback? callback) {
    _onSettingsClosed = callback;
  }

  /// Initializes the broadcast listener for this window.
  ///
  /// Must be called once during window startup to receive broadcasts.
  static Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    try {
      final currentWindow = await WindowController.fromCurrentEngine();
      await currentWindow.setWindowMethodHandler(_handleMethodCall);
    } catch (e) {
      if (kDebugMode) {
        print('WindowBroadcast: Failed to init: $e');
      }
    }
  }

  /// Broadcasts that size unit preference changed to all other windows.
  static Future<void> broadcastUnitChanged() async {
    await _broadcast('unitChanged');
  }

  /// Broadcasts that locale preference changed to all other windows.
  static Future<void> broadcastLocaleChanged() async {
    await _broadcast('localeChanged');
  }

  /// Broadcasts Save All command to all windows (including self).
  static Future<void> broadcastSaveAll() async {
    await _broadcastIncludingSelf('saveAll');
  }

  /// Broadcasts Close All command to all PDF windows (including self).
  ///
  /// PDF windows receiving this should close without showing save dialog
  /// (the save dialog was already shown by the initiating window).
  static Future<void> broadcastCloseAll() async {
    await _broadcastIncludingSelf('closeAll');
  }

  /// Broadcasts Show Welcome command to bring back the Welcome window.
  ///
  /// Should be called by sub-windows before they close to ensure
  /// there's always a visible window (prevents macOS app termination).
  static Future<void> broadcastShowWelcome() async {
    await _broadcast('showWelcome');
  }

  /// Broadcasts Hide Welcome command to hide the Welcome window permanently.
  ///
  /// Called when a PDF window opens from any window. Welcome hides and
  /// never shows again until app restart.
  ///
  /// Uses _broadcastIncludingSelf because the Welcome Screen itself may
  /// trigger this (via File→Open menu) and needs to receive the notification.
  static Future<void> broadcastHideWelcome() async {
    await _broadcastIncludingSelf('hideWelcome');
  }

  /// Broadcasts dirty state change to all other windows.
  ///
  /// Called by PDF windows when their dirty state changes.
  static Future<void> broadcastDirtyStateChanged(
    String windowId,
    bool isDirty,
  ) async {
    await _broadcastWithData('dirtyStateChanged', {
      'windowId': windowId,
      'isDirty': isDirty,
    });
  }

  /// Requests all PDF windows to broadcast their current dirty state.
  ///
  /// Called when a new window opens and needs to know the global dirty state.
  static Future<void> broadcastRequestDirtyStates() async {
    await _broadcast('requestDirtyStates');
  }

  /// Broadcasts that Settings window has opened with its window ID.
  ///
  /// Called when Settings window is created to notify all other windows.
  static Future<void> broadcastSettingsOpened(String windowId) async {
    await _broadcastWithData('settingsOpened', {'windowId': windowId});
  }

  /// Broadcasts that Settings window has closed.
  ///
  /// Called when Settings window closes to notify all other windows.
  static Future<void> broadcastSettingsClosed() async {
    await _broadcast('settingsClosed');
  }

  /// Internal method to broadcast a message to all other windows.
  static Future<void> _broadcast(String method) async {
    try {
      // Get all windows
      final allWindows = await WindowController.getAll();

      // Get current window ID to exclude self
      final currentWindow = await WindowController.fromCurrentEngine();
      final currentId = currentWindow.windowId;

      // Send to all other windows
      for (final window in allWindows) {
        if (window.windowId != currentId) {
          try {
            await window.invokeMethod(method, null);
          } catch (e) {
            // Window may be closed or not ready, ignore
            if (kDebugMode) {
              print(
                'WindowBroadcast: Failed to notify window ${window.windowId}: $e',
              );
            }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('WindowBroadcast: Failed to broadcast: $e');
      }
    }
  }

  /// Internal method to broadcast a message to all windows INCLUDING self.
  ///
  /// Used for Save All where the current window also needs to process the command.
  static Future<void> _broadcastIncludingSelf(String method) async {
    try {
      // Get all windows
      final allWindows = await WindowController.getAll();

      // Send to all windows (including self)
      for (final window in allWindows) {
        try {
          await window.invokeMethod(method, null);
        } catch (e) {
          // Window may be closed or not ready, ignore
          if (kDebugMode) {
            print(
              'WindowBroadcast: Failed to notify window ${window.windowId}: $e',
            );
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('WindowBroadcast: Failed to broadcast: $e');
      }
    }
  }

  /// Internal method to broadcast a message with data to all other windows.
  static Future<void> _broadcastWithData(
    String method,
    Map<String, dynamic> data,
  ) async {
    try {
      // Get all windows
      final allWindows = await WindowController.getAll();

      // Get current window ID to exclude self
      final currentWindow = await WindowController.fromCurrentEngine();
      final currentId = currentWindow.windowId;

      // Send to all other windows
      for (final window in allWindows) {
        if (window.windowId != currentId) {
          try {
            await window.invokeMethod(method, data);
          } catch (e) {
            // Window may be closed or not ready, ignore
            if (kDebugMode) {
              print(
                'WindowBroadcast: Failed to notify window ${window.windowId}: $e',
              );
            }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('WindowBroadcast: Failed to broadcast with data: $e');
      }
    }
  }

  static Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'unitChanged':
        _onUnitChanged?.call();
        return null;
      case 'localeChanged':
        _onLocaleChanged?.call();
        return null;
      case 'saveAll':
        _onSaveAll?.call();
        return null;
      case 'closeAll':
        _onCloseAll?.call();
        return null;
      case 'showWelcome':
        _onShowWelcome?.call();
        return null;
      case 'hideWelcome':
        _onHideWelcome?.call();
        return null;
      case 'dirtyStateChanged':
        final args = call.arguments as Map<dynamic, dynamic>?;
        if (args != null) {
          final windowId = args['windowId'] as String?;
          final isDirty = args['isDirty'] as bool?;
          if (windowId != null && isDirty != null) {
            _onDirtyStateChanged?.call(windowId, isDirty);
          }
        }
        return null;
      case 'requestDirtyStates':
        _onRequestDirtyStates?.call();
        return null;
      case 'settingsOpened':
        final args = call.arguments as Map<dynamic, dynamic>?;
        final windowId = args?['windowId'] as String?;
        if (windowId != null) {
          _onSettingsOpened?.call(windowId);
        }
        return null;
      case 'settingsClosed':
        _onSettingsClosed?.call();
        return null;
      default:
        return null;
    }
  }
}
