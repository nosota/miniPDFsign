import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:minipdfsign/core/utils/image_size_calculator.dart';
import 'package:minipdfsign/domain/entities/pdf_document_info.dart';
import 'package:minipdfsign/presentation/providers/editor/document_dirty_provider.dart';
import 'package:minipdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:minipdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/pdf_viewer/pdf_viewer_constants.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/sidebar/draggable_image_card.dart';

/// Mixin for calculating drop positions on PDF pages.
mixin PdfDropPositionCalculator {
  /// Calculates the page index and position from a drop offset.
  ///
  /// Returns null if the drop is outside any page.
  DropPosition? calculateDropPosition({
    required Offset dropOffset,
    required Offset scrollOffset,
    required double scale,
    required PdfDocumentInfo document,
    required Size viewportSize,
  }) {
    // Convert drop position to document coordinates
    final documentY = dropOffset.dy + scrollOffset.dy;
    final documentX = dropOffset.dx + scrollOffset.dx;

    // Find which page the drop landed on
    double cumulativeY = PdfViewerConstants.verticalPadding;

    for (int i = 0; i < document.pages.length; i++) {
      final page = document.pages[i];
      final scaledPageWidth = page.width * scale;
      final scaledPageHeight = page.height * scale;

      // Calculate page X position (centered in viewport)
      final contentWidth = _calculateContentWidth(document, scale);
      final pageX = (viewportSize.width - contentWidth) / 2 +
          (contentWidth - scaledPageWidth) / 2;

      final pageTop = cumulativeY;
      final pageBottom = cumulativeY + scaledPageHeight;
      final pageLeft = pageX > 0 ? pageX : PdfViewerConstants.horizontalPadding;
      final pageRight = pageLeft + scaledPageWidth;

      // Check if drop is within this page
      if (documentY >= pageTop &&
          documentY < pageBottom &&
          documentX >= pageLeft &&
          documentX < pageRight) {
        // Calculate position relative to page in PDF points (unscaled)
        final relativeX = (documentX - pageLeft) / scale;
        final relativeY = (documentY - pageTop) / scale;

        return DropPosition(
          pageIndex: i,
          position: Offset(relativeX, relativeY),
          pageSize: Size(page.width, page.height),
        );
      }

      cumulativeY += scaledPageHeight + PdfViewerConstants.pageGap;
    }

    return null;
  }

  double _calculateContentWidth(PdfDocumentInfo document, double scale) {
    double maxWidth = 0;
    for (final page in document.pages) {
      final scaledWidth = page.width * scale;
      if (scaledWidth > maxWidth) {
        maxWidth = scaledWidth;
      }
    }
    return maxWidth;
  }
}

/// Result of drop position calculation.
class DropPosition {
  final int pageIndex;
  final Offset position;
  final Size pageSize;

  const DropPosition({
    required this.pageIndex,
    required this.position,
    required this.pageSize,
  });
}

/// DragTarget wrapper for the PDF viewer.
///
/// Accepts drops of [DraggableSidebarImage] and creates placed images.
class PdfDropTarget extends ConsumerStatefulWidget {
  const PdfDropTarget({
    required this.child,
    required this.document,
    required this.scale,
    required this.getScrollOffset,
    super.key,
  });

  final Widget child;
  final PdfDocumentInfo document;
  final double scale;
  final Offset Function() getScrollOffset;

  @override
  ConsumerState<PdfDropTarget> createState() => _PdfDropTargetState();
}

class _PdfDropTargetState extends ConsumerState<PdfDropTarget>
    with PdfDropPositionCalculator {
  bool _isDragOver = false;

  @override
  Widget build(BuildContext context) {
    return DragTarget<DraggableSidebarImage>(
      onWillAcceptWithDetails: (details) {
        setState(() => _isDragOver = true);
        return true;
      },
      onLeave: (_) {
        setState(() => _isDragOver = false);
      },
      onAcceptWithDetails: (details) {
        setState(() => _isDragOver = false);
        _handleDrop(context, details);
      },
      builder: (context, candidateData, rejectedData) {
        return Stack(
          fit: StackFit.expand,
          children: [
            widget.child,
            // Drop indicator overlay
            if (_isDragOver)
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.05),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _handleDrop(
    BuildContext context,
    DragTargetDetails<DraggableSidebarImage> details,
  ) {
    HapticFeedback.mediumImpact();
    final renderBox = context.findRenderObject() as RenderBox;
    final localOffset = renderBox.globalToLocal(details.offset);
    final viewportSize = renderBox.size;

    final dropPosition = calculateDropPosition(
      dropOffset: localOffset,
      scrollOffset: widget.getScrollOffset(),
      scale: widget.scale,
      document: widget.document,
      viewportSize: viewportSize,
    );

    if (dropPosition == null) {
      // Drop outside any page - place on first visible page at center
      _placeImageAtPageCenter(details.data, 0);
      return;
    }

    // Calculate default image size (fit within page bounds)
    final imageData = details.data;
    final defaultSize = _calculateDefaultSize(
      imageAspectRatio: imageData.aspectRatio,
      pageSize: dropPosition.pageSize,
    );

    // Adjust position so the image is centered at drop point
    final adjustedPosition = Offset(
      (dropPosition.position.dx - defaultSize.width / 2)
          .clamp(0, dropPosition.pageSize.width - defaultSize.width),
      (dropPosition.position.dy - defaultSize.height / 2)
          .clamp(0, dropPosition.pageSize.height - defaultSize.height),
    );

    // Add the placed image
    ref.read(placedImagesProvider.notifier).addImage(
          sourceImageId: imageData.sourceImageId,
          imagePath: imageData.imagePath,
          pageIndex: dropPosition.pageIndex,
          position: adjustedPosition,
          size: defaultSize,
        );

    // Mark document as dirty
    ref.read(documentDirtyProvider.notifier).markDirty();

    // Select the newly placed image
    // Note: We can't get the ID here since addImage generates it internally
    // We'll select the last added image
    final images = ref.read(placedImagesProvider);
    if (images.isNotEmpty) {
      ref.read(editorSelectionProvider.notifier).select(images.last.id);
    }
  }

  void _placeImageAtPageCenter(DraggableSidebarImage data, int pageIndex) {
    HapticFeedback.mediumImpact();
    if (pageIndex >= widget.document.pages.length) return;

    final page = widget.document.pages[pageIndex];
    final pageSize = Size(page.width, page.height);
    final defaultSize = _calculateDefaultSize(
      imageAspectRatio: data.aspectRatio,
      pageSize: pageSize,
    );

    final centerPosition = Offset(
      (pageSize.width - defaultSize.width) / 2,
      (pageSize.height - defaultSize.height) / 2,
    );

    ref.read(placedImagesProvider.notifier).addImage(
          sourceImageId: data.sourceImageId,
          imagePath: data.imagePath,
          pageIndex: pageIndex,
          position: centerPosition,
          size: defaultSize,
        );

    ref.read(documentDirtyProvider.notifier).markDirty();
  }

  /// Calculate default size for placed image (fit within reasonable bounds).
  Size _calculateDefaultSize({
    required double imageAspectRatio,
    required Size pageSize,
  }) {
    return ImageSizeCalculator.calculatePlacedSize(
      aspectRatio: imageAspectRatio,
      pageSize: pageSize,
    );
  }
}
