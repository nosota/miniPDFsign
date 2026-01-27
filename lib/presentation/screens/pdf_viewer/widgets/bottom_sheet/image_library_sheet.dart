import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:minipdfsign/domain/entities/sidebar_image.dart';
import 'package:minipdfsign/l10n/generated/app_localizations.dart';
import 'package:minipdfsign/presentation/providers/repository_providers.dart';
import 'package:minipdfsign/presentation/providers/sidebar/sidebar_images_provider.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/bottom_sheet_constants.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/collapsed_content.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/empty_library_state.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/image_grid_item.dart';

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

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSizeChanged);
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
    setState(() => _isDragHandlePressed = true);
    HapticFeedback.lightImpact();
  }

  void _onDragHandlePressEnd() {
    setState(() => _isDragHandlePressed = false);
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
        return Container(
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
            data: (images) => _buildScrollableContent(images, scrollController),
            loading: () => _buildLoadingState(scrollController),
            error: (_, __) => _buildErrorState(scrollController),
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
    if (images.isEmpty) {
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
