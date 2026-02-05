import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:minipdfsign/core/utils/logger.dart';

/// Result of background detection analysis.
class BackgroundDetectionResult {
  /// Whether the image has a uniform (solid) background.
  final bool hasUniformBackground;

  /// Whether the image already has transparency (alpha channel with non-opaque pixels).
  final bool hasTransparency;

  /// Detected background color (if uniform).
  final ui.Color? backgroundColor;

  /// Standard deviation of perimeter colors (lower = more uniform).
  final double colorVariance;

  const BackgroundDetectionResult({
    required this.hasUniformBackground,
    required this.hasTransparency,
    this.backgroundColor,
    required this.colorVariance,
  });

  /// Returns true if background removal should be offered.
  bool get shouldOfferBackgroundRemoval =>
      hasUniformBackground && !hasTransparency;
}

/// Service for detecting uniform backgrounds in images.
///
/// Uses a perimeter sampling algorithm to determine if an image
/// has a solid-color background suitable for removal.
class BackgroundDetectionService {
  /// Number of pixels to sample along each edge of the perimeter.
  static const int _samplesPerEdge = 20;

  /// Maximum allowed color variance (standard deviation) for uniform background.
  /// Lower values = stricter uniformity requirement.
  static const double _maxColorVariance = 25.0;

  /// Minimum alpha value to consider a pixel as transparent.
  static const int _transparencyThreshold = 250;

  /// Analyzes an image to detect if it has a uniform background.
  ///
  /// Returns a [BackgroundDetectionResult] with analysis details.
  Future<BackgroundDetectionResult> analyzeImage(String imagePath) async {
    ui.Codec? codec;
    ui.Image? image;

    try {
      final file = File(imagePath);
      if (!await file.exists()) {
        AppLogger.warning('Image file not found: $imagePath');
        return const BackgroundDetectionResult(
          hasUniformBackground: false,
          hasTransparency: false,
          colorVariance: double.infinity,
        );
      }

      final bytes = await file.readAsBytes();
      codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      image = frame.image;

      // Safely get byte data - can return null for some formats
      final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      if (byteData == null) {
        AppLogger.warning('Failed to get byte data for image: $imagePath');
        return const BackgroundDetectionResult(
          hasUniformBackground: false,
          hasTransparency: false,
          colorVariance: double.infinity,
        );
      }

      final result = await compute(
        _analyzeImageIsolate,
        _ImageAnalysisParams(
          width: image.width,
          height: image.height,
          bytes: byteData.buffer.asUint8List(),
        ),
      );

      return result;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to analyze image background', e, stackTrace);
      return const BackgroundDetectionResult(
        hasUniformBackground: false,
        hasTransparency: false,
        colorVariance: double.infinity,
      );
    } finally {
      // Always cleanup resources
      image?.dispose();
      codec?.dispose();
    }
  }
}

/// Parameters for isolated image analysis.
class _ImageAnalysisParams {
  final int width;
  final int height;
  final Uint8List bytes;

  const _ImageAnalysisParams({
    required this.width,
    required this.height,
    required this.bytes,
  });
}

/// Isolated function to analyze image background.
BackgroundDetectionResult _analyzeImageIsolate(_ImageAnalysisParams params) {
  final width = params.width;
  final height = params.height;
  final pixels = params.bytes;

  // Check for transparency first
  bool hasTransparency = false;
  for (int i = 3; i < pixels.length; i += 4) {
    if (pixels[i] < BackgroundDetectionService._transparencyThreshold) {
      hasTransparency = true;
      break;
    }
  }

  if (hasTransparency) {
    return const BackgroundDetectionResult(
      hasUniformBackground: false,
      hasTransparency: true,
      colorVariance: 0,
    );
  }

  // Sample perimeter pixels
  final perimeterColors = <_RgbColor>[];

  // Helper to get pixel color at (x, y)
  _RgbColor getPixelColor(int x, int y) {
    final index = (y * width + x) * 4;
    return _RgbColor(
      pixels[index], // R
      pixels[index + 1], // G
      pixels[index + 2], // B
    );
  }

  // Sample top edge
  for (int i = 0; i < BackgroundDetectionService._samplesPerEdge; i++) {
    final x = (i * width) ~/ BackgroundDetectionService._samplesPerEdge;
    perimeterColors.add(getPixelColor(x, 0));
  }

  // Sample bottom edge
  for (int i = 0; i < BackgroundDetectionService._samplesPerEdge; i++) {
    final x = (i * width) ~/ BackgroundDetectionService._samplesPerEdge;
    perimeterColors.add(getPixelColor(x, height - 1));
  }

  // Sample left edge
  for (int i = 0; i < BackgroundDetectionService._samplesPerEdge; i++) {
    final y = (i * height) ~/ BackgroundDetectionService._samplesPerEdge;
    perimeterColors.add(getPixelColor(0, y));
  }

  // Sample right edge
  for (int i = 0; i < BackgroundDetectionService._samplesPerEdge; i++) {
    final y = (i * height) ~/ BackgroundDetectionService._samplesPerEdge;
    perimeterColors.add(getPixelColor(width - 1, y));
  }

  // Calculate mean color
  double sumR = 0, sumG = 0, sumB = 0;
  for (final color in perimeterColors) {
    sumR += color.r;
    sumG += color.g;
    sumB += color.b;
  }
  final meanR = sumR / perimeterColors.length;
  final meanG = sumG / perimeterColors.length;
  final meanB = sumB / perimeterColors.length;

  // Calculate variance (standard deviation of Euclidean distance from mean)
  double sumSquaredDist = 0;
  for (final color in perimeterColors) {
    final dr = color.r - meanR;
    final dg = color.g - meanG;
    final db = color.b - meanB;
    sumSquaredDist += dr * dr + dg * dg + db * db;
  }
  final variance = math.sqrt(sumSquaredDist / perimeterColors.length);

  final hasUniformBackground =
      variance <= BackgroundDetectionService._maxColorVariance;

  return BackgroundDetectionResult(
    hasUniformBackground: hasUniformBackground,
    hasTransparency: false,
    backgroundColor: hasUniformBackground
        ? ui.Color.fromARGB(255, meanR.round(), meanG.round(), meanB.round())
        : null,
    colorVariance: variance,
  );
}

/// Simple RGB color representation.
class _RgbColor {
  final int r;
  final int g;
  final int b;

  const _RgbColor(this.r, this.g, this.b);
}
