import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:minipdfsign/domain/entities/sidebar_image.dart';
import 'package:minipdfsign/l10n/generated/app_localizations.dart';
import 'package:minipdfsign/presentation/providers/repository_providers.dart';
import 'package:minipdfsign/presentation/providers/sidebar/sidebar_images_provider.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/bottom_sheet_constants.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/collapsed_content.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/empty_library_state.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/expanded_content.dart';

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
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
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
          child: Column(
            children: [
              _buildDragHandle(),
              Expanded(
                child: imagesAsync.when(
                  data: (images) => _buildContent(images, scrollController),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (_, __) =>
                      EmptyLibraryState(onAddTap: _showAddImageSheet),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDragHandle() {
    return Container(
      height: BottomSheetConstants.dragHandleHeight,
      alignment: Alignment.center,
      child: Container(
        width: BottomSheetConstants.dragHandleSize.width,
        height: BottomSheetConstants.dragHandleSize.height,
        decoration: BoxDecoration(
          color: BottomSheetConstants.dragHandleColor,
          borderRadius: BorderRadius.circular(
            BottomSheetConstants.dragHandleRadius,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    List<SidebarImage> images,
    ScrollController scrollController,
  ) {
    if (images.isEmpty) {
      // Wrap empty state in scrollable for drag to work
      return CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyLibraryState(onAddTap: _showAddImageSheet),
          ),
        ],
      );
    }

    if (_isCollapsed) {
      // Wrap collapsed content in scrollable for drag to work
      return CustomScrollView(
        controller: scrollController,
        slivers: [
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

    return ExpandedContent(
      images: images,
      scrollController: scrollController,
      showHeader: _isExpanded,
      isEditMode: _isEditMode,
      onEditTap: _toggleEditMode,
      onAddTap: _showAddImageSheet,
      onDeleteTap: _deleteImage,
      onDragStarted: _collapseSheet,
    );
  }
}
