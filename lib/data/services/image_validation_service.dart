import 'dart:io';

import 'package:minipdfsign/core/constants/app_constants.dart';
import 'package:minipdfsign/core/utils/logger.dart';
import 'package:minipdfsign/data/services/image_normalization_service.dart';

/// Result of image validation.
class ImageValidationResult {
  /// Whether the image is valid.
  final bool isValid;

  /// Localization key for the error message (null if valid).
  final String? errorKey;

  /// Image width in pixels after EXIF orientation (null if validation failed).
  final int? width;

  /// Image height in pixels after EXIF orientation (null if validation failed).
  final int? height;

  /// File size in bytes (null if validation failed before reading).
  final int? fileSize;

  /// Path to the normalized image (with EXIF rotation baked in).
  /// May be the same as original path if no normalization was needed.
  final String? normalizedPath;

  const ImageValidationResult._({
    required this.isValid,
    this.errorKey,
    this.width,
    this.height,
    this.fileSize,
    this.normalizedPath,
  });

  /// Creates a valid result with image metadata.
  factory ImageValidationResult.valid({
    required int width,
    required int height,
    required int fileSize,
    required String normalizedPath,
  }) {
    return ImageValidationResult._(
      isValid: true,
      width: width,
      height: height,
      fileSize: fileSize,
      normalizedPath: normalizedPath,
    );
  }

  /// Creates an invalid result with error key.
  factory ImageValidationResult.invalid(String errorKey) {
    return ImageValidationResult._(
      isValid: false,
      errorKey: errorKey,
    );
  }
}

/// Service for validating images before adding to library.
class ImageValidationService {
  final ImageNormalizationService _normalizationService;

  ImageValidationService(this._normalizationService);

  /// Validates an image file and normalizes EXIF orientation.
  ///
  /// Checks:
  /// - File exists
  /// - File extension is allowed
  /// - File size is within limit
  /// - Image resolution is within limit (after EXIF orientation)
  ///
  /// If the image has EXIF rotation, it will be normalized (rotation baked in)
  /// and the normalized path will be returned.
  ///
  /// Returns [ImageValidationResult] with validation status, metadata,
  /// and normalized path.
  Future<ImageValidationResult> validateImage(String filePath) async {
    final file = File(filePath);

    // Check file exists
    if (!await file.exists()) {
      return ImageValidationResult.invalid('fileNotFound');
    }

    // Check extension
    if (!isAllowedExtension(filePath)) {
      return ImageValidationResult.invalid('unsupportedImageFormat');
    }

    // Check file size (original file)
    final fileSize = await file.length();
    if (fileSize > AppConstants.maxImageFileSize) {
      return ImageValidationResult.invalid('imageTooBig');
    }

    // Normalize EXIF and get correct dimensions
    try {
      final normResult = await _normalizationService.normalizeImage(filePath);

      // Check resolution (after EXIF orientation is applied)
      if (normResult.width > AppConstants.maxImageResolution ||
          normResult.height > AppConstants.maxImageResolution) {
        // Clean up normalized file if we created one
        if (normResult.wasNormalized) {
          await _normalizationService.deleteNormalizedImage(normResult.path);
        }
        return ImageValidationResult.invalid('imageResolutionTooHigh');
      }

      AppLogger.debug(
        'Image validated: ${normResult.width}x${normResult.height}, '
        'normalized: ${normResult.wasNormalized}',
      );

      return ImageValidationResult.valid(
        width: normResult.width,
        height: normResult.height,
        fileSize: fileSize,
        normalizedPath: normResult.path,
      );
    } catch (e) {
      AppLogger.error('Failed to validate/normalize image', e);
      return ImageValidationResult.invalid('unsupportedImageFormat');
    }
  }

  /// Checks if the file extension is allowed.
  bool isAllowedExtension(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    return AppConstants.allowedImageExtensions.contains(extension);
  }
}
