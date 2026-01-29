import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:minipdfsign/domain/entities/pdf_document_info.dart';
import 'package:minipdfsign/domain/entities/placed_image.dart';
import 'package:minipdfsign/l10n/generated/app_localizations.dart';
import 'package:minipdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:minipdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:minipdfsign/presentation/providers/onboarding/onboarding_provider.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/pdf_viewer/pdf_viewer_constants.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/pdf_viewer/placed_image_overlay.dart';
import 'package:minipdfsign/presentation/widgets/coach_mark/coach_mark_controller.dart';

/// Layer that renders placed images outside the ScrollView.
///
/// This architectural choice prevents gesture conflicts between:
/// - ScrollView's drag recognizer (scroll)
/// - Image handles' pan recognizers (resize/rotate)
///
/// The layer listens to scroll changes and repositions images accordingly.
class PlacedImagesLayer extends ConsumerStatefulWidget {
  const PlacedImagesLayer({
    required this.document,
    required this.scale,
    required this.scrollController,
    required this.horizontalScrollController,
    required this.viewportSize,
    required this.contentWidth,
    super.key,
  });

  /// The PDF document info (for page dimensions).
  final PdfDocumentInfo document;

  /// Current zoom scale.
  final double scale;

  /// Vertical scroll controller from PdfPageList.
  final ScrollController scrollController;

  /// Horizontal scroll controller from PdfPageList.
  final ScrollController? horizontalScrollController;

  /// Viewport size for clipping optimization.
  final Size viewportSize;

  /// Content width (for horizontal centering calculation).
  final double contentWidth;

  @override
  ConsumerState<PlacedImagesLayer> createState() => _PlacedImagesLayerState();
}

class _PlacedImagesLayerState extends ConsumerState<PlacedImagesLayer> {
  double _verticalOffset = 0;
  double _horizontalOffset = 0;

