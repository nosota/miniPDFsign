import 'package:flutter/services.dart';

/// Service for accessing native settings (UserDefaults on iOS, SharedPreferences on Android).
///
/// This bypasses Flutter's SharedPreferences plugin to access the same storage
/// as iOS Settings.bundle, allowing synchronization between in-app settings
/// and system Settings on iOS.
class NativeSettingsService {
  static const _channel = MethodChannel('com.ivanvaganov.minipdfsign/settings');

  /// Gets a string value from native settings.
  ///
  /// Returns null if the key doesn't exist or has no value.
  static Future<String?> getString(String key) async {
    try {
      final result = await _channel.invokeMethod<String>('getString', {
        'key': key,
      });
      return result;
    } on PlatformException {
      return null;
    }
  }

  /// Sets a string value in native settings.
  ///
  /// Pass null or empty string to remove the key.
  static Future<void> setString(String key, String? value) async {
    try {
      await _channel.invokeMethod<void>('setString', {
        'key': key,
        'value': value,
      });
    } on PlatformException {
      // Ignore errors - settings will fall back to defaults
    }
  }

  /// Gets all settings values.
  ///
  /// Returns a map with locale_preference and size_unit_preference keys.
  static Future<Map<String, String?>> getAll() async {
    try {
      final result = await _channel.invokeMethod<Map<Object?, Object?>>('getAll');
      if (result == null) {
        return {};
      }
      return result.map((key, value) => MapEntry(
        key as String,
        value as String?,
      ));
    } on PlatformException {
      return {};
    }
  }
}
