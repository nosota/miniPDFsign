import 'package:dartz/dartz.dart';

import 'package:minipdfsign/core/errors/failure.dart';
import 'package:minipdfsign/domain/entities/sidebar_image.dart';

/// Repository interface for sidebar image operations.
///
/// Handles CRUD operations and real-time watching for sidebar images.
abstract class SidebarImageRepository {
  /// Gets all images ordered by orderIndex.
  ///
  /// Returns a list of [SidebarImage] sorted by order.
  /// Returns a [Failure] if the operation fails.
  Future<Either<Failure, List<SidebarImage>>> getImages();

  /// Watches images for real-time updates (for multi-window sync).
  ///
  /// Emits a new list whenever images are added, removed, or reordered.
  /// The list is always sorted by orderIndex.
  Stream<List<SidebarImage>> watchImages();

  /// Adds a new image to the sidebar.
  ///
  /// Automatically assigns the next orderIndex.
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

  /// Reorders images by updating their orderIndex values.
  ///
  /// [orderedIds] is the new order of image IDs.
  /// Returns [Unit] on success.
  /// Returns a [Failure] if the operation fails.
  Future<Either<Failure, Unit>> reorderImages(List<String> orderedIds);

  /// Clears all images from the sidebar.
  ///
  /// Returns [Unit] on success.
  /// Returns a [Failure] if the operation fails.
  Future<Either<Failure, Unit>> clearAllImages();

  /// Validates images and removes entries for non-existent files.
  ///
  /// Returns the remaining valid images after cleanup.
  /// Returns a [Failure] if the operation fails.
  Future<Either<Failure, List<SidebarImage>>> cleanupInvalidImages();

  /// Updates the comment for an image.
  ///
  /// [id] is the image UUID.
  /// [comment] is the new comment (null to remove).
  /// Returns [Unit] on success.
  /// Returns a [Failure] if the image doesn't exist or update fails.
  Future<Either<Failure, Unit>> updateComment(String id, String? comment);
}