  /// Tracks the previous image count to detect when images are placed.
  int _previousImageCount = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
    widget.horizontalScrollController?.addListener(_onScroll);
    _updateOffsets();
  }

  @override
  void didUpdateWidget(PlacedImagesLayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle scroll controller changes
    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController.removeListener(_onScroll);
      widget.scrollController.addListener(_onScroll);
    }
    if (oldWidget.horizontalScrollController !=
        widget.horizontalScrollController) {
      oldWidget.horizontalScrollController?.removeListener(_onScroll);
      widget.horizontalScrollController?.addListener(_onScroll);
    }

    _updateOffsets();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    widget.horizontalScrollController?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    _updateOffsets();
  }

  void _updateOffsets() {
    final newVertical = widget.scrollController.hasClients
        ? widget.scrollController.offset
        : 0.0;
    final newHorizontal = widget.horizontalScrollController?.hasClients == true
        ? widget.horizontalScrollController!.offset
        : 0.0;

    if (newVertical != _verticalOffset || newHorizontal != _horizontalOffset) {
      setState(() {
        _verticalOffset = newVertical;
        _horizontalOffset = newHorizontal;
      });
    }
  }

  /// Shows the "Resize object" onboarding hint if not yet shown.
  void _maybeShowResizeHint(Rect targetRect) {
    final onboarding = ref.read(onboardingProvider.notifier);
    if (onboarding.shouldShow(OnboardingStep.resizeObject)) {
      final l10n = AppLocalizations.of(context);
      if (l10n == null) return;

      // Schedule for next frame to ensure the widget is rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        CoachMarkController.showAtRect(
          context: context,
          targetRect: targetRect,
          message: l10n.onboardingResizeObject,
          onDismiss: () {
            onboarding.markShown(OnboardingStep.resizeObject);
          },
        );
      });
    }
  }

  /// Calculates the top position of a page in document coordinates.
  double _getPageTopOffset(int pageIndex) {
    double offset = PdfViewerConstants.verticalPadding;
    for (int i = 0; i < pageIndex; i++) {
      final page = widget.document.pages[i];
      offset += page.height * widget.scale + PdfViewerConstants.pageGap;
    }
    return offset;
  }

  /// Calculates the horizontal offset for centering a page in viewport.
  double _getPageHorizontalOffset(int pageIndex) {
    final page = widget.document.pages[pageIndex];
    final pageWidth = page.width * widget.scale;

    // Check if horizontal scroll is active
    final needsHorizontalScroll = widget.contentWidth > widget.viewportSize.width;

    if (needsHorizontalScroll) {
      // When scrolling horizontally, pages have padding
      return PdfViewerConstants.horizontalPadding - _horizontalOffset;
    } else {
      // Center the page in viewport
      return (widget.viewportSize.width - pageWidth) / 2;
    }
  }

  /// Checks if an image is potentially visible in the viewport.
  bool _isImageVisible(PlacedImage image, double pageTop, double pageLeft) {
    final scale = widget.scale;
    final imageTop = pageTop + image.position.dy * scale - _verticalOffset;
    final imageLeft = pageLeft + image.position.dx * scale;
    final imageBottom = imageTop + image.size.height * scale;
    final imageRight = imageLeft + image.size.width * scale;

    // Add generous padding for handles and rotation
    const padding = 100.0;

    return imageBottom + padding >= 0 &&
        imageTop - padding <= widget.viewportSize.height &&
        imageRight + padding >= 0 &&
        imageLeft - padding <= widget.viewportSize.width;
  }

  @override
  Widget build(BuildContext context) {
    final allImages = ref.watch(placedImagesProvider);
    final selectedId = ref.watch(editorSelectionProvider);

    // Detect when the first image is placed (for hint 5)
    final currentCount = allImages.length;
    final wasEmpty = _previousImageCount == 0;
    final isNotEmpty = currentCount > 0;
    Rect? firstImageRect;

    if (allImages.isEmpty) {
      _previousImageCount = 0;
      return const SizedBox.shrink();
    }

    // Group images by page for efficient processing
    final imagesByPage = <int, List<PlacedImage>>{};
    for (final image in allImages) {
      imagesByPage.putIfAbsent(image.pageIndex, () => []).add(image);
    }

    // Build visible image widgets
    final visibleWidgets = <Widget>[];

    for (final entry in imagesByPage.entries) {
      final pageIndex = entry.key;
      final pageImages = entry.value;

      // Skip if page doesn't exist
      if (pageIndex >= widget.document.pages.length) continue;

      final pageTop = _getPageTopOffset(pageIndex);
      final pageLeft = _getPageHorizontalOffset(pageIndex);

      for (final image in pageImages) {
        // Visibility check for optimization
        if (!_isImageVisible(image, pageTop, pageLeft)) continue;

        // Calculate screen position
        final screenY = pageTop + image.position.dy * widget.scale - _verticalOffset;
        final screenX = pageLeft + image.position.dx * widget.scale;
        final screenWidth = image.size.width * widget.scale;
        final screenHeight = image.size.height * widget.scale;

        // Store first image rect for onboarding hint
        if (wasEmpty && isNotEmpty && firstImageRect == null) {
          firstImageRect = Rect.fromLTWH(screenX, screenY, screenWidth, screenHeight);
        }

        visibleWidgets.add(
          PlacedImageWidget(
            key: ValueKey(image.id),
            image: image,
            scale: widget.scale,
            isSelected: image.id == selectedId,
            screenOffset: Offset(screenX, screenY),
          ),
        );
      }
    }

    // Show resize hint when first image is placed
    if (wasEmpty && isNotEmpty && firstImageRect != null) {
      _maybeShowResizeHint(firstImageRect);
    }
    _previousImageCount = currentCount;

    if (visibleWidgets.isEmpty) {
      return const SizedBox.shrink();
    }

    // Use Stack with no clipping to allow handles to extend beyond viewport
    return Stack(
      clipBehavior: Clip.none,
      children: visibleWidgets,
    );
  }
}
