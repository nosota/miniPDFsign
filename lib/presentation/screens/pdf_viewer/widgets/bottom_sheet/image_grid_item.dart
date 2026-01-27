import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:minipdfsign/domain/entities/sidebar_image.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/bottom_sheet_constants.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/sidebar/draggable_image_card.dart';

/// A single image thumbnail in the bottom sheet grid or list.
///
/// Supports long-press drag to place on PDF.
/// In edit mode, shows a delete button.
class ImageGridItem extends StatelessWidget {
  const ImageGridItem({
    required this.image,
    this.size = BottomSheetConstants.thumbnailSizeCollapsed,
    this.showDeleteButton = false,
    this.onDelete,
    this.onDragStarted,
    this.onDragEnd,
    super.key,
  });

  final SidebarImage image;
  final double size;
  final bool showDeleteButton;
  final VoidCallback? onDelete;
  final VoidCallback? onDragStarted;
  final VoidCallback? onDragEnd;

  @override
  Widget build(BuildContext context) {
    final dragData = DraggableSidebarImage.fromSidebarImage(image);

    return LongPressDraggable<DraggableSidebarImage>(
      delay: const Duration(milliseconds: 200),
      data: dragData,
      feedback: _buildDragFeedback(),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildThumbnail(),
      ),
      onDragStarted: () {
        HapticFeedback.lightImpact();
        onDragStarted?.call();
      },
      onDragEnd: (_) => onDragEnd?.call(),
      child: _buildThumbnail(),
    );
  }

  Widget _buildThumbnail() {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              BottomSheetConstants.thumbnailBorderRadius,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.file(
            File(image.filePath),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  color: Colors.grey,
                ),
              );
            },
          ),
        ),
        if (showDeleteButton)
          Positioned(
            right: 4,
            bottom: 4,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                width: BottomSheetConstants.deleteButtonSize,
                height: BottomSheetConstants.deleteButtonSize,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDragFeedback() {
    // 80% of original thumbnail size
    final feedbackSize = size * 0.8;
    final aspectRatio = image.aspectRatio;

    double width, height;
    if (aspectRatio > 1) {
      width = feedbackSize;
      height = feedbackSize / aspectRatio;
    } else {
      height = feedbackSize;
      width = feedbackSize * aspectRatio;
    }

    return Opacity(
      opacity: 0.8,
      child: Image.file(
        File(image.filePath),
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}
