import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Channel for managing sub-window lifecycle (Settings, PDF Viewer).
///
/// Unlike windowManager which only works with the main window,
/// this channel communicates with native code to control sub-windows
/// created by desktop_multi_window.
///
/// Usage:
/// ```dart
/// // In initState:
/// SubWindowChannel.setPreventClose(true);
/// SubWindowChannel.setOnWindowClose(_handleWindowClose);
/// SubWindowChannel.setOnWindowFocus(_handleFocus);
/// SubWindowChannel.setOnWindowBlur(_handleBlur);
///
/// // When ready to close:
/// await SubWindowChannel.destroy();
/// ```
class SubWindowChannel {
  SubWindowChannel._();

  static const _channel = MethodChannel('com.pdfsign/window');
  static VoidCallback? _onWindowClose;
  static VoidCallback? _onWindowFocus;
  static VoidCallback? _onWindowBlur;
  static bool _initialized = false;

  /// Sets callback for window close events (system close button or Cmd+W).
  ///
  /// The callback is called when user tries to close the window.
  /// After handling (e.g., showing save dialog), call [destroy] to close.
  static void setOnWindowClose(VoidCallback? callback) {
    _onWindowClose = callback;
    _ensureInitialized();
  }

  /// Sets callback for window focus events.
  static void setOnWindowFocus(VoidCallback? callback) {
    _onWindowFocus = callback;
    _ensureInitialized();
  }

  /// Sets callback for window blur (lost focus) events.
  static void setOnWindowBlur(VoidCallback? callback) {
    _onWindowBlur = callback;
    _ensureInitialized();
  }

  /// Ensures method call handler is set up.
  static void _ensureInitialized() {
    if (_initialized) return;
    _initialized = true;

    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onWindowClose':
          _onWindowClose?.call();
          return null;
        case 'onWindowFocus':
          _onWindowFocus?.call();
          return null;
        case 'onWindowBlur':
          _onWindowBlur?.call();
          return null;
        default:
          return null;
      }
    });
  }

  /// Enables close prevention for this sub-window.
  ///
  /// When enabled, clicking the close button or Cmd+W will trigger
  /// [onWindowClose] callback instead of closing immediately.
  /// Call [destroy] when ready to actually close.
  static Future<void> setPreventClose(bool prevent) async {
    _ensureInitialized();
    try {
      await _channel.invokeMethod('setPreventClose', prevent);
    } catch (e) {
      if (kDebugMode) {
        print('SubWindowChannel.setPreventClose error: $e');
      }
    }
  }

  /// Requests window close (triggers delegate if preventClose is enabled).
  ///
  /// This is equivalent to clicking the close button.
  /// If preventClose is enabled, [onWindowClose] will be called.
  static Future<void> close() async {
    try {
      await _channel.invokeMethod('close');
    } catch (e) {
      if (kDebugMode) {
        print('SubWindowChannel.close error: $e');
      }
    }
  }

  /// Force closes the window without triggering delegate.
  ///
  /// Use this after handling close confirmation (save dialog, etc.).
  static Future<void> destroy() async {
    try {
      await _channel.invokeMethod('destroy');
    } catch (e) {
      if (kDebugMode) {
        print('SubWindowChannel.destroy error: $e');
      }
    }
  }

  /// Hides the window without closing it.
  static Future<void> hide() async {
    try {
      await _channel.invokeMethod('hide');
    } catch (e) {
      if (kDebugMode) {
        print('SubWindowChannel.hide error: $e');
      }
    }
  }

  /// Shows and focuses the window.
  static Future<void> show() async {
    try {
      await _channel.invokeMethod('show');
    } catch (e) {
      if (kDebugMode) {
        print('SubWindowChannel.show error: $e');
      }
    }
  }

  /// Cleans up resources. Call in dispose.
  static void dispose() {
    _onWindowClose = null;
  }
}
