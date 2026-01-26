import 'package:dartz/dartz.dart';

import 'package:minipdfsign/core/errors/failure.dart';
import 'package:minipdfsign/domain/entities/sidebar_image.dart';

/// Repository interface for image library operations.
///
/// Handles CRUD operations and real-time watching for library images.
abstract class SidebarImageRepository {
  /// Gets all images ordered by addedAt (newest first).
  ///
  /// Returns a list of [SidebarImage] sorted by date.
  /// Returns a [Failure] if the operation fails.
  Future<Either<Failure, List<SidebarImage>>> getImages();

  /// Watches images for real-time updates.
  ///
  /// Emits a new list whenever images are added or removed.
  /// The list is always sorted by addedAt (newest first).
  Stream<List<SidebarImage>> watchImages();

  /// Adds a new image to the library.
  ///
  /// Returns the created [SidebarImage] with generated ID.
  /// Returns a [Failure] if the operation fails.
  Future<Either<Failure, SidebarImage>> addImage({
    required String filePath,
    required String fileName,
    required int width,
    required int height,
    required int fileSize,
  });

  /// Removes an image by its ID.
  ///
  /// Returns [Unit] on success.
  /// Returns a [Failure] if the image doesn't exist or removal fails.
  Future<Either<Failure, Unit>> removeImage(String id);

  /// Clears all images from the library.
  ///
  /// Returns [Unit] on success.
  /// Returns a [Failure] if the operation fails.
  Future<Either<Failure, Unit>> clearAllImages();

  /// Validates images and removes entries for non-existent files.
  ///
  /// Returns the remaining valid images after cleanup.
  /// Returns a [Failure] if the operation fails.
  Future<Either<Failure, List<SidebarImage>>> cleanupInvalidImages();
}
