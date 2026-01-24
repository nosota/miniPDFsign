import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/domain/entities/sidebar_image.dart';
import 'package:pdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:pdfsign/presentation/providers/sidebar/sidebar_images_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/image_comment_field.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/image_thumbnail_card.dart';

/// Data object passed during drag operation.
class DraggableSidebarImage {
  final String sourceImageId;
  final String imagePath;
  final int width;
  final int height;

  const DraggableSidebarImage({
    required this.sourceImageId,
    required this.imagePath,
    required this.width,
    required this.height,
  });

  double get aspectRatio => width / height;

  factory DraggableSidebarImage.fromSidebarImage(SidebarImage image) {
    return DraggableSidebarImage(
      sourceImageId: image.id,
      imagePath: image.filePath,
      width: image.width,
      height: image.height,
    );
  }
}

/// Image card with grip handle for reordering and draggable image for PDF.
///
/// Structure:
/// ```
/// ┌────┬──────────────────────┐
/// │ ⋮⋮ │   🖼 image.png       │
/// │    │                      │
/// │grip│  ← drag = to PDF     │
/// │    │   Comment text...    │
/// └────┴──────────────────────┘
/// ```
///
/// - Drag grip handle (⋮⋮): reorder within sidebar
/// - Drag image area: drag to PDF viewer
/// - Comment field: inline editable text below image
class DraggableImageCard extends ConsumerWidget {
  const DraggableImageCard({
    required this.image,
    required this.index,
    required this.isSelected,
    super.key,
  });

  final SidebarImage image;
  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dragData = DraggableSidebarImage.fromSidebarImage(image);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Grip handle for reordering
          ReorderableDragStartListener(
            index: index,
            child: const _GripHandle(),
          ),

          // Image + comment area
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image area for dragging to PDF
                Draggable<DraggableSidebarImage>(
                  data: dragData,
                  feedback: _buildDragFeedback(context),
                  childWhenDragging: Opacity(
                    opacity: 0.3,
                    child: ImageThumbnailCard(
                      image: image,
                      isSelected: false,
                    ),
                  ),
                  child: ImageThumbnailCard(
                    image: image,
                    isSelected: isSelected,
                  ),
                ),

                // Comment field
                Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 4),
                  child: ImageCommentField(
                    comment: image.comment,
                    onCommentChanged: (comment) {
                      ref
                          .read(sidebarImagesProvider.notifier)
                          .updateComment(image.id, comment);
                    },
                    onEditingStarted: () {
                      // Clear PDF object selection when editing sidebar comment
                      ref.read(editorSelectionProvider.notifier).clear();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragFeedback(BuildContext context) {
    const maxSize = 150.0;
    final aspectRatio = image.aspectRatio;

    double width, height;
    if (aspectRatio > 1) {
      width = maxSize;
      height = maxSize / aspectRatio;
    } else {
      height = maxSize;
      width = maxSize * aspectRatio;
    }

    return Material(
      color: Colors.transparent,
      child: Image.file(
        File(image.filePath),
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}

/// Grip handle for reordering items in the list.
class _GripHandle extends StatefulWidget {
  const _GripHandle();

  @override
  State<_GripHandle> createState() => _GripHandleState();
}

class _GripHandleState extends State<_GripHandle> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = theme.colorScheme.onSurfaceVariant;

    return MouseRegion(
      cursor: SystemMouseCursors.grab,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        width: 28,
        margin: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
        decoration: BoxDecoration(
          color: _isHovered ? theme.colorScheme.surfaceContainerHighest : null,
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(6),
          ),
        ),
        child: Center(
          child: Icon(
            Icons.drag_indicator,
            size: 20,
            color: _isHovered ? baseColor : baseColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
