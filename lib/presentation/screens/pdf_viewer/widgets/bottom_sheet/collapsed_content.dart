import 'package:flutter/material.dart';

import 'package:minipdfsign/domain/entities/sidebar_image.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/bottom_sheet_constants.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/image_grid_item.dart';

/// Collapsed state content: horizontal scroll of thumbnails.
class CollapsedContent extends StatelessWidget {
  const CollapsedContent({
    required this.images,
    required this.onAddTap,
    this.onDragStarted,
    this.onDragEnd,
    super.key,
  });

  final List<SidebarImage> images;
  final VoidCallback onAddTap;
  final VoidCallback? onDragStarted;
  final VoidCallback? onDragEnd;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: BottomSheetConstants.thumbnailSizeCollapsed +
          BottomSheetConstants.thumbnailPadding * 2,
      child: Row(
        children: [
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: BottomSheetConstants.thumbnailPadding,
                vertical: BottomSheetConstants.thumbnailPadding,
              ),
              itemCount: images.length,
              separatorBuilder: (context, index) => const SizedBox(
                width: BottomSheetConstants.gridSpacing,
              ),
              itemBuilder: (context, index) {
                return ImageGridItem(
                  image: images[index],
                  size: BottomSheetConstants.thumbnailSizeCollapsed,
                  onDragStarted: onDragStarted,
                  onDragEnd: onDragEnd,
                );
              },
            ),
          ),
          _AddButton(onTap: onAddTap),
          const SizedBox(width: BottomSheetConstants.thumbnailPadding),
        ],
      ),
    );
  }
}

/// Add button for collapsed state.
class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: BottomSheetConstants.thumbnailSizeCollapsed,
        height: BottomSheetConstants.thumbnailSizeCollapsed,
        decoration: BoxDecoration(
          color: BottomSheetConstants.thumbnailBackgroundColor,
          borderRadius: BorderRadius.circular(
            BottomSheetConstants.thumbnailBorderRadius,
          ),
        ),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.primary,
          size: 28,
        ),
      ),
    );
  }
}
