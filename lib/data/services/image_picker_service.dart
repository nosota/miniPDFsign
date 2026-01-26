import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

/// Service for picking images from different sources.
class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();

  /// Picks images from the file system.
  ///
  /// Uses FilePicker to open the system file picker.
  /// Returns list of file paths, or empty list if cancelled.
  Future<List<String>> pickFromFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result == null || result.files.isEmpty) {
      return [];
    }

    return result.files
        .where((f) => f.path != null)
        .map((f) => f.path!)
        .toList();
  }

  /// Picks images from the device gallery.
  ///
  /// Uses ImagePicker to open the photo library.
  /// Returns list of file paths, or empty list if cancelled.
  Future<List<String>> pickFromGallery() async {
    final images = await _imagePicker.pickMultiImage();

    if (images.isEmpty) {
      return [];
    }

    return images.map((xFile) => xFile.path).toList();
  }
}
