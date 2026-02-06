import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'package:minipdfsign/core/utils/logger.dart';

/// Result of image normalization.
class NormalizationResult {
  /// Path to the normalized image (or original if no normalization needed).
  final String path;

  /// Width of the image after EXIF orientation is applied.
  final int width;

  /// Height of the image after EXIF orientation is applied.
  final int height;

  /// Whether the image was actually normalized (EXIF rotation applied).
  final bool wasNormalized;

  const NormalizationResult({
    required this.path,
    required this.width,
    required this.height,
    required this.wasNormalized,
  });

  double get aspectRatio => width / height;
}

/// Service for normalizing image EXIF orientation.
///
/// Some images (especially from cameras) have EXIF rotation metadata
/// that specifies how the image should be displayed. This service
/// "bakes" that rotation into the actual pixel data, so the image
/// displays correctly in all contexts (including PDF export).
class ImageNormalizationService {
  static const _normalizedFolderName = 'normalized';
  final Uuid _uuid = const Uuid();

  /// Gets the directory for normalized images.
  Future<Directory> _getNormalizedDirectory() async {
    final appSupport = await getApplicationSupportDirectory();
    final normalizedDir = Directory(
      path.join(appSupport.path, _normalizedFolderName),
    );

    if (!await normalizedDir.exists()) {
      await normalizedDir.create(recursive: true);
    }

    return normalizedDir;
  }

  /// Normalizes an image's EXIF orientation.
  ///
  /// If the image has EXIF rotation metadata (orientation != 1),
  /// decodes the image, applies the rotation, and saves as PNG.
  ///
  /// Returns [NormalizationResult] with:
  /// - Path to normalized image (or original if no normalization needed)
  /// - Correct width/height after orientation is applied
  ///
  /// Throws exception if image cannot be read or decoded.
  Future<NormalizationResult> normalizeImage(String inputPath) async {
    final inputFile = File(inputPath);
    if (!await inputFile.exists()) {
      throw FileSystemException('Image file not found', inputPath);
    }

    final bytes = await inputFile.readAsBytes();

    // Decode image with EXIF data
    final image = img.decodeImage(bytes);
    if (image == null) {
      throw FormatException('Failed to decode image: $inputPath');
    }

    // Check if EXIF orientation needs fixing
    final needsNormalization = _needsExifNormalization(image);

    if (!needsNormalization) {
      // No normalization needed - return original path with dimensions
      AppLogger.debug('Image does not need EXIF normalization: $inputPath');
      return NormalizationResult(
        path: inputPath,
        width: image.width,
        height: image.height,
        wasNormalized: false,
      );
    }

    AppLogger.debug('Normalizing EXIF orientation for: $inputPath');

    // Apply EXIF orientation (rotates pixels and clears EXIF orientation tag)
    final normalized = img.bakeOrientation(image);

    // Save as PNG (lossless, preserves transparency)
    final pngBytes = img.encodePng(normalized);

    // Generate unique filename
    final normalizedDir = await _getNormalizedDirectory();
    final outputPath = path.join(normalizedDir.path, '${_uuid.v4()}.png');

    await File(outputPath).writeAsBytes(pngBytes);

    AppLogger.debug(
      'Image normalized: ${image.width}x${image.height} -> '
      '${normalized.width}x${normalized.height}, saved to: $outputPath',
    );

    return NormalizationResult(
      path: outputPath,
      width: normalized.width,
      height: normalized.height,
      wasNormalized: true,
    );
  }

  /// Checks if image has EXIF orientation that needs normalization.
  ///
  /// Returns true if orientation is anything other than "normal" (1).
  bool _needsExifNormalization(img.Image image) {
    // The image package stores EXIF data in image.exif
    // Orientation tag (0x0112) values:
    // 1 = Normal (no rotation needed)
    // 2 = Flipped horizontally
    // 3 = Rotated 180°
    // 4 = Flipped vertically
    // 5 = Rotated 90° CCW and flipped horizontally
    // 6 = Rotated 90° CW
    // 7 = Rotated 90° CW and flipped horizontally
    // 8 = Rotated 90° CCW

    final exif = image.exif;
    if (exif.isEmpty) {
      return false;
    }

    // Check for orientation tag in EXIF IFD0
    final orientationData = exif.imageIfd[0x0112];
    if (orientationData == null) {
      return false;
    }

    // Get orientation value
    final orientation = orientationData.toInt();

    // Orientation 1 means no rotation needed
    return orientation != 1;
  }

  /// Gets oriented dimensions without full normalization.
  ///
  /// Useful when you just need to know the final dimensions
  /// but don't need to create a normalized file yet.
  Future<(int width, int height)> getOrientedDimensions(String imagePath) async {
    final bytes = await File(imagePath).readAsBytes();
    final image = img.decodeImage(bytes);

    if (image == null) {
      throw FormatException('Failed to decode image: $imagePath');
    }

    if (!_needsExifNormalization(image)) {
      return (image.width, image.height);
    }

    // Apply orientation to get correct dimensions
    final oriented = img.bakeOrientation(image);
    return (oriented.width, oriented.height);
  }

  /// Normalizes image bytes in memory (without saving to file).
  ///
  /// Returns normalized PNG bytes and dimensions.
  /// Useful for one-time operations like PDF conversion.
  Future<(Uint8List bytes, int width, int height)> normalizeBytes(
    Uint8List inputBytes,
  ) async {
    final image = img.decodeImage(inputBytes);
    if (image == null) {
      throw const FormatException('Failed to decode image bytes');
    }

    // Always bake orientation (no-op if not needed)
    final normalized = img.bakeOrientation(image);

    // Encode to PNG
    final pngBytes = Uint8List.fromList(img.encodePng(normalized));

    return (pngBytes, normalized.width, normalized.height);
  }

  /// Deletes a normalized image file.
  Future<void> deleteNormalizedImage(String normalizedPath) async {
    // Only delete if it's in our normalized folder
    if (!normalizedPath.contains(_normalizedFolderName)) {
      return;
    }

    final file = File(normalizedPath);
    if (await file.exists()) {
      await file.delete();
      AppLogger.debug('Deleted normalized image: $normalizedPath');
    }
  }

  /// Cleans up old normalized images (older than specified duration).
  Future<void> cleanupOldNormalizedImages({
    Duration maxAge = const Duration(days: 7),
  }) async {
    try {
      final normalizedDir = await _getNormalizedDirectory();
      final cutoff = DateTime.now().subtract(maxAge);

      final files = await normalizedDir.list().toList();
      for (final entity in files) {
        if (entity is File) {
          final stat = await entity.stat();
          if (stat.modified.isBefore(cutoff)) {
            await entity.delete();
            AppLogger.debug('Cleaned up old normalized image: ${entity.path}');
          }
        }
      }
    } catch (e) {
      AppLogger.debug('Failed to cleanup normalized images: $e');
    }
  }
}
