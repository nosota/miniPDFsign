import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:minipdfsign/domain/entities/sidebar_image.dart';
import 'package:minipdfsign/presentation/providers/repository_providers.dart';

part 'sidebar_images_provider.g.dart';

/// Result of adding images to the library.
class AddImagesResult {
  /// Number of images successfully added.
  final int successCount;

  /// List of error keys for failed images (localization keys).
  final List<String> errors;

  const AddImagesResult({
    required this.successCount,
    required this.errors,
  });

  /// Whether all images were added successfully.
  bool get allSuccessful => errors.isEmpty;
}

/// Provider for sidebar images with real-time updates.
///
/// Uses a stream-based approach to receive updates from Isar database
/// whenever images are added or removed.
@riverpod
class SidebarImages extends _$SidebarImages {
  @override
  Stream<List<SidebarImage>> build() {
    final repository = ref.watch(sidebarImageRepositoryProvider);
    return repository.watchImages();
  }

  /// Adds images from file paths with validation and EXIF normalization.
  ///
  /// Validates each file for format, size, and resolution before adding.
  /// If an image has EXIF rotation, it will be normalized (rotation baked in)
  /// before being stored.
  ///
  /// Returns [AddImagesResult] with success count and error keys.
  Future<AddImagesResult> addImages(List<String> filePaths) async {
    final validationService = ref.read(imageValidationServiceProvider);
    final repository = ref.read(sidebarImageRepositoryProvider);

    var successCount = 0;
    final errors = <String>[];

    for (final path in filePaths) {
      final result = await validationService.validateImage(path);

      if (!result.isValid) {
        if (result.errorKey != null) {
          errors.add(result.errorKey!);
        }
        continue;
      }

      // Use normalized path (has EXIF rotation baked in)
      // This ensures correct display and PDF export
      final normalizedPath = result.normalizedPath!;

      // Extract file name from original path (for display purposes)
      final fileName = path.split('/').last;

      final addResult = await repository.addImage(
        filePath: normalizedPath,
        fileName: fileName,
        width: result.width!,
        height: result.height!,
        fileSize: result.fileSize!,
      );

      addResult.fold(
        (failure) => errors.add('error'),
        (_) => successCount++,
      );
    }

    return AddImagesResult(
      successCount: successCount,
      errors: errors,
    );
  }

  /// Removes an image by its ID.
  Future<void> removeImage(String id) async {
    final repository = ref.read(sidebarImageRepositoryProvider);
    await repository.removeImage(id);
  }

  /// Updates the last used size for an image.
  ///
  /// [width] and [height] are in PDF points (1pt = 1/72 inch).
  Future<void> updateLastUsedSize(
    String imageId,
    double width,
    double height,
  ) async {
    final repository = ref.read(sidebarImageRepositoryProvider);
    await repository.updateImageSize(imageId, width: width, height: height);
  }

  /// Clears all images from the sidebar.
  Future<void> clearAll() async {
    final repository = ref.read(sidebarImageRepositoryProvider);
    await repository.clearAllImages();
  }
}
