import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Channel for managing Settings window singleton across all Flutter engines.
///
/// Uses native-side storage to ensure only one Settings window can exist,
/// regardless of which engine tries to open it.
///
/// Usage:
/// ```dart
/// // Check if Settings already exists and focus it
/// final focused = await SettingsSingletonChannel.focusExistingSettings();
/// if (focused) return; // Settings was brought to front
///
/// // Create new Settings window
/// final window = await WindowController.create(configuration);
/// await SettingsSingletonChannel.setSettingsWindowId(window.windowId);
/// ```
class SettingsSingletonChannel {
  SettingsSingletonChannel._();

  static const _channel = MethodChannel('com.pdfsign/settings_singleton');

  /// Gets the current Settings window ID from native storage.
  /// Returns null if no Settings window is open.
  static Future<String?> getSettingsWindowId() async {
    if (kDebugMode) {
      print('SettingsSingletonChannel.getSettingsWindowId: calling native...');
    }
    try {
      final result = await _channel.invokeMethod<String?>('getSettingsWindowId');
      if (kDebugMode) {
        print('SettingsSingletonChannel.getSettingsWindowId: result=$result');
      }
      return result;
    } catch (e) {
      if (kDebugMode) {
        print('SettingsSingletonChannel.getSettingsWindowId ERROR: $e');
      }
      return null;
    }
  }

  /// Stores the Settings window ID in native storage.
  /// Call this after creating a new Settings window.
  static Future<void> setSettingsWindowId(String windowId) async {
    try {
      await _channel.invokeMethod('setSettingsWindowId', windowId);
      if (kDebugMode) {
        print('SettingsSingletonChannel.setSettingsWindowId: $windowId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('SettingsSingletonChannel.setSettingsWindowId error: $e');
      }
    }
  }

  /// Clears the Settings window ID from native storage.
  /// Call this when Settings window closes.
  static Future<void> clearSettingsWindowId() async {
    try {
      await _channel.invokeMethod('clearSettingsWindowId');
      if (kDebugMode) {
        print('SettingsSingletonChannel.clearSettingsWindowId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('SettingsSingletonChannel.clearSettingsWindowId error: $e');
      }
    }
  }

  /// Attempts to focus an existing Settings window.
  /// Returns true if Settings was found and focused, false otherwise.
  static Future<bool> focusExistingSettings() async {
    try {
      final result =
          await _channel.invokeMethod<bool>('focusSettingsWindow') ?? false;
      if (kDebugMode) {
        print('SettingsSingletonChannel.focusExistingSettings: $result');
      }
      return result;
    } catch (e) {
      if (kDebugMode) {
        print('SettingsSingletonChannel.focusExistingSettings error: $e');
      }
      return false;
    }
  }
}
