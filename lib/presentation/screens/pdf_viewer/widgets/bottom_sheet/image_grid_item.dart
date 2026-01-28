import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:minipdfsign/domain/entities/sidebar_image.dart';
import 'package:minipdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/bottom_sheet_constants.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/sidebar/draggable_image_card.dart';

/// A single image thumbnail in the bottom sheet grid or list.
///
/// Supports long-press drag to place on PDF.
/// In edit mode, shows a delete button.
class ImageGridItem extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final dragData = DraggableSidebarImage.fromSidebarImage(image);

    return LongPressDraggable<DraggableSidebarImage>(
      delay: const Duration(milliseconds: 200),
      data: dragData,
      feedback: _buildDragFeedback(ref),
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

  Widget _buildDragFeedback(WidgetRef ref) {
    // Calculate size matching what image will be on PDF
    // Uses same formula as PdfDropTarget._calculateDefaultSize
    final feedbackSize = _calculateFeedbackSize(ref);

    return Opacity(
      opacity: 0.8,
      child: Image.file(
        File(image.filePath),
        width: feedbackSize.width,
        height: feedbackSize.height,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            width: feedbackSize.width,
            height: feedbackSize.height,
            child: const DecoratedBox(
              decoration: BoxDecoration(color: BottomSheetConstants.thumbnailBackgroundColor),
              child: Icon(Icons.broken_image_outlined, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }

  /// Calculates drag feedback size to match placed image size on PDF.
  ///
  /// Uses the same formula as [PdfDropTarget._calculateDefaultSize]:
  /// - 40% of page width as base
  /// - Aspect ratio preserved
  /// - Clamped to max 300pt for usability during drag
  Size _calculateFeedbackSize(WidgetRef ref) {
    final aspectRatio = image.aspectRatio;
    const maxSize = BottomSheetConstants.dragFeedbackMaxSize;

    // Get page size from PDF document (use first page as reference)
    final pdfState = ref.read(pdfDocumentProvider);
    final pageSize = pdfState.maybeMap(
      loaded: (state) {
        if (state.document.pages.isNotEmpty) {
          final page = state.document.pages.first;
          return Size(page.width, page.height);
        }
        return null;
      },
      orElse: () => null,
    );

    // Calculate size using same formula as PdfDropTarget
    double width, height;

    if (pageSize != null) {
      // Use actual PDF page dimensions
      final baseSize = pageSize.width * BottomSheetConstants.defaultImageWidthRatio;

      if (aspectRatio > 1) {
        // Landscape
        width = baseSize;
        height = baseSize / aspectRatio;
      } else {
        // Portrait or square
        height = baseSize;
        width = baseSize * aspectRatio;
      }
    } else {
      // Fallback: use max size if PDF not loaded
      if (aspectRatio > 1) {
        width = maxSize;
        height = maxSize / aspectRatio;
      } else {
        height = maxSize;
        width = maxSize * aspectRatio;
      }
    }

    // Apply max constraint for usability during drag
    final maxDimension = math.max(width, height);
    if (maxDimension > maxSize) {
      final scale = maxSize / maxDimension;
      width *= scale;
      height *= scale;
    }

    return Size(width, height);
  }
}
