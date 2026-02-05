import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minipdfsign/core/utils/logger.dart';

/// Service for picking images from different sources.
class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();
  final ImageCropper _imageCropper = ImageCropper();

  /// Supported image extensions for file picker.
  ///
  /// Using FileType.custom with explicit extensions forces iOS to use
  /// UIDocumentPickerViewController (Files app) instead of PHPickerViewController
  /// (photo library). This allows users to pick images from Files, iCloud Drive,
  /// and other file providers.
  static const List<String> _supportedExtensions = [
    'png',
    'jpg',
    'jpeg',
    'gif',
    'webp',
    'bmp',
    'heic',
    'heif',
  ];

  /// Picks images from the file system (Files app on iOS, file manager on Android).
  ///
  /// Uses FilePicker with FileType.custom to open the system file picker.
  /// On iOS: Opens Files app / iCloud Drive / connected file providers.
  /// On Android: Opens system file picker with access to Downloads, Drive, etc.
  ///
  /// Returns list of file paths, or empty list if cancelled or error occurs.
  Future<List<String>> pickFromFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: _supportedExtensions,
        allowMultiple: true,
      );

      if (result == null || result.files.isEmpty) {
        return [];
      }

      final paths = result.files
          .where((f) => f.path != null)
          .map((f) => f.path!)
          .toList();

      AppLogger.debug('Picked ${paths.length} files from file system');
      return paths;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to pick files from file system', e, stackTrace);
      return [];
    }
  }

  /// Picks images from the device photo library/gallery.
  ///
  /// Uses ImagePicker to open the native photo picker.
  /// On iOS: Opens PHPickerViewController (photo library).
  /// On Android: Opens photo gallery.
  ///
  /// Returns list of file paths, or empty list if cancelled or error occurs.
  Future<List<String>> pickFromGallery() async {
    try {
      final images = await _imagePicker.pickMultiImage();

      if (images.isEmpty) {
        return [];
      }

      final paths = images.map((xFile) => xFile.path).toList();

      AppLogger.debug('Picked ${paths.length} images from gallery');
      return paths;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to pick images from gallery', e, stackTrace);
      return [];
    }
  }

  /// Takes a photo using the device camera with cropping support.
  ///
  /// Opens the native camera, then presents the image cropper.
  /// Returns the cropped image path, or null if cancelled or error occurs.
  /// Cleans up temporary files if cropping is cancelled.
  Future<String?> takePhoto() async {
    String? originalPath;

    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 90, // Compress to reduce file size
      );

      if (image == null) {
        AppLogger.debug('Camera capture cancelled');
        return null;
      }

      originalPath = image.path;
      AppLogger.debug('Photo taken: $originalPath');

      // Open cropper
      final croppedFile = await _imageCropper.cropImage(
        sourcePath: originalPath,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: '',
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            hideBottomControls: false,
          ),
          IOSUiSettings(
            title: '',
            resetAspectRatioEnabled: true,
            aspectRatioLockEnabled: false,
            rotateButtonsHidden: false,
            rotateClockwiseButtonHidden: true,
          ),
        ],
      );

      if (croppedFile == null) {
        AppLogger.debug('Cropping cancelled');
        // Clean up original camera file
        _deleteFileIfExists(originalPath);
        return null;
      }

      // If cropped file is different from original, clean up original
      if (croppedFile.path != originalPath) {
        _deleteFileIfExists(originalPath);
      }

      AppLogger.debug('Photo cropped: ${croppedFile.path}');
      return croppedFile.path;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to take photo', e, stackTrace);
      // Clean up on error
      if (originalPath != null) {
        _deleteFileIfExists(originalPath);
      }
      return null;
    }
  }

  /// Safely deletes a file if it exists.
  void _deleteFileIfExists(String path) {
    try {
      final file = File(path);
      if (file.existsSync()) {
        file.deleteSync();
        AppLogger.debug('Cleaned up temp file: $path');
      }
    } catch (e) {
      // Ignore cleanup errors
      AppLogger.debug('Failed to cleanup temp file: $path');
    }
  }
}
