import 'package:flutter/material.dart';

import 'package:minipdfsign/domain/entities/sidebar_image.dart';
import 'package:minipdfsign/l10n/generated/app_localizations.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/bottom_sheet_constants.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/image_grid_item.dart';

/// Expanded state content: grid view of images with header.
class ExpandedContent extends StatelessWidget {
  const ExpandedContent({
    required this.images,
    required this.scrollController,
    required this.showHeader,
    required this.isEditMode,
    required this.onEditTap,
    required this.onAddTap,
    required this.onDeleteTap,
    this.onDragStarted,
    this.onDragEnd,
    super.key,
  });

  final List<SidebarImage> images;
  final ScrollController scrollController;
  final bool showHeader;
  final bool isEditMode;
  final VoidCallback onEditTap;
  final VoidCallback onAddTap;
  final void Function(String imageId) onDeleteTap;
  final VoidCallback? onDragStarted;
  final VoidCallback? onDragEnd;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        if (showHeader) _buildHeader(context, l10n),
        Expanded(
          child: _buildGrid(context, l10n),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Container(
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
            onPressed: onEditTap,
            child: Text(isEditMode ? l10n.done : l10n.menuEdit),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context, AppLocalizations l10n) {
    // Total items = images + 1 for add button
    final itemCount = images.length + 1;

    return GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(BottomSheetConstants.thumbnailPadding),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: BottomSheetConstants.gridColumns,
        crossAxisSpacing: BottomSheetConstants.gridSpacing,
        mainAxisSpacing: BottomSheetConstants.gridSpacing,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // Last item is the add button
        if (index == images.length) {
          return _AddButtonGridItem(
            onTap: onAddTap,
            showLabel: showHeader,
            l10n: l10n,
          );
        }

        final image = images[index];
        return ImageGridItem(
          image: image,
          showDeleteButton: isEditMode,
          onDelete: () => onDeleteTap(image.id),
          onDragStarted: onDragStarted,
          onDragEnd: onDragEnd,
        );
      },
    );
  }
}

/// Add button as a grid item.
class _AddButtonGridItem extends StatelessWidget {
  const _AddButtonGridItem({
    required this.onTap,
    required this.showLabel,
    required this.l10n,
  });

  final VoidCallback onTap;
  final bool showLabel;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
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
          ),
          if (showLabel) ...[
            const SizedBox(height: 4),
            Text(
              l10n.addImage,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
