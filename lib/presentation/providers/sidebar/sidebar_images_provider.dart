import 'dart:io';
import 'dart:ui' as ui;

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:minipdfsign/domain/entities/sidebar_image.dart';
import 'package:minipdfsign/presentation/providers/repository_providers.dart';

part 'sidebar_images_provider.g.dart';

/// Provider for sidebar images with real-time multi-window sync.
///
/// Uses a stream-based approach to receive updates from Isar database
/// whenever images are added, removed, or reordered in any window.
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

  /// Reorders images after drag-and-drop.
  ///
  /// [oldIndex] is the original position.
  /// [newIndex] is the target position.
  Future<void> reorder(int oldIndex, int newIndex) async {
    final currentImages = state.valueOrNull ?? [];
    if (currentImages.isEmpty) return;

    // Calculate new order
    final ids = currentImages.map((i) => i.id).toList();
    final item = ids.removeAt(oldIndex);

    // Adjust newIndex for removal
    final adjustedNewIndex = newIndex > oldIndex ? newIndex - 1 : newIndex;
    ids.insert(adjustedNewIndex, item);

    final repository = ref.read(sidebarImageRepositoryProvider);
    await repository.reorderImages(ids);
  }

  /// Clears all images from the sidebar.
  Future<void> clearAll() async {
    final repository = ref.read(sidebarImageRepositoryProvider);
    await repository.clearAllImages();
  }

  /// Updates the comment for an image by ID.
  Future<void> updateComment(String id, String? comment) async {
    final repository = ref.read(sidebarImageRepositoryProvider);
    await repository.updateComment(id, comment);
  }
}
