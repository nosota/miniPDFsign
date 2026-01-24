import 'package:flutter/material.dart';

/// Application shadow styles.
///
/// Per REQUIREMENTS.md UI-1.5.
abstract final class AppShadows {
  /// Subtle shadow for hover states and minor elevation.
  static const BoxShadow subtle = BoxShadow(
    color: Color(0x0A000000), // 4% black
    offset: Offset(0, 2),
    blurRadius: 8,
  );

  /// Medium shadow for cards and panels.
  static const BoxShadow medium = BoxShadow(
    color: Color(0x14000000), // 8% black
    offset: Offset(0, 4),
    blurRadius: 16,
  );

  /// Large shadow for dialogs and floating elements.
  static const BoxShadow large = BoxShadow(
    color: Color(0x1F000000), // 12% black
    offset: Offset(0, 8),
    blurRadius: 24,
  );

  // Pre-built lists for BoxDecoration.
  static const List<BoxShadow> subtleList = [subtle];
  static const List<BoxShadow> mediumList = [medium];
  static const List<BoxShadow> largeList = [large];
}
