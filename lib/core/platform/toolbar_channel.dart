import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Platform channel for communicating with native macOS toolbar.
///
/// Handles toolbar button actions from Swift side.
class ToolbarChannel {
  ToolbarChannel._();

  static const _channel = MethodChannel('com.pdfsign/toolbar');
  static VoidCallback? _onSharePressed;
  static bool _initialized = false;

  /// Initializes the toolbar channel.
  ///
  /// Should be called once during app startup.
  static void init() {
    if (_initialized) return;
    _initialized = true;
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  /// Sets the callback for when Share button is pressed in toolbar.
  ///
  /// Pass null to unregister the callback.
  static void setOnSharePressed(VoidCallback? callback) {
    _onSharePressed = callback;
  }

  /// Requests native toolbar setup for this window.
  ///
  /// Should be called only for PDF viewer windows that need the toolbar.
  /// Settings and other windows should NOT call this method.
  static Future<void> setupToolbar() async {
    if (kDebugMode) {
      print('ToolbarChannel: calling setupToolbar...');
    }
    try {
      await _channel.invokeMethod('setupToolbar');
      if (kDebugMode) {
        print('ToolbarChannel: setupToolbar call completed');
      }
    } catch (e) {
      if (kDebugMode) {
        print('ToolbarChannel: Failed to setup toolbar: $e');
      }
    }
  }

  static Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onSharePressed':
        _onSharePressed?.call();
      default:
        if (kDebugMode) {
          print('ToolbarChannel: Unknown method ${call.method}');
        }
    }
  }
}
