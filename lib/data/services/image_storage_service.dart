import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// Service for managing image file storage in app data folder.
///
/// Copies images to a dedicated folder within the app's support directory,
/// making them independent of original file locations.
class ImageStorageService {
  static const _imagesFolderName = 'images';
  final Uuid _uuid = const Uuid();

  /// Gets the images directory inside app support folder.
  ///
  /// Creates the directory if it doesn't exist.
  /// - macOS: ~/Library/Application Support/com.ivanvaganov.pdfsign/images/
  /// - Windows: C:\Users\<user>\AppData\Roaming\pdfsign\images\
  Future<Directory> getImagesDirectory() async {
    final appSupport = await getApplicationSupportDirectory();
    final imagesDir = Directory(path.join(appSupport.path, _imagesFolderName));

    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }

    return imagesDir;
  }

  /// Copies an image to app storage and returns the new path.
  ///
  /// The file is copied with a unique name to avoid conflicts.
  /// Returns the full path to the copied file.
  Future<String> copyImageToStorage(String sourcePath) async {
    final sourceFile = File(sourcePath);
    if (!await sourceFile.exists()) {
      throw FileSystemException('Source file does not exist', sourcePath);
    }

    final imagesDir = await getImagesDirectory();

    // Generate unique filename: uuid + original extension
    final extension = path.extension(sourcePath);
    final uniqueName = '${_uuid.v4()}$extension';
    final destinationPath = path.join(imagesDir.path, uniqueName);

    await sourceFile.copy(destinationPath);

    return destinationPath;
  }

  /// Deletes an image from storage.
  ///
  /// Does nothing if the file doesn't exist.
  Future<void> deleteImage(String storagePath) async {
    final file = File(storagePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Checks if a path is within the app's image storage.
  bool isInStorage(String filePath) {
    return filePath.contains(_imagesFolderName);
  }
}
