import 'package:flutter/material.dart';

/// Constants for PDF viewer visual styling.
///
/// Based on macOS Preview appearance.
abstract final class PdfViewerConstants {
  /// Background color of the viewer container (#E5E5E5).
  static const Color backgroundColor = Color(0xFFE5E5E5);

  /// Background color of PDF pages (white).
  static const Color pageBackground = Color(0xFFFFFFFF);

  /// Border radius for PDF pages.
  static const double pageBorderRadius = 2.0;

  /// Vertical gap between pages.
  static const double pageGap = 24.0;

  /// Padding above the first page and below the last page.
  static const double verticalPadding = 40.0;

  /// Horizontal padding on both sides of pages.
  static const double horizontalPadding = 40.0;

  /// Shadow for PDF pages (macOS-style soft shadow).
  static const List<BoxShadow> pageShadow = [
    BoxShadow(
      color: Color(0x1F000000),
      offset: Offset(0, 2),
      blurRadius: 8,
    ),
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 1),
      blurRadius: 3,
    ),
  ];

  /// Minimum scale for rendering (performance optimization).
  static const double minRenderScale = 0.25;

  /// Maximum scale for rendering.
  static const double maxRenderScale = 3.0;

  /// Duration for page indicator auto-hide.
  static const Duration pageIndicatorHideDuration = Duration(milliseconds: 2000);

  /// Duration for page indicator fade animation.
  static const Duration pageIndicatorFadeDuration = Duration(milliseconds: 200);

  /// Debounce duration for zoom gestures.
  static const Duration zoomDebounceDuration = Duration(milliseconds: 150);

  /// Number of pages to buffer around visible area.
  static const int pageBufferCount = 2;

  /// Maximum number of pages to keep in memory cache.
  static const int maxCachedPages = 10;
}
