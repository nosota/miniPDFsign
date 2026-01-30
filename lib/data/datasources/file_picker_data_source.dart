import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:minipdfsign/data/services/image_to_pdf_service.dart';

/// Result of picking a file that can be PDF or image.
class PickedFileResult {
  const PickedFileResult({
    required this.path,
    required this.isPdf,
  });

  /// Path to the selected file.
  final String path;

  /// Whether the file is a PDF (true) or an image (false).
  final bool isPdf;
}

/// Data source wrapping the file_picker package.
abstract class FilePickerDataSource {
  /// Opens native file picker for PDF selection.
  Future<String?> pickPdfFile();

  /// Opens native file picker for PDF or image selection.
  Future<PickedFileResult?> pickPdfOrImage();

  /// Checks if a file exists at the given path.
  Future<bool> fileExists(String path);

  /// Gets the file size in bytes.
  Future<int> getFileSize(String path);
}

/// Supported file extensions for the combined PDF/image picker.
const _supportedExtensions = [
  'pdf',
  'jpg',
  'jpeg',
  'png',
  'gif',
  'webp',
  'bmp',
  'heic',
  'heif',
  'tiff',
  'tif',
];

/// Implementation of [FilePickerDataSource].
class FilePickerDataSourceImpl implements FilePickerDataSource {
  @override
  Future<String?> pickPdfFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
      withData: false, // Don't load file content into memory
      withReadStream: false,
    );

    return result?.files.single.path;
  }

  @override
  Future<PickedFileResult?> pickPdfOrImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: _supportedExtensions,
      allowMultiple: false,
      withData: false,
      withReadStream: false,
    );

    final path = result?.files.single.path;
    if (path == null) return null;

    final isPdf = path.toLowerCase().endsWith('.pdf');
    return PickedFileResult(path: path, isPdf: isPdf);
  }

  @override
  Future<bool> fileExists(String path) async {
    final file = File(path);
    return file.exists();
  }

  @override
  Future<int> getFileSize(String path) async {
    final file = File(path);
    if (await file.exists()) {
      return file.length();
    }
    return 0;
  }
}
