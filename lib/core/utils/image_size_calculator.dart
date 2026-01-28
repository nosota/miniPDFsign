import 'dart:math' as math;
import 'dart:ui';

/// Utility for calculating image sizes for PDF placement.
///
/// Provides consistent size calculation logic for both drag feedback
/// and actual image placement on PDF pages.
abstract final class ImageSizeCalculator {
  /// Default width ratio for placed images (40% of page width).
  static const double defaultWidthRatio = 0.40;

  /// Maximum dimension for drag feedback preview.
  static const double maxFeedbackSize = 300.0;

  /// Minimum dimension for drag feedback preview.
  static const double minFeedbackSize = 50.0;

  /// Maximum ratio of page dimension for placed images.
  static const double maxPageRatio = 0.9;

  /// Calculates the default size for an image placed on a PDF page.
  ///
  /// Uses 40% of page width as base, preserves aspect ratio,
  /// and ensures image doesn't exceed 90% of page dimensions.
  ///
  /// [aspectRatio] - Image width / height ratio
  /// [pageSize] - Size of the PDF page in points
  static Size calculatePlacedSize({
    required double aspectRatio,
    required Size pageSize,
  }) {
    final baseSize = pageSize.width * defaultWidthRatio;

    double width, height;

    if (aspectRatio > 1) {
      // Landscape
      width = baseSize;
      height = baseSize / aspectRatio;
    } else {
      // Portrait or square
      height = baseSize;
      width = baseSize * aspectRatio;
    }

    // Ensure it doesn't exceed page bounds
    if (width > pageSize.width * maxPageRatio) {
      width = pageSize.width * maxPageRatio;
      height = width / aspectRatio;
    }
    if (height > pageSize.height * maxPageRatio) {
      height = pageSize.height * maxPageRatio;
      width = height * aspectRatio;
    }

    return Size(width, height);
  }

  /// Calculates the drag feedback size for an image being dragged.
  ///
  /// Returns size that matches what the image will look like on screen
  /// when placed, accounting for current zoom scale.
  ///
  /// [aspectRatio] - Image width / height ratio
  /// [pageSize] - Size of the PDF page in points (optional)
  /// [scale] - Current zoom scale (1.0 = 100%)
  static Size calculateFeedbackSize({
    required double aspectRatio,
    Size? pageSize,
    double scale = 1.0,
  }) {
    double width, height;

    if (pageSize != null) {
      // Use actual PDF page dimensions
      final placedSize = calculatePlacedSize(
        aspectRatio: aspectRatio,
        pageSize: pageSize,
      );

      // Apply current zoom scale to match screen appearance
      width = placedSize.width * scale;
      height = placedSize.height * scale;
    } else {
      // Fallback: use max size if PDF not available
      if (aspectRatio > 1) {
        width = maxFeedbackSize;
        height = maxFeedbackSize / aspectRatio;
      } else {
        height = maxFeedbackSize;
        width = maxFeedbackSize * aspectRatio;
      }
    }

    // Apply max constraint for usability during drag
    final maxDimension = math.max(width, height);
    if (maxDimension > maxFeedbackSize) {
      final clampScale = maxFeedbackSize / maxDimension;
      width *= clampScale;
      height *= clampScale;
    }

    // Apply min constraint for visibility
    final minDimension = math.min(width, height);
    if (minDimension < minFeedbackSize) {
      final clampScale = minFeedbackSize / minDimension;
      width *= clampScale;
      height *= clampScale;
    }

    return Size(width, height);
  }
}
