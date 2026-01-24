import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:pdfsign/domain/entities/window_info.dart';

/// Platform channel for Window menu operations.
///
/// Provides methods to:
/// - Get list of all visible application windows
/// - Focus a specific window by ID
/// - Minimize, zoom, and bring all windows to front
class WindowListChannel {
  WindowListChannel._();

  static const _channel = MethodChannel('com.pdfsign/window_list');

  /// Gets the list of all visible application windows.
  ///
  /// Returns windows in order they were opened (oldest first).
  /// Hidden windows (like Welcome when PDF is open) are not included.
  static Future<List<WindowInfo>> getWindowList() async {
    try {
      final result = await _channel.invokeMethod<List<dynamic>>('getWindowList');
      if (result == null) return [];

      return result
          .cast<Map<dynamic, dynamic>>()
          .map((e) => WindowInfo.fromMap(e))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('WindowListChannel.getWindowList error: $e');
      }
      return [];
    }
  }

  /// Brings the specified window to front.
  ///
  /// Returns true if the window was found and focused, false otherwise.
  static Future<bool> focusWindow(String windowId) async {
    try {
      final result = await _channel.invokeMethod<bool>('focusWindow', windowId);
      return result ?? false;
    } catch (e) {
      if (kDebugMode) {
        print('WindowListChannel.focusWindow error: $e');
      }
      return false;
    }
  }

  /// Minimizes the current window to the Dock.
  static Future<void> minimizeWindow() async {
    try {
      await _channel.invokeMethod<void>('minimizeWindow');
    } catch (e) {
      if (kDebugMode) {
        print('WindowListChannel.minimizeWindow error: $e');
      }
    }
  }

  /// Zooms (maximizes) the current window.
  static Future<void> zoomWindow() async {
    try {
      await _channel.invokeMethod<void>('zoomWindow');
    } catch (e) {
      if (kDebugMode) {
        print('WindowListChannel.zoomWindow error: $e');
      }
    }
  }

  /// Brings all application windows to front.
  static Future<void> bringAllToFront() async {
    try {
      await _channel.invokeMethod<void>('bringAllToFront');
    } catch (e) {
      if (kDebugMode) {
        print('WindowListChannel.bringAllToFront error: $e');
      }
    }
  }
}
