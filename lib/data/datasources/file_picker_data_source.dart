import 'dart:io';

import 'package:file_picker/file_picker.dart';

/// Data source wrapping the file_picker package.
abstract class FilePickerDataSource {
  /// Opens native file picker for PDF selection.
  Future<String?> pickPdfFile();

  /// Checks if a file exists at the given path.
  Future<bool> fileExists(String path);

  /// Gets the file size in bytes.
  Future<int> getFileSize(String path);
}

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
