import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/core/constants/sidebar_constants.dart';
import 'package:pdfsign/domain/entities/sidebar_image.dart';
import 'package:pdfsign/presentation/providers/sidebar/sidebar_images_provider.dart';
import 'package:pdfsign/presentation/providers/sidebar/sidebar_selection_provider.dart';

/// A single image thumbnail card in the sidebar.
///
/// Shows the image with proportional scaling, selection highlight,
/// and a delete button on hover.
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
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Focus(
      onKeyEvent: _handleKeyEvent,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: _handleTap,
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

                // Delete button (visible on hover)
                if (_isHovered || widget.isSelected) _buildDeleteButton(),
              ],
            ),
          ),
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

  void _handleTap() {
    ref.read(sidebarSelectionProvider.notifier).select(widget.image.id);
  }

  void _handleDelete() {
    ref.read(sidebarImagesProvider.notifier).removeImage(widget.image.id);
    ref.read(sidebarSelectionProvider.notifier).clear();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if ((event.logicalKey == LogicalKeyboardKey.delete ||
              event.logicalKey == LogicalKeyboardKey.backspace) &&
          widget.isSelected) {
        _handleDelete();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }
}
