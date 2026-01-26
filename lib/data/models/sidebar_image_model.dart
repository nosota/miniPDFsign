import 'package:isar/isar.dart';

import 'package:minipdfsign/domain/entities/sidebar_image.dart';

part 'sidebar_image_model.g.dart';

/// Isar collection model for sidebar images.
///
/// Stores image metadata for persistence across app launches.
/// The actual image files remain on disk; only paths are stored.
@collection
class SidebarImageModel {
  /// Isar auto-increment ID.
  Id isarId = Isar.autoIncrement;

  /// Unique identifier (UUID) for app-level identification.
  @Index(unique: true)
  late String id;

  /// Full file system path to the image.
  late String filePath;

  /// File name for display.
  late String fileName;

  /// When the image was added.
  late DateTime addedAt;

  /// Order index for sorting (0-based).
  @Index()
  late int orderIndex;

  /// Original image width in pixels.
  late int width;

  /// Original image height in pixels.
  late int height;

  /// File size in bytes.
  late int fileSize;

  /// Optional user comment.
  String? comment;

  /// Converts this model to a domain entity.
  SidebarImage toEntity() {
    return SidebarImage(
      id: id,
      filePath: filePath,
      fileName: fileName,
      addedAt: addedAt,
      orderIndex: orderIndex,
      width: width,
      height: height,
      fileSize: fileSize,
      comment: comment,
    );
  }

  /// Creates a model from a domain entity.
  static SidebarImageModel fromEntity(SidebarImage entity) {
    return SidebarImageModel()
      ..id = entity.id
      ..filePath = entity.filePath
      ..fileName = entity.fileName
      ..addedAt = entity.addedAt
      ..orderIndex = entity.orderIndex
      ..width = entity.width
      ..height = entity.height
      ..fileSize = entity.fileSize
      ..comment = entity.comment;
  }
}
