import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:minipdfsign/domain/entities/sidebar_image.dart';
import 'package:minipdfsign/l10n/generated/app_localizations.dart';
import 'package:minipdfsign/presentation/providers/onboarding/onboarding_provider.dart';
import 'package:minipdfsign/presentation/providers/repository_providers.dart';
import 'package:minipdfsign/presentation/providers/sidebar/sidebar_images_provider.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/bottom_sheet_constants.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/collapsed_content.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/empty_library_state.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/image_grid_item.dart';
import 'package:minipdfsign/presentation/widgets/coach_mark/coach_mark_controller.dart';

/// Bottom sheet containing the image library.
///
/// Three states:
/// - Collapsed (~80px): horizontal scroll of thumbnails
/// - Half-expanded (~40%): grid view
/// - Expanded (~85%): grid view with header and edit button
class ImageLibrarySheet extends ConsumerStatefulWidget {
  const ImageLibrarySheet({super.key});

  @override
  ConsumerState<ImageLibrarySheet> createState() => _ImageLibrarySheetState();
}

class _ImageLibrarySheetState extends ConsumerState<ImageLibrarySheet> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();
  bool _isEditMode = false;
  double _currentSize = BottomSheetConstants.collapsedSize;
  bool _isDragHandlePressed = false;

  /// Key for the drag handle to show coach mark (hint 2).
  final _dragHandleKey = GlobalKey();

  /// Key for the add button in empty state to show coach mark (hint 3).
  final _addButtonKey = GlobalKey();

  /// Key for the first thumbnail to show coach mark (hint 4).
  final _firstThumbnailKey = GlobalKey();

  /// Tracks the previous image count to detect when images are added.
  int _previousImageCount = 0;

  /// Whether we've shown the swipe up hint for this session.
  bool _hasShownSwipeUpHint = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSizeChanged);
    // Schedule coach mark display after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _maybeShowSwipeUpHint();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onSizeChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onSizeChanged() {
    if (_controller.isAttached) {
      setState(() {
        _currentSize = _controller.size;
      });
    }
  }

  /// Shows the "Swipe up" onboarding hint if not yet shown.
  void _maybeShowSwipeUpHint() {
    if (_hasShownSwipeUpHint) return;

    final onboarding = ref.read(onboardingProvider.notifier);
    if (onboarding.shouldShow(OnboardingStep.swipeUp)) {
      final l10n = AppLocalizations.of(context);
      if (l10n == null) return;

      _hasShownSwipeUpHint = true;
      CoachMarkController.show(
        context: context,
        targetKey: _dragHandleKey,
        message: l10n.onboardingSwipeUp,
        onDismiss: () {
          onboarding.markShown(OnboardingStep.swipeUp);
        },
      );
    }
  }

  /// Shows the "Add image" onboarding hint if not yet shown.
  void _maybeShowAddImageHint() {
    final onboarding = ref.read(onboardingProvider.notifier);
    if (onboarding.shouldShow(OnboardingStep.addImage)) {
      final l10n = AppLocalizations.of(context);
      if (l10n == null) return;

      // Schedule for next frame to ensure the widget is rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        CoachMarkController.show(
          context: context,
          targetKey: _addButtonKey,
          message: l10n.onboardingAddImage,
          onDismiss: () {
            onboarding.markShown(OnboardingStep.addImage);
          },
        );
      });
    }
  }

  /// Shows the "Drag image" onboarding hint if not yet shown.
  void _maybeShowDragImageHint() {
    final onboarding = ref.read(onboardingProvider.notifier);
    if (onboarding.shouldShow(OnboardingStep.dragImage)) {
      final l10n = AppLocalizations.of(context);
      if (l10n == null) return;

      // Schedule for next frame to ensure the widget is rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        CoachMarkController.show(
          context: context,
          targetKey: _firstThumbnailKey,
          message: l10n.onboardingDragImage,
          onDismiss: () {
            onboarding.markShown(OnboardingStep.dragImage);
          },
        );
      });
    }
  }

  bool get _isCollapsed =>
      _currentSize < BottomSheetConstants.collapsedThreshold;

  bool get _isExpanded => _currentSize > BottomSheetConstants.halfExpandedSize;

  void _collapseSheet() {
    if (_controller.isAttached) {
      _controller.animateTo(
        BottomSheetConstants.collapsedSize,
        duration: BottomSheetConstants.snapAnimationDuration,
        curve: Curves.easeOut,
      );
    }
  }

  /// Cycle through sheet states on tap: collapsed → half → expanded → collapsed
  void _onDragHandleTap() {
    if (!_controller.isAttached) return;

    HapticFeedback.selectionClick();

    double targetSize;
    if (_currentSize < BottomSheetConstants.collapsedThreshold) {
      // Collapsed → Half-expanded
      targetSize = BottomSheetConstants.halfExpandedSize;
    } else if (_currentSize < BottomSheetConstants.halfExpandedSize + 0.1) {
      // Half-expanded → Expanded
      targetSize = BottomSheetConstants.expandedSize;
    } else {
      // Expanded → Collapsed
      targetSize = BottomSheetConstants.collapsedSize;
    }

    _controller.animateTo(
      targetSize,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
    );
  }

  void _onDragHandlePressStart() {
    if (!_isDragHandlePressed) {
      setState(() => _isDragHandlePressed = true);
      HapticFeedback.lightImpact();
    }
  }

  void _onDragHandlePressEnd() {
    if (_isDragHandlePressed) {
      setState(() => _isDragHandlePressed = false);
    }
  }

  /// Handles scroll notifications to highlight drag handle during any drag.
  bool _onScrollNotification(ScrollNotification notification) {
    // Only respond to notifications from the main scrollable (depth 0),
    // ignore nested scrollables like horizontal ListView in CollapsedContent
    if (notification.depth != 0) return false;

    if (notification is ScrollStartNotification) {
      _onDragHandlePressStart();
    } else if (notification is ScrollEndNotification) {
      _onDragHandlePressEnd();
    }
    return false; // Don't consume the notification
  }

  /// Shows the action sheet for adding images.
  void _showAddImageSheet() {
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                l10n.addImage,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Divider(height: 1),
            // Camera option (mobile only)
            if (Platform.isIOS || Platform.isAndroid)
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text(l10n.takePhoto),
                onTap: () {
                  HapticFeedback.selectionClick();
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
            ListTile(
              leading: const Icon(Icons.folder_outlined),
              title: Text(l10n.chooseFromFiles),
              onTap: () {
                Navigator.pop(context);
                _pickFromFiles();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l10n.chooseFromGallery),
              onTap: () {
                Navigator.pop(context);
                _pickFromGallery();
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.close),
              title: Text(l10n.cancel),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFromFiles() async {
    final pickerService = ref.read(imagePickerServiceProvider);
    final paths = await pickerService.pickFromFiles();

    if (paths.isNotEmpty) {
      await _addImages(paths);
    }
  }

  Future<void> _pickFromGallery() async {
    final pickerService = ref.read(imagePickerServiceProvider);
    final paths = await pickerService.pickFromGallery();

    if (paths.isNotEmpty) {
      await _addImages(paths);
    }
  }

  /// Takes a photo with camera and offers background removal.
  ///
  /// Always offers the option for camera photos because the primary use case
  /// is photographing signatures/stamps on paper, where background removal
  /// is almost always desired. ML-based removal handles shadows and uneven
  /// lighting without needing uniform background detection.
  Future<void> _takePhoto() async {
    final pickerService = ref.read(imagePickerServiceProvider);
    final imagePath = await pickerService.takePhoto();

    if (imagePath == null || !mounted) return;

    // Check if background removal is available on this platform
    final bgRemovalService = ref.read(backgroundRemovalServiceProvider);
    final isAvailable = await bgRemovalService.isAvailable();

    if (!isAvailable || !mounted) {
      await _addImages([imagePath]);
      return;
    }

    // Always offer background removal for camera photos
    final shouldRemove = await _showBackgroundRemovalDialog(imagePath);

    if (!mounted) return;

    if (shouldRemove == true) {
      await _processBackgroundRemoval(imagePath, null);
    } else if (shouldRemove == false) {
      await _addImages([imagePath]);
    }
    // null means cancelled, do nothing
  }

  /// Shows a loading dialog with a message.
  void _showLoadingDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (dialogContext) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              ),
              const SizedBox(width: 16),
              Flexible(child: Text(message)),
            ],
          ),
        ),
      ),
    );
  }

  /// Shows dialog asking user if they want to remove the background.
  Future<bool?> _showBackgroundRemovalDialog(String imagePath) async {
    final l10n = AppLocalizations.of(context)!;

    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Preview image — adapts to actual aspect ratio
              Align(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 250),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.contain,
                      cacheWidth: 600,
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) return child;
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: frame != null
                              ? child
                              : Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                        );
                      },
                      errorBuilder: (context, error, stack) => Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.broken_image, size: 48),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.removeBackgroundTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.removeBackgroundMessage,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        Navigator.pop(sheetContext, false);
                      },
                      child: Text(l10n.keepOriginal, maxLines: 1),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        Navigator.pop(sheetContext, true);
                      },
                      child: Text(l10n.removeBackground, maxLines: 1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  /// Processes background removal and adds the result to library.
  Future<void> _processBackgroundRemoval(
    String imagePath, [
    ui.Color? backgroundColor,
  ]) async {
    final l10n = AppLocalizations.of(context)!;

    // Show loading indicator using root navigator
    if (!mounted) return;
    _showLoadingDialog(l10n.processingImage);

    try {
      final bgRemovalService = ref.read(backgroundRemovalServiceProvider);
      final result = await bgRemovalService.removeBackground(
        inputPath: imagePath,
        backgroundColor: backgroundColor,
      );

      if (!mounted) return;

      // Dismiss loading dialog using root navigator
      Navigator.of(context, rootNavigator: true).pop();

      if (result.isSuccess) {
        HapticFeedback.mediumImpact();
        await _addImages([result.outputPath!]);
      } else {
        // Show error and add original image
        HapticFeedback.heavyImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.backgroundRemovalFailed),
            behavior: SnackBarBehavior.floating,
          ),
        );
        await _addImages([imagePath]);
      }
    } catch (e) {
      if (!mounted) return;

      // Dismiss loading dialog using root navigator
      Navigator.of(context, rootNavigator: true).pop();

      // Show error and add original image
      HapticFeedback.heavyImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.backgroundRemovalFailed),
          behavior: SnackBarBehavior.floating,
        ),
      );
      await _addImages([imagePath]);
    }
  }

  Future<void> _addImages(List<String> paths) async {
    final result =
        await ref.read(sidebarImagesProvider.notifier).addImages(paths);

    if (!mounted) return;

    // Show error messages if any
    if (result.errors.isNotEmpty) {
      _showValidationErrors(result.errors);
    }
  }

  void _showValidationErrors(List<String> errorKeys) {
    final l10n = AppLocalizations.of(context)!;

    // Get unique errors and their counts
    final errorCounts = <String, int>{};
    for (final key in errorKeys) {
      errorCounts[key] = (errorCounts[key] ?? 0) + 1;
    }

    // Build error message
    final messages = errorCounts.entries.map((e) {
      final message = _getErrorMessage(l10n, e.key);
      return e.value > 1 ? '$message (${e.value})' : message;
    }).join('\n');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(messages),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _getErrorMessage(AppLocalizations l10n, String errorKey) {
    switch (errorKey) {
      case 'imageTooBig':
        return l10n.imageTooBig;
      case 'imageResolutionTooHigh':
        return l10n.imageResolutionTooHigh;
      case 'unsupportedImageFormat':
        return l10n.unsupportedImageFormat;
      case 'fileNotFound':
        return l10n.fileNotFound;
      default:
        return l10n.error;
    }
  }

  void _deleteImage(String imageId) {
    ref.read(sidebarImagesProvider.notifier).removeImage(imageId);
  }

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final imagesAsync = ref.watch(sidebarImagesProvider);

    return DraggableScrollableSheet(
      controller: _controller,
      initialChildSize: BottomSheetConstants.collapsedSize,
      minChildSize: BottomSheetConstants.collapsedSize,
      maxChildSize: BottomSheetConstants.expandedSize,
      snap: true,
      snapAnimationDuration: BottomSheetConstants.snapAnimationDuration,
      snapSizes: const [
        BottomSheetConstants.collapsedSize,
        BottomSheetConstants.halfExpandedSize,
        BottomSheetConstants.expandedSize,
      ],
      builder: (context, scrollController) {
        return NotificationListener<ScrollNotification>(
          onNotification: _onScrollNotification,
          child: Container(
            decoration: const BoxDecoration(
              color: BottomSheetConstants.backgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: imagesAsync.when(
              data: (images) =>
                  _buildScrollableContent(images, scrollController),
              loading: () => _buildLoadingState(scrollController),
              error: (_, __) => _buildErrorState(scrollController),
            ),
          ),
        );
      },
    );
  }

  /// Builds the entire scrollable content with drag handle at top.
  Widget _buildScrollableContent(
    List<SidebarImage> images,
    ScrollController scrollController,
  ) {
    // Detect when images are added (for hint 4)
    if (images.length > _previousImageCount && _previousImageCount == 0) {
      // First image was added, show the drag image hint
      _maybeShowDragImageHint();
    }
    _previousImageCount = images.length;

    if (images.isEmpty) {
      // Show add image hint when expanded and empty
      if (!_isCollapsed) {
        _maybeShowAddImageHint();
      }

      return CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(child: _buildDragHandle()),
          SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyLibraryState(
              onAddTap: _showAddImageSheet,
              addButtonKey: _addButtonKey,
            ),
          ),
        ],
      );
    }

    if (_isCollapsed) {
      return CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(child: _buildDragHandle()),
          SliverFillRemaining(
            hasScrollBody: false,
            child: CollapsedContent(
              images: images,
              onAddTap: _showAddImageSheet,
              onDragStarted: _collapseSheet,
              firstThumbnailKey: _firstThumbnailKey,
            ),
          ),
        ],
      );
    }

    // Expanded/Half-expanded state
    return _buildExpandedContent(images, scrollController);
  }

  /// Builds expanded content with drag handle inside the scrollable area.
  Widget _buildExpandedContent(
    List<SidebarImage> images,
    ScrollController scrollController,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final itemCount = images.length + 1; // +1 for add button

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        // Drag handle
        SliverToBoxAdapter(child: _buildDragHandle()),
        // Header (only in fully expanded state)
        if (_isExpanded)
          SliverToBoxAdapter(
            child: Container(
              height: BottomSheetConstants.headerHeight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.imagesTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  TextButton(
                    onPressed: _toggleEditMode,
                    child: Text(_isEditMode ? l10n.done : l10n.menuEdit),
                  ),
                ],
              ),
            ),
          ),
        // Grid of images
        SliverPadding(
          padding: const EdgeInsets.all(BottomSheetConstants.thumbnailPadding),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: BottomSheetConstants.gridColumns,
              crossAxisSpacing: BottomSheetConstants.gridSpacing,
              mainAxisSpacing: BottomSheetConstants.gridSpacing,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == images.length) {
                  return _buildAddButton(l10n);
                }
                final image = images[index];
                return ImageGridItem(
                  key: index == 0 ? _firstThumbnailKey : null,
                  image: image,
                  showDeleteButton: _isEditMode,
                  onDelete: () => _deleteImage(image.id),
                  onDragStarted: _collapseSheet,
                );
              },
              childCount: itemCount,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton(AppLocalizations l10n) {
    return GestureDetector(
      onTap: _showAddImageSheet,
      child: Container(
        decoration: BoxDecoration(
          color: BottomSheetConstants.thumbnailBackgroundColor,
          borderRadius: BorderRadius.circular(
            BottomSheetConstants.thumbnailBorderRadius,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.primary,
            size: 28,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(ScrollController scrollController) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverToBoxAdapter(child: _buildDragHandle()),
        const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }

  Widget _buildErrorState(ScrollController scrollController) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverToBoxAdapter(child: _buildDragHandle()),
        SliverFillRemaining(
          hasScrollBody: false,
          child: EmptyLibraryState(onAddTap: _showAddImageSheet),
        ),
      ],
    );
  }

  Widget _buildDragHandle() {
    final handleColor = _isDragHandlePressed
        ? BottomSheetConstants.dragHandleActiveColor
        : BottomSheetConstants.dragHandleColor;

    // Use Listener for visual feedback (doesn't block gesture propagation)
    // Use GestureDetector only for tap (state toggle)
    return Listener(
      onPointerDown: (_) => _onDragHandlePressStart(),
      onPointerUp: (_) => _onDragHandlePressEnd(),
      onPointerCancel: (_) => _onDragHandlePressEnd(),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _onDragHandleTap,
        child: Container(
          key: _dragHandleKey,
          height: BottomSheetConstants.dragHandleHeight,
          alignment: Alignment.center,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: _isDragHandlePressed
                ? BottomSheetConstants.dragHandleSize.width * 1.2
                : BottomSheetConstants.dragHandleSize.width,
            height: _isDragHandlePressed
                ? BottomSheetConstants.dragHandleSize.height * 1.5
                : BottomSheetConstants.dragHandleSize.height,
            decoration: BoxDecoration(
              color: handleColor,
              borderRadius: BorderRadius.circular(
                BottomSheetConstants.dragHandleRadius,
              ),
            ),
          ),
        ),
      ),
    );
  }

}
