import 'dart:io';
import 'dart:ui' as ui;

import 'package:minipdfsign/core/constants/app_constants.dart';

/// Result of image validation.
class ImageValidationResult {
  /// Whether the image is valid.
  final bool isValid;

  /// Localization key for the error message (null if valid).
  final String? errorKey;

  /// Image width in pixels (null if validation failed before reading).
  final int? width;

  /// Image height in pixels (null if validation failed before reading).
  final int? height;

  /// File size in bytes (null if validation failed before reading).
  final int? fileSize;

  const ImageValidationResult._({
    required this.isValid,
    this.errorKey,
    this.width,
    this.height,
    this.fileSize,
  });

  /// Creates a valid result with image metadata.
  factory ImageValidationResult.valid({
    required int width,
    required int height,
    required int fileSize,
  }) {
    return ImageValidationResult._(
      isValid: true,
      width: width,
      height: height,
      fileSize: fileSize,
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
  /// Validates an image file.
  ///
  /// Checks:
  /// - File exists
  /// - File extension is allowed
  /// - File size is within limit
  /// - Image resolution is within limit
  ///
  /// Returns [ImageValidationResult] with validation status and metadata.
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

    // Check file size
    final fileSize = await file.length();
    if (fileSize > AppConstants.maxImageFileSize) {
      return ImageValidationResult.invalid('imageTooBig');
    }

    // Check resolution
    try {
      final bytes = await file.readAsBytes();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final width = frame.image.width;
      final height = frame.image.height;
      frame.image.dispose();

      if (width > AppConstants.maxImageResolution ||
          height > AppConstants.maxImageResolution) {
        return ImageValidationResult.invalid('imageResolutionTooHigh');
      }

      return ImageValidationResult.valid(
        width: width,
        height: height,
        fileSize: fileSize,
      );
    } catch (e) {
      return ImageValidationResult.invalid('unsupportedImageFormat');
    }
  }

  /// Checks if the file extension is allowed.
  bool isAllowedExtension(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    return AppConstants.allowedImageExtensions.contains(extension);
  }
}
