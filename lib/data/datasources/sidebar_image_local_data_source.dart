import 'package:isar/isar.dart';

import 'package:minipdfsign/data/models/sidebar_image_model.dart';

/// Local data source for sidebar images using Isar database.
abstract class SidebarImageLocalDataSource {
  /// Retrieves all stored images ordered by addedAt (newest first).
  Future<List<SidebarImageModel>> getImages();

  /// Watches images for real-time updates.
  ///
  /// Emits whenever images are added or removed.
  Stream<List<SidebarImageModel>> watchImages();

  /// Adds a new image to storage.
  Future<void> addImage(SidebarImageModel image);

  /// Gets an image by its UUID.
  Future<SidebarImageModel?> getImageById(String id);

  /// Removes an image by its UUID.
  Future<bool> removeImage(String id);

  /// Updates an existing image (upsert by UUID).
  Future<void> updateImage(SidebarImageModel image);

  /// Clears all stored images.
  Future<void> clearAll();
}

/// Implementation of [SidebarImageLocalDataSource] using Isar.
class SidebarImageLocalDataSourceImpl implements SidebarImageLocalDataSource {
  final Isar _isar;

  SidebarImageLocalDataSourceImpl(this._isar);

  @override
  Future<List<SidebarImageModel>> getImages() async {
    return _isar.sidebarImageModels
        .where()
        .sortByAddedAtDesc()
        .findAll();
  }

  @override
  Stream<List<SidebarImageModel>> watchImages() {
    return _isar.sidebarImageModels
        .where()
        .sortByAddedAtDesc()
        .watch(fireImmediately: true);
  }

  @override
  Future<void> addImage(SidebarImageModel image) async {
    await _isar.writeTxn(() async {
      await _isar.sidebarImageModels.put(image);
    });
  }

  @override
  Future<SidebarImageModel?> getImageById(String id) async {
    return _isar.sidebarImageModels.filter().idEqualTo(id).findFirst();
  }

  @override
  Future<void> updateImage(SidebarImageModel image) async {
    await _isar.writeTxn(() async {
      // Find existing record to preserve isarId for upsert
      final existing = await _isar.sidebarImageModels
          .filter()
          .idEqualTo(image.id)
          .findFirst();
      if (existing != null) {
        image.isarId = existing.isarId;
      }
      await _isar.sidebarImageModels.put(image);
    });
  }

  @override
  Future<bool> removeImage(String id) async {
    return _isar.writeTxn(() async {
      return _isar.sidebarImageModels.filter().idEqualTo(id).deleteFirst();
    });
  }

  @override
  Future<void> clearAll() async {
    await _isar.writeTxn(() async {
      await _isar.sidebarImageModels.clear();
    });
  }
}
