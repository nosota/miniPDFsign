import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

import 'package:minipdfsign/core/errors/failure.dart';
import 'package:minipdfsign/core/errors/failures.dart';
import 'package:minipdfsign/data/datasources/sidebar_image_local_data_source.dart';
import 'package:minipdfsign/data/models/sidebar_image_model.dart';
import 'package:minipdfsign/data/services/image_storage_service.dart';
import 'package:minipdfsign/domain/entities/sidebar_image.dart';
import 'package:minipdfsign/domain/repositories/sidebar_image_repository.dart';

/// Concrete implementation of [SidebarImageRepository].
class SidebarImageRepositoryImpl implements SidebarImageRepository {
  final SidebarImageLocalDataSource _localDataSource;
  final ImageStorageService _storageService;
  final Uuid _uuid = const Uuid();

  SidebarImageRepositoryImpl(this._localDataSource, this._storageService);

  @override
  Future<Either<Failure, List<SidebarImage>>> getImages() async {
    try {
      final models = await _localDataSource.getImages();
      final entities = models.map((m) => m.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to load images: $e'));
    }
  }

  @override
  Stream<List<SidebarImage>> watchImages() {
    return _localDataSource.watchImages().map(
      (models) => models.map((m) => m.toEntity()).toList(),
    );
  }

  @override
  Future<Either<Failure, SidebarImage>> addImage({
    required String filePath,
    required String fileName,
    required int width,
    required int height,
    required int fileSize,
  }) async {
    try {
      // Copy image to app storage so it doesn't depend on original file
      final storagePath = await _storageService.copyImageToStorage(filePath);

      // Get next order index
      final nextIndex = await _localDataSource.getNextOrderIndex();

      final entity = SidebarImage(
        id: _uuid.v4(),
        filePath: storagePath,
        fileName: fileName,
        addedAt: DateTime.now(),
        orderIndex: nextIndex,
        width: width,
        height: height,
        fileSize: fileSize,
      );

      final model = SidebarImageModel.fromEntity(entity);
      await _localDataSource.addImage(model);

      return Right(entity);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to add image: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeImage(String id) async {
    try {
      // Get image to find file path before removing
      final image = await _localDataSource.getImageById(id);

      final removed = await _localDataSource.removeImage(id);
      if (!removed) {
        return Left(StorageFailure(message: 'Image not found: $id'));
      }

      // Delete file from storage
      if (image != null) {
        await _storageService.deleteImage(image.filePath);
      }

      return const Right(unit);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to remove image: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> reorderImages(List<String> orderedIds) async {
    try {
      final idToIndex = <String, int>{};
      for (var i = 0; i < orderedIds.length; i++) {
        idToIndex[orderedIds[i]] = i;
      }
      await _localDataSource.updateOrderIndices(idToIndex);
      return const Right(unit);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to reorder images: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearAllImages() async {
    try {
      // Get all images to delete their files
      final models = await _localDataSource.getImages();

      // Clear database
      await _localDataSource.clearAll();

      // Delete all files from storage
      for (final model in models) {
        await _storageService.deleteImage(model.filePath);
      }

      return const Right(unit);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to clear images: $e'));
    }
  }

  @override
  Future<Either<Failure, List<SidebarImage>>> cleanupInvalidImages() async {
    try {
      final models = await _localDataSource.getImages();
      final invalidIds = <String>[];

      for (final model in models) {
        final file = File(model.filePath);
        if (!await file.exists()) {
          invalidIds.add(model.id);
        }
      }

      // Remove invalid entries
      for (final id in invalidIds) {
        await _localDataSource.removeImage(id);
      }

      // Return remaining valid images
      final validModels = await _localDataSource.getImages();
      final entities = validModels.map((m) => m.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to cleanup images: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateComment(String id, String? comment) async {
    try {
      final updated = await _localDataSource.updateComment(id, comment);
      if (!updated) {
        return Left(StorageFailure(message: 'Image not found: $id'));
      }
      return const Right(unit);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to update comment: $e'));
    }
  }
}
