import 'dart:io';
import 'dart:ui' as ui;

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:minipdfsign/domain/entities/sidebar_image.dart';
import 'package:minipdfsign/presentation/providers/repository_providers.dart';

part 'sidebar_images_provider.g.dart';

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

  /// Adds images from file paths.
  ///
  /// Validates each file exists and is a valid image before adding.
  Future<void> addImages(List<String> filePaths) async {
    final repository = ref.read(sidebarImageRepositoryProvider);

    for (final path in filePaths) {
      // Validate file exists
      final file = File(path);
      if (!await file.exists()) continue;

      try {
        // Get image dimensions
        final bytes = await file.readAsBytes();
        final codec = await ui.instantiateImageCodec(bytes);
        final frame = await codec.getNextFrame();

        // Extract file info
        final fileName = path.split('/').last;
        final fileSize = await file.length();

        await repository.addImage(
          filePath: path,
          fileName: fileName,
          width: frame.image.width,
          height: frame.image.height,
          fileSize: fileSize,
        );

        frame.image.dispose();
      } catch (e) {
        // Skip invalid images
        continue;
      }
    }
  }

  /// Removes an image by its ID.
  Future<void> removeImage(String id) async {
    final repository = ref.read(sidebarImageRepositoryProvider);
    await repository.removeImage(id);
  }

  /// Clears all images from the sidebar.
  Future<void> clearAll() async {
    final repository = ref.read(sidebarImageRepositoryProvider);
    await repository.clearAllImages();
  }
}
