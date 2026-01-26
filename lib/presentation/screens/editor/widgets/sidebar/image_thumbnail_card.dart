import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:minipdfsign/core/constants/sidebar_constants.dart';
import 'package:minipdfsign/domain/entities/sidebar_image.dart';
import 'package:minipdfsign/presentation/providers/sidebar/sidebar_images_provider.dart';

/// A single image thumbnail card.
///
/// Shows the image with proportional scaling and a delete button.
class ImageThumbnailCard extends ConsumerStatefulWidget {
  const ImageThumbnailCard({
    required this.image,
    required this.isSelected,
    super.key,
  });

  final SidebarImage image;
  final bool isSelected;

  @override
  ConsumerState<ImageThumbnailCard> createState() => _ImageThumbnailCardState();
}

class _ImageThumbnailCardState extends ConsumerState<ImageThumbnailCard> {
  bool _showDeleteButton = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onLongPress: () {
        setState(() => _showDeleteButton = true);
      },
      onTap: () {
        if (_showDeleteButton) {
          setState(() => _showDeleteButton = false);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(
          right: SidebarConstants.thumbnailPadding,
          top: SidebarConstants.thumbnailPadding / 2,
          bottom: SidebarConstants.thumbnailPadding / 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SidebarConstants.thumbnailBorderRadius,
          ),
          border: Border.all(
            color: widget.isSelected
                ? theme.colorScheme.primary.withOpacity(0.5)
                : theme.dividerColor,
            width: widget.isSelected
                ? SidebarConstants.selectionBorderWidth
                : 1,
          ),
          color: theme.colorScheme.surface,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Image thumbnail
            _buildThumbnail(),

            // Delete button (visible on long press)
            if (_showDeleteButton) _buildDeleteButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return AspectRatio(
      aspectRatio: widget.image.aspectRatio,
      child: Image.file(
        File(widget.image.filePath),
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => _buildBrokenImagePlaceholder(),
      ),
    );
  }

  Widget _buildBrokenImagePlaceholder() {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.broken_image_outlined,
          size: 32,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Positioned(
      top: 4,
      right: 4,
      child: Material(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(
          SidebarConstants.deleteButtonSize / 2,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(
            SidebarConstants.deleteButtonSize / 2,
          ),
          onTap: _handleDelete,
          child: SizedBox(
            width: SidebarConstants.deleteButtonSize,
            height: SidebarConstants.deleteButtonSize,
            child: const Icon(
              Icons.close,
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _handleDelete() {
    ref.read(sidebarImagesProvider.notifier).removeImage(widget.image.id);
    setState(() => _showDeleteButton = false);
  }
}
