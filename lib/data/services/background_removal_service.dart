import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:minipdfsign/core/utils/logger.dart';
import 'package:path_provider/path_provider.dart';

/// Result of background removal operation.
class BackgroundRemovalResult {
  /// Path to the image with removed background (PNG with transparency).
  final String? outputPath;

  /// Error message if operation failed.
  final String? error;

  /// Whether the operation was successful.
  bool get isSuccess => outputPath != null;

  const BackgroundRemovalResult({this.outputPath, this.error});

  factory BackgroundRemovalResult.success(String path) =>
      BackgroundRemovalResult(outputPath: path);

  factory BackgroundRemovalResult.failure(String message) =>
      BackgroundRemovalResult(error: message);
}

/// Service for removing backgrounds from images using native ML APIs.
///
/// Uses:
/// - iOS 17+: Vision framework (VNGenerateForegroundInstanceMaskRequest) with color fallback
/// - iOS 15-16: Color-based removal (person segmentation not useful for stamps)
/// - Android: ML Kit Subject Segmentation API with color fallback
class BackgroundRemovalService {
  static const _channel = MethodChannel(
    'com.ivanvaganov.minipdfsign/background_removal',
  );

  /// Checks if background removal is available on this device.
  ///
  /// Returns true if the feature is supported on the current OS version.
  Future<bool> isAvailable() async {
    try {
      final result = await _channel.invokeMethod<bool>('isAvailable');
      return result ?? false;
    } on PlatformException catch (e) {
      AppLogger.error('Failed to check background removal availability', e);
      return false;
    } on MissingPluginException {
      // Plugin not registered - feature not available
      return false;
    }
  }

  /// Removes the background from an image.
  ///
  /// [inputPath] - Path to the source image.
  /// [outputPath] - Optional path for the output PNG. If not provided,
  ///                a temporary file will be created in app's temp directory.
  /// [backgroundColor] - Optional hint for the background color to remove.
  ///                     Improves accuracy when provided.
  ///
  /// Returns [BackgroundRemovalResult] with the output path or error.
  Future<BackgroundRemovalResult> removeBackground({
    required String inputPath,
    String? outputPath,
    ui.Color? backgroundColor,
  }) async {
    try {
      // Verify input file exists
      final inputFile = File(inputPath);
      if (!await inputFile.exists()) {
        return BackgroundRemovalResult.failure('Input file not found');
      }

      // Generate output path in temp directory if not provided
      final output = outputPath ?? await _generateOutputPath();

      // Build arguments
      final args = <String, dynamic>{
        'inputPath': inputPath,
        'outputPath': output,
      };

      // Add background color hint if provided
      if (backgroundColor != null) {
        args['backgroundColor'] = {
          'r': backgroundColor.red,
          'g': backgroundColor.green,
          'b': backgroundColor.blue,
        };
      }

      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'removeBackground',
        args,
      );

      if (result == null) {
        return BackgroundRemovalResult.failure('No response from native code');
      }

      final success = result['success'] as bool? ?? false;
      if (success) {
        final path = result['outputPath'] as String?;
        if (path != null) {
          AppLogger.info('Background removed successfully: $path');
          return BackgroundRemovalResult.success(path);
        }
        return BackgroundRemovalResult.failure('Output path not returned');
      } else {
        final error = result['error'] as String? ?? 'Unknown error';
        AppLogger.warning('Background removal failed: $error');
        return BackgroundRemovalResult.failure(error);
      }
    } on PlatformException catch (e) {
      AppLogger.error('Platform exception during background removal', e);
      return BackgroundRemovalResult.failure(e.message ?? 'Platform error');
    } on MissingPluginException {
      return BackgroundRemovalResult.failure('Feature not available');
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected error during background removal', e, stackTrace);
      return BackgroundRemovalResult.failure('Unexpected error');
    }
  }

  /// Generates a temporary output path in app's temp directory.
  Future<String> _generateOutputPath() async {
    final tempDir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '${tempDir.path}/bg_removed_$timestamp.png';
  }
}
