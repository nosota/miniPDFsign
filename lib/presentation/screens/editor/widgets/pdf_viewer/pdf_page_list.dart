import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_page_cache_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_page_item.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_viewer_constants.dart';

/// Virtualized list of PDF pages with continuous scroll.
class PdfPageList extends ConsumerStatefulWidget {
  const PdfPageList({
    required this.document,
    required this.scale,
    required this.onPageChanged,
    required this.onScroll,
    this.scrollController,
    super.key,
  });

  /// The PDF document to display.
  final PdfDocumentInfo document;

  /// Current scale factor for rendering.
  final double scale;

  /// Called when the current visible page changes.
  final void Function(int pageNumber) onPageChanged;

  /// Called when scroll occurs (for showing page indicator).
  final VoidCallback onScroll;

  /// Optional external scroll controller.
  final ScrollController? scrollController;

  @override
  ConsumerState<PdfPageList> createState() => PdfPageListState();
}

class PdfPageListState extends ConsumerState<PdfPageList> {
  late ScrollController _verticalController;
  ScrollController _horizontalController = ScrollController();
  bool _ownsVerticalController = false;
  int _currentPage = 1;
  double _previousScale = 1.0;
  double _viewportWidth = 0;

  ScrollController get scrollController => _verticalController;

  @override
  void initState() {
    super.initState();
    _initScrollController();
    _previousScale = widget.scale;
  }

