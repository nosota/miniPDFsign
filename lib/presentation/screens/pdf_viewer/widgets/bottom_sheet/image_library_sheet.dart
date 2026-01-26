import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:minipdfsign/domain/entities/sidebar_image.dart';
import 'package:minipdfsign/l10n/generated/app_localizations.dart';
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

  Future<void> _pickImages() async {
    final l10n = AppLocalizations.of(context)!;
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      dialogTitle: l10n.selectImages,
    );

    if (result != null && result.files.isNotEmpty) {
      final paths = result.files
          .where((f) => f.path != null)
          .map((f) => f.path!)
          .toList();

      if (paths.isNotEmpty) {
        await ref.read(sidebarImagesProvider.notifier).addImages(paths);
      }
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
                  error: (_, __) => EmptyLibraryState(onAddTap: _pickImages),
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
      return EmptyLibraryState(onAddTap: _pickImages);
    }

    if (_isCollapsed) {
      return CollapsedContent(
        images: images,
        onAddTap: _pickImages,
        onDragStarted: _collapseSheet,
      );
    }

    return ExpandedContent(
      images: images,
      scrollController: scrollController,
      showHeader: _isExpanded,
      isEditMode: _isEditMode,
      onEditTap: _toggleEditMode,
      onAddTap: _pickImages,
      onDeleteTap: _deleteImage,
      onDragStarted: _collapseSheet,
    );
  }
}
