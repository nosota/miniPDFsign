import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minipdfsign/core/utils/logger.dart';

/// Service for picking images from different sources.
class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();

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
}
