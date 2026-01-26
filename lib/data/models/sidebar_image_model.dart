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
  @Index()
  late DateTime addedAt;

  /// Original image width in pixels.
  late int width;

  /// Original image height in pixels.
  late int height;

  /// File size in bytes.
  late int fileSize;

  /// Converts this model to a domain entity.
  SidebarImage toEntity() {
    return SidebarImage(
      id: id,
      filePath: filePath,
      fileName: fileName,
      addedAt: addedAt,
      width: width,
      height: height,
      fileSize: fileSize,
    );
  }

  /// Creates a model from a domain entity.
  static SidebarImageModel fromEntity(SidebarImage entity) {
    return SidebarImageModel()
      ..id = entity.id
      ..filePath = entity.filePath
      ..fileName = entity.fileName
      ..addedAt = entity.addedAt
      ..width = entity.width
      ..height = entity.height
      ..fileSize = entity.fileSize;
  }
}
