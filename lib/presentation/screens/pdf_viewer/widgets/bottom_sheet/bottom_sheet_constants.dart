import 'package:flutter/material.dart';

/// Constants for the image library bottom sheet.
abstract final class BottomSheetConstants {
  /// Height of the collapsed bottom sheet.
  static const double collapsedHeight = 80.0;

  /// Height of the drag handle touch area (Apple HIG: min 44pt).
  static const double dragHandleHeight = 48.0;

  /// Size of thumbnails in collapsed state.
  static const double thumbnailSizeCollapsed = 56.0;

  /// Padding around thumbnails.
  static const double thumbnailPadding = 8.0;

  /// Border radius for thumbnails.
  static const double thumbnailBorderRadius = 8.0;

  /// Spacing between grid items.
  static const double gridSpacing = 8.0;

  /// Number of columns in the grid.
  static const int gridColumns = 4;

  /// Size of the drag handle.
  static const Size dragHandleSize = Size(40, 4);

  /// Border radius of the drag handle.
  static const double dragHandleRadius = 2.0;

  /// Background color of the bottom sheet.
  static const Color backgroundColor = Colors.white;

  /// Color of the drag handle.
  static const Color dragHandleColor = Color(0xFFD1D1D6);

  /// Color of the drag handle when active/pressed.
  static const Color dragHandleActiveColor = Color(0xFF8E8E93);

  /// Background color for image thumbnails (for transparent PNGs).
  static const Color thumbnailBackgroundColor = Color(0xFFF2F2F7);

  /// Snap sizes for DraggableScrollableSheet.
  static const double collapsedSize = 0.12;
  static const double halfExpandedSize = 0.40;
  static const double expandedSize = 0.85;

  /// Threshold to determine if sheet is in collapsed state.
  static const double collapsedThreshold = 0.20;

  /// Snap animation duration for smoother transitions.
  static const Duration snapAnimationDuration = Duration(milliseconds: 150);

  /// Header height in expanded state.
  static const double headerHeight = 44.0;

  /// Delete button size in edit mode.
  static const double deleteButtonSize = 24.0;
}