  void _initScrollController() {
    if (widget.scrollController != null) {
      _verticalController = widget.scrollController!;
      _ownsVerticalController = false;
    } else {
      _verticalController = ScrollController();
      _ownsVerticalController = true;
    }
    _verticalController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _verticalController.removeListener(_onScroll);
    if (_ownsVerticalController) {
      _verticalController.dispose();
    }
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PdfPageList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle scroll controller change
    if (widget.scrollController != oldWidget.scrollController) {
      _verticalController.removeListener(_onScroll);
      if (_ownsVerticalController) {
        _verticalController.dispose();
      }
      _initScrollController();
    }

    // Handle scale change - maintain center focus and update visible pages
    if (oldWidget.scale != widget.scale && _verticalController.hasClients) {
      _adjustScrollForScaleChange(oldWidget.scale, widget.scale);
      // Update visible pages when scale changes to trigger correct renders
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _verticalController.hasClients) {
          _updateVisiblePages();
        }
      });
    }

    _previousScale = widget.scale;
  }

  void _adjustScrollForScaleChange(double oldScale, double newScale) {
    if (!_verticalController.hasClients) return;

    final viewportHeight = _verticalController.position.viewportDimension;
    final currentOffset = _verticalController.offset;

    // Calculate the center point in document coordinates
    final centerOffset = currentOffset + viewportHeight / 2;

    // Calculate the position ratio at old scale
    final oldTotalHeight = _calculateTotalHeight(oldScale);
    final positionRatio = centerOffset / oldTotalHeight;

    // Calculate new offset to maintain center
    final newTotalHeight = _calculateTotalHeight(newScale);
    final newCenterOffset = newTotalHeight * positionRatio;
    final newOffset = newCenterOffset - viewportHeight / 2;

    // Apply new offset
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_verticalController.hasClients) {
        final clampedOffset = newOffset.clamp(
          0.0,
          _verticalController.position.maxScrollExtent,
        );
        _verticalController.jumpTo(clampedOffset);
      }
    });
  }

  void _onScroll() {
    widget.onScroll();
    _updateVisiblePages();
    _updateCurrentPage();
  }

  void _updateVisiblePages() {
    if (!_verticalController.hasClients) return;

    final viewportHeight = _verticalController.position.viewportDimension;
    final scrollOffset = _verticalController.offset;

    // Calculate which pages are visible
    double cumulativeHeight = PdfViewerConstants.verticalPadding;
    int firstVisible = 1;
    int lastVisible = 1;

    for (int i = 0; i < widget.document.pages.length; i++) {
      final page = widget.document.pages[i];
      final pageHeight = page.height * widget.scale;
      final pageTop = cumulativeHeight;
      final pageBottom = cumulativeHeight + pageHeight;

      if (pageBottom >= scrollOffset && pageTop <= scrollOffset + viewportHeight) {
        if (firstVisible == 1 || i + 1 < firstVisible) {
          firstVisible = i + 1;
        }
        lastVisible = i + 1;
      }

      cumulativeHeight += pageHeight + PdfViewerConstants.pageGap;
    }

    ref.read(visiblePagesProvider.notifier).updateVisibleRange(
          firstVisible: firstVisible,
          lastVisible: lastVisible,
          totalPages: widget.document.pageCount,
        );
  }

  void _updateCurrentPage() {
    if (!_verticalController.hasClients) return;

    final scrollOffset = _verticalController.offset;
    final viewportCenter = scrollOffset + _verticalController.position.viewportDimension / 2;

    double cumulativeHeight = PdfViewerConstants.verticalPadding;
    int centerPage = 1;

    for (int i = 0; i < widget.document.pages.length; i++) {
      final page = widget.document.pages[i];
      final pageHeight = page.height * widget.scale;
      final pageTop = cumulativeHeight;
      final pageBottom = cumulativeHeight + pageHeight;

      // Current page = page that contains the viewport center point
      // Include half of the gap after the page for smoother transitions
      if (viewportCenter >= pageTop &&
          viewportCenter < pageBottom + PdfViewerConstants.pageGap / 2) {
        centerPage = i + 1;
        break;
      }

      cumulativeHeight += pageHeight + PdfViewerConstants.pageGap;
    }

    if (centerPage != _currentPage) {
      _currentPage = centerPage;
      widget.onPageChanged(centerPage);
    }
  }

  double _calculateTotalHeight([double? scale]) {
    final s = scale ?? widget.scale;
    double totalHeight = PdfViewerConstants.verticalPadding * 2;
    for (final page in widget.document.pages) {
      totalHeight += page.height * s;
    }
    totalHeight += PdfViewerConstants.pageGap * (widget.document.pageCount - 1);
    return totalHeight;
  }

  /// Calculates the width of the widest page at current scale.
  double _calculateContentWidth([double? scale]) {
    final s = scale ?? widget.scale;
    double maxWidth = 0;
    for (final page in widget.document.pages) {
      final scaledWidth = page.width * s;
      if (scaledWidth > maxWidth) {
        maxWidth = scaledWidth;
      }
    }
    return maxWidth;
  }

  /// Scrolls to show the specified page.
  void scrollToPage(int pageNumber, {bool animate = true}) {
    if (!_verticalController.hasClients) return;

    final targetPage = pageNumber.clamp(1, widget.document.pageCount);
    double targetOffset = PdfViewerConstants.verticalPadding;

    for (int i = 0; i < targetPage - 1; i++) {
      final page = widget.document.pages[i];
      targetOffset += page.height * widget.scale + PdfViewerConstants.pageGap;
    }

    // Center the page in viewport if possible
    final viewportHeight = _verticalController.position.viewportDimension;
    final pageHeight = widget.document.pages[targetPage - 1].height * widget.scale;

    if (pageHeight < viewportHeight) {
      targetOffset -= (viewportHeight - pageHeight) / 2;
    }

    targetOffset = targetOffset.clamp(0.0, _verticalController.position.maxScrollExtent);

    if (animate) {
      _verticalController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _verticalController.jumpTo(targetOffset);
    }
  }

  /// Scrolls by a delta amount in both directions.
  void scrollBy(double deltaX, double deltaY, {bool animate = true}) {
    // Vertical scroll
    if (_verticalController.hasClients && deltaY != 0) {
      final newVerticalOffset = (_verticalController.offset + deltaY).clamp(
        0.0,
        _verticalController.position.maxScrollExtent,
      );

      if (animate) {
        _verticalController.animateTo(
          newVerticalOffset,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      } else {
        _verticalController.jumpTo(newVerticalOffset);
      }
    }

    // Horizontal scroll
    if (_horizontalController.hasClients && deltaX != 0) {
      final newHorizontalOffset = (_horizontalController.offset + deltaX).clamp(
        0.0,
        _horizontalController.position.maxScrollExtent,
      );

      if (animate) {
        _horizontalController.animateTo(
          newHorizontalOffset,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      } else {
        _horizontalController.jumpTo(newHorizontalOffset);
      }
    }
  }

  /// Adjusts scroll position after a focal-point zoom.
  /// Keeps the document point at [focalPoint] at the same screen position.
  void adjustScrollForFocalZoom({
    required double oldScale,
    required double newScale,
    required Offset focalPoint,
  }) {
    final scaleRatio = newScale / oldScale;

    // Vertical adjustment
    double? newVerticalOffset;
    if (_verticalController.hasClients) {
      final oldVerticalOffset = _verticalController.offset;
      final focalY = focalPoint.dy;
      newVerticalOffset = oldVerticalOffset * scaleRatio + focalY * (scaleRatio - 1);
    }

    // Horizontal adjustment
    double? newHorizontalOffset;
    if (_horizontalController.hasClients) {
      final oldHorizontalOffset = _horizontalController.offset;
      final focalX = focalPoint.dx;
      newHorizontalOffset = oldHorizontalOffset * scaleRatio + focalX * (scaleRatio - 1);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Apply vertical scroll
      if (_verticalController.hasClients && newVerticalOffset != null) {
        final clampedVertical = newVerticalOffset.clamp(
          0.0,
          _verticalController.position.maxScrollExtent,
        );
        _verticalController.jumpTo(clampedVertical);
      }

      // Apply horizontal scroll
      if (_horizontalController.hasClients && newHorizontalOffset != null) {
        final clampedHorizontal = newHorizontalOffset.clamp(
          0.0,
          _horizontalController.position.maxScrollExtent,
        );
        _horizontalController.jumpTo(clampedHorizontal);
      }
    });
  }

  /// Returns scroll offset for center-focused zoom calculations.
  double get scrollOffset => _verticalController.hasClients ? _verticalController.offset : 0;

  /// Returns horizontal scroll offset.
  double get horizontalScrollOffset =>
      _horizontalController.hasClients ? _horizontalController.offset : 0;

  /// Returns combined scroll offset (horizontal, vertical).
  Offset get scrollOffsetXY => Offset(horizontalScrollOffset, scrollOffset);

  /// Returns viewport dimensions.
  double get viewportHeight =>
      _verticalController.hasClients ? _verticalController.position.viewportDimension : 0;

  @override
  Widget build(BuildContext context) {
    final visiblePages = ref.watch(visiblePagesProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Store viewport width for centering calculations
        _viewportWidth = constraints.maxWidth;

        // Initialize visible pages on first build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_verticalController.hasClients) {
            _updateVisiblePages();
          }
        });

        final contentWidth = _calculateContentWidth();
        final contentHeight = _calculateTotalHeight();

        // Check if horizontal scroll is needed
        final needsHorizontalScroll = contentWidth > constraints.maxWidth;

        // When horizontal scroll is needed, add padding to create "floating page" effect
        // Content width includes page + horizontal padding on both sides
        final effectiveWidth = needsHorizontalScroll
            ? contentWidth + PdfViewerConstants.horizontalPadding * 2
            : math.max(contentWidth, constraints.maxWidth);

        Widget content = SizedBox(
          width: effectiveWidth,
          height: contentHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: PdfViewerConstants.verticalPadding,
              // Add horizontal padding when scrolling horizontally
              horizontal: needsHorizontalScroll
                  ? PdfViewerConstants.horizontalPadding
                  : 0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < widget.document.pages.length; i++) ...[
                  PdfPageItem(
                    pageInfo: widget.document.pages[i],
                    scale: widget.scale,
                    isVisible: visiblePages.contains(i + 1),
                  ),
                  if (i < widget.document.pages.length - 1)
                    const SizedBox(height: PdfViewerConstants.pageGap),
                ],
              ],
            ),
          ),
        );

        // Vertical scroll
        Widget verticalScroll = SingleChildScrollView(
          controller: _verticalController,
          physics: const ClampingScrollPhysics(),
          child: content,
        );

        // Wrap in horizontal scroll if needed
        if (needsHorizontalScroll) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _horizontalController,
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
              width: effectiveWidth,
              height: constraints.maxHeight,
              child: verticalScroll,
            ),
          );
        }

        return verticalScroll;
      },
    );
  }
}
