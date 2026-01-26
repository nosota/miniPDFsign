import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:minipdfsign/domain/entities/sidebar_image.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/sidebar/image_thumbnail_card.dart';

/// Data object passed during drag operation.
class DraggableSidebarImage {
  final String sourceImageId;
  final String imagePath;
  final int width;
  final int height;

  const DraggableSidebarImage({
    required this.sourceImageId,
    required this.imagePath,
    required this.width,
    required this.height,
  });

  double get aspectRatio => width / height;

  factory DraggableSidebarImage.fromSidebarImage(SidebarImage image) {
    return DraggableSidebarImage(
      sourceImageId: image.id,
      imagePath: image.filePath,
      width: image.width,
      height: image.height,
    );
  }
}

/// Image card draggable to PDF.
///
/// For mobile, we use LongPressDraggable to start drag.
class DraggableImageCard extends ConsumerWidget {
  const DraggableImageCard({
    required this.image,
    required this.index,
    required this.isSelected,
    super.key,
  });

  final SidebarImage image;
  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dragData = DraggableSidebarImage.fromSidebarImage(image);

    return LongPressDraggable<DraggableSidebarImage>(
      data: dragData,
      feedback: _buildDragFeedback(context),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: ImageThumbnailCard(
          image: image,
          isSelected: false,
        ),
      ),
      child: ImageThumbnailCard(
        image: image,
        isSelected: isSelected,
      ),
    );
  }

  Widget _buildDragFeedback(BuildContext context) {
    const maxSize = 100.0;
    final aspectRatio = image.aspectRatio;

    double width, height;
    if (aspectRatio > 1) {
      width = maxSize;
      height = maxSize / aspectRatio;
    } else {
      height = maxSize;
      width = maxSize * aspectRatio;
    }

    return Material(
      color: Colors.transparent,
      elevation: 4,
      child: Image.file(
        File(image.filePath),
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}
