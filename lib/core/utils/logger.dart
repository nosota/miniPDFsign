import 'package:logger/logger.dart';

/// Application-wide logger utility.
///
/// Provides a consistent logging interface throughout the app.
/// Uses the logger package for formatted output.
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  /// Log debug information.
  static void debug(String message) {
    _logger.d(message);
  }

  /// Log general information.
  static void info(String message) {
    _logger.i(message);
  }

  /// Log warning.
  static void warning(String message) {
    _logger.w(message);
  }

  /// Log error with optional exception and stack trace.
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
