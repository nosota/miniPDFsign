import 'package:isar/isar.dart';

import 'package:minipdfsign/data/models/sidebar_image_model.dart';

/// Local data source for sidebar images using Isar database.
abstract class SidebarImageLocalDataSource {
  /// Retrieves all stored images ordered by orderIndex.
  Future<List<SidebarImageModel>> getImages();

  /// Watches images for real-time updates across windows.
  ///
  /// Emits whenever images are added, removed, or modified.
  Stream<List<SidebarImageModel>> watchImages();

  /// Adds a new image to storage.
  Future<void> addImage(SidebarImageModel image);

  /// Gets an image by its UUID.
  Future<SidebarImageModel?> getImageById(String id);

  /// Removes an image by its UUID.
  Future<bool> removeImage(String id);

  /// Updates the orderIndex for multiple images.
  Future<void> updateOrderIndices(Map<String, int> idToIndex);

  /// Clears all stored images.
  Future<void> clearAll();

  /// Gets the next available orderIndex.
  Future<int> getNextOrderIndex();

  /// Updates the comment for an image.
  Future<bool> updateComment(String id, String? comment);
}

/// Implementation of [SidebarImageLocalDataSource] using Isar.
class SidebarImageLocalDataSourceImpl implements SidebarImageLocalDataSource {
  final Isar _isar;

  SidebarImageLocalDataSourceImpl(this._isar);

  @override
  Future<List<SidebarImageModel>> getImages() async {
    return _isar.sidebarImageModels
        .where()
        .sortByOrderIndex()
        .findAll();
  }

  @override
  Stream<List<SidebarImageModel>> watchImages() {
    return _isar.sidebarImageModels
        .where()
        .sortByOrderIndex()
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
  Future<bool> removeImage(String id) async {
    return _isar.writeTxn(() async {
      return _isar.sidebarImageModels.filter().idEqualTo(id).deleteFirst();
    });
  }

  @override
  Future<void> updateOrderIndices(Map<String, int> idToIndex) async {
    await _isar.writeTxn(() async {
      for (final entry in idToIndex.entries) {
        final model = await _isar.sidebarImageModels
            .filter()
            .idEqualTo(entry.key)
            .findFirst();
        if (model != null) {
          model.orderIndex = entry.value;
          await _isar.sidebarImageModels.put(model);
        }
      }
    });
  }

  @override
  Future<void> clearAll() async {
    await _isar.writeTxn(() async {
      await _isar.sidebarImageModels.clear();
    });
  }

  @override
  Future<int> getNextOrderIndex() async {
    final lastImage = await _isar.sidebarImageModels
        .where()
        .sortByOrderIndexDesc()
        .findFirst();
    return lastImage == null ? 0 : lastImage.orderIndex + 1;
  }

  @override
  Future<bool> updateComment(String id, String? comment) async {
    return _isar.writeTxn(() async {
      final model = await _isar.sidebarImageModels
          .filter()
          .idEqualTo(id)
          .findFirst();
      if (model == null) return false;
      model.comment = comment;
      await _isar.sidebarImageModels.put(model);
      return true;
    });
  }
}
