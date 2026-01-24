import 'dart:ui';

import 'package:equatable/equatable.dart';

/// Represents an image placed on a PDF page.
///
/// Images can be positioned, scaled, and rotated on the PDF.
/// Position and size are stored in PDF points (1/72 inch).
class PlacedImage extends Equatable {
  /// Unique identifier for this placed image.
  final String id;

  /// Reference to the source image in the sidebar.
  final String sourceImageId;

  /// Path to the actual image file in app storage.
  final String imagePath;

  /// Primary page index where the image is placed.
  /// For cross-page images, this is the topmost page.
  final int pageIndex;

  /// Position relative to page top-left, in PDF points.
  final Offset position;

  /// Size in PDF points.
  final Size size;

  /// Rotation angle in radians.
  final double rotation;

  const PlacedImage({
    required this.id,
    required this.sourceImageId,
    required this.imagePath,
    required this.pageIndex,
    required this.position,
    required this.size,
    this.rotation = 0,
  });

  /// Creates a copy with modified properties.
  PlacedImage copyWith({
    String? id,
    String? sourceImageId,
    String? imagePath,
    int? pageIndex,
    Offset? position,
    Size? size,
    double? rotation,
  }) {
    return PlacedImage(
      id: id ?? this.id,
      sourceImageId: sourceImageId ?? this.sourceImageId,
      imagePath: imagePath ?? this.imagePath,
      pageIndex: pageIndex ?? this.pageIndex,
      position: position ?? this.position,
      size: size ?? this.size,
      rotation: rotation ?? this.rotation,
    );
  }

  /// Gets the bounding rectangle of the image (before rotation).
  Rect get bounds => Rect.fromLTWH(
        position.dx,
        position.dy,
        size.width,
        size.height,
      );

  /// Gets the center point of the image.
  Offset get center => Offset(
        position.dx + size.width / 2,
        position.dy + size.height / 2,
      );

  @override
  List<Object?> get props => [
        id,
        sourceImageId,
        imagePath,
        pageIndex,
        position,
        size,
        rotation,
      ];
}
