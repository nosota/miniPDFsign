import 'dart:io' show Platform;

/// Platform detection utilities.
///
/// Provides simple checks for desktop vs mobile platforms.
abstract final class PlatformUtils {
  /// Returns true if running on desktop (macOS, Windows, Linux).
  static bool get isDesktop =>
      Platform.isMacOS || Platform.isWindows || Platform.isLinux;

  /// Returns true if running on mobile (iOS, Android).
  static bool get isMobile => Platform.isIOS || Platform.isAndroid;

  /// Returns true if running on macOS.
  static bool get isMacOS => Platform.isMacOS;

  /// Returns true if running on Windows.
  static bool get isWindows => Platform.isWindows;

  /// Returns true if running on Linux.
  static bool get isLinux => Platform.isLinux;

  /// Returns true if running on iOS.
  static bool get isIOS => Platform.isIOS;

  /// Returns true if running on Android.
  static bool get isAndroid => Platform.isAndroid;
}
