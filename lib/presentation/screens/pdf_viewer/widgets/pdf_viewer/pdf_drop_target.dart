import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:minipdfsign/core/utils/image_size_calculator.dart';
import 'package:minipdfsign/domain/entities/pdf_document_info.dart';
import 'package:minipdfsign/presentation/providers/sidebar/sidebar_images_provider.dart';
import 'package:minipdfsign/presentation/providers/viewer_session/viewer_session_provider.dart';
import 'package:minipdfsign/presentation/providers/viewer_session/viewer_session_scope.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/pdf_viewer/pdf_viewer_constants.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/sidebar/draggable_image_card.dart';

/// Mixin for calculating drop positions on PDF pages.
mixin PdfDropPositionCalculator {
  /// Calculates the page index and position from a drop offset.
  ///
  /// Returns null if the drop is outside any page.
  ///
  /// [appBarPadding] must match the top padding used in PdfPageList
  /// (verticalPadding + appBarPadding).
  DropPosition? calculateDropPosition({
    required Offset dropOffset,
    required Offset scrollOffset,
    required double scale,
    required PdfDocumentInfo document,
    required Size viewportSize,
    required double appBarPadding,
  }) {
    // Convert drop position to document coordinates
    final documentY = dropOffset.dy + scrollOffset.dy;
    final documentX = dropOffset.dx + scrollOffset.dx;

    // Find which page the drop landed on
    // Must match PdfPageList layout: top padding = verticalPadding + appBarPadding
    double cumulativeY = PdfViewerConstants.verticalPadding + appBarPadding;

    for (int i = 0; i < document.pages.length; i++) {
      final page = document.pages[i];
      final scaledPageWidth = page.width * scale;
      final scaledPageHeight = page.height * scale;

      // Calculate page X position
      // Must match PdfPageList layout which uses Column with crossAxisAlignment.center
      final contentWidth = _calculateContentWidth(document, scale);
      final needsHorizontalScroll = contentWidth > viewportSize.width;

      final double pageLeft;
      if (needsHorizontalScroll) {
        // When horizontal scroll is active:
        // - Pages have horizontalPadding from left edge
        // - Narrower pages are centered within contentWidth by Column
        final centeringOffset = (contentWidth - scaledPageWidth) / 2;
        pageLeft = PdfViewerConstants.horizontalPadding + centeringOffset;
      } else {
        // Center the page in viewport
        pageLeft = (viewportSize.width - scaledPageWidth) / 2;
      }

      final pageTop = cumulativeY;
      final pageBottom = cumulativeY + scaledPageHeight;
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
    required this.appBarPadding,
    super.key,
  });

  final Widget child;
  final PdfDocumentInfo document;
  final double scale;
  final Offset Function() getScrollOffset;

  /// Top padding for AppBar (status bar + toolbar height).
  final double appBarPadding;

  @override
  ConsumerState<PdfDropTarget> createState() => _PdfDropTargetState();
}

class _PdfDropTargetState extends ConsumerState<PdfDropTarget>
    with PdfDropPositionCalculator {
  bool _isDragOver = false;

  /// Session ID obtained from ViewerSessionScope.
  late String _sessionId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sessionId = ViewerSessionScope.of(context);
  }

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
      appBarPadding: widget.appBarPadding,
    );

    if (dropPosition == null) {
      // Drop outside any page - place on first visible page at center
      _placeImageAtPageCenter(details.data, 0);
      return;
    }

    // Calculate default image size (use saved size or fit within page bounds)
    final imageData = details.data;
    final defaultSize = _calculateDefaultSize(
      sourceImageId: imageData.sourceImageId,
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
    ref.read(sessionPlacedImagesProvider(_sessionId).notifier).addImage(
          sourceImageId: imageData.sourceImageId,
          imagePath: imageData.imagePath,
          pageIndex: dropPosition.pageIndex,
          position: adjustedPosition,
          size: defaultSize,
        );

    // Mark document as dirty
    ref.read(sessionDocumentDirtyProvider(_sessionId).notifier).markDirty();

    // Select the newly placed image
    // Note: We can't get the ID here since addImage generates it internally
    // We'll select the last added image
    final images = ref.read(sessionPlacedImagesProvider(_sessionId));
    if (images.isNotEmpty) {
      ref.read(sessionEditorSelectionProvider(_sessionId).notifier).select(images.last.id);
    }
  }

  void _placeImageAtPageCenter(DraggableSidebarImage data, int pageIndex) {
    HapticFeedback.mediumImpact();
    if (pageIndex >= widget.document.pages.length) return;

    final page = widget.document.pages[pageIndex];
    final pageSize = Size(page.width, page.height);
    final defaultSize = _calculateDefaultSize(
      sourceImageId: data.sourceImageId,
      imageAspectRatio: data.aspectRatio,
      pageSize: pageSize,
    );

    final centerPosition = Offset(
      (pageSize.width - defaultSize.width) / 2,
      (pageSize.height - defaultSize.height) / 2,
    );

    ref.read(sessionPlacedImagesProvider(_sessionId).notifier).addImage(
          sourceImageId: data.sourceImageId,
          imagePath: data.imagePath,
          pageIndex: pageIndex,
          position: centerPosition,
          size: defaultSize,
        );

    ref.read(sessionDocumentDirtyProvider(_sessionId).notifier).markDirty();
  }

  /// Calculate default size for placed image.
  ///
  /// Uses saved last-used size if available (absolute PDF points),
  /// otherwise falls back to default 40% page width calculation.
  Size _calculateDefaultSize({
    required String sourceImageId,
    required double imageAspectRatio,
    required Size pageSize,
  }) {
    final images = ref.read(sidebarImagesProvider).valueOrNull;
    final sidebarImage = images
        ?.where((img) => img.id == sourceImageId)
        .firstOrNull;

    final savedWidth = sidebarImage?.lastUsedWidth;
    final savedHeight = sidebarImage?.lastUsedHeight;
    if (savedWidth != null && savedHeight != null) {
      return Size(savedWidth, savedHeight);
    }

    return ImageSizeCalculator.calculatePlacedSize(
      aspectRatio: imageAspectRatio,
      pageSize: pageSize,
    );
  }
}
