import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:pdfsign/domain/entities/placed_image.dart';

part 'placed_images_provider.g.dart';

/// Provider for managing images placed on PDF pages.
///
/// Uses keepAlive to persist state during zoom/scroll operations
/// when pages may temporarily become invisible.
@Riverpod(keepAlive: true)
class PlacedImages extends _$PlacedImages {
  final _uuid = const Uuid();

  @override
  List<PlacedImage> build() {
    return [];
  }

  /// Adds a new image to the PDF at the specified position.
  void addImage({
    required String sourceImageId,
    required String imagePath,
    required int pageIndex,
    required Offset position,
    required Size size,
  }) {
    final image = PlacedImage(
      id: _uuid.v4(),
      sourceImageId: sourceImageId,
      imagePath: imagePath,
      pageIndex: pageIndex,
      position: position,
      size: size,
    );

    state = [...state, image];
  }

  /// Removes an image by its ID.
  void removeImage(String id) {
    state = state.where((img) => img.id != id).toList();
  }

  /// Updates an existing image.
  void updateImage(PlacedImage updated) {
    state = state.map((img) => img.id == updated.id ? updated : img).toList();
  }

  /// Moves an image to a new position.
  void moveImage(String id, Offset newPosition) {
    state = state.map((img) {
      if (img.id == id) {
        return img.copyWith(position: newPosition);
      }
      return img;
    }).toList();
  }

  /// Resizes an image.
  void resizeImage(String id, Size newSize) {
    state = state.map((img) {
      if (img.id == id) {
        return img.copyWith(size: newSize);
      }
      return img;
    }).toList();
  }

  /// Rotates an image.
  void rotateImage(String id, double newRotation) {
    state = state.map((img) {
      if (img.id == id) {
        return img.copyWith(rotation: newRotation);
      }
      return img;
    }).toList();
  }

  /// Updates image position, size, and rotation together (for smooth manipulation).
  void transformImage(
    String id, {
    Offset? position,
    Size? size,
    double? rotation,
    int? pageIndex,
  }) {
    state = state.map((img) {
      if (img.id == id) {
        return img.copyWith(
          position: position,
          size: size,
          rotation: rotation,
          pageIndex: pageIndex,
        );
      }
      return img;
    }).toList();
  }

  /// Gets images for a specific page.
  List<PlacedImage> getImagesForPage(int pageIndex) {
    return state.where((img) => img.pageIndex == pageIndex).toList();
  }

  /// Creates a duplicate of an image at an offset position.
  PlacedImage? duplicateImage(String id, {Offset offset = const Offset(20, 20)}) {
    final original = state.firstWhere(
      (img) => img.id == id,
      orElse: () => throw StateError('Image not found'),
    );

    final duplicate = PlacedImage(
      id: _uuid.v4(),
      sourceImageId: original.sourceImageId,
      imagePath: original.imagePath,
      pageIndex: original.pageIndex,
      position: original.position + offset,
      size: original.size,
      rotation: original.rotation,
    );

    state = [...state, duplicate];
    return duplicate;
  }

  /// Clears all placed images.
  void clear() {
    state = [];
  }

  /// Checks if there are any placed images.
  bool get hasImages => state.isNotEmpty;
}
