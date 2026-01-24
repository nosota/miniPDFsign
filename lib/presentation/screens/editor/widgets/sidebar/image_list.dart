import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/domain/entities/sidebar_image.dart';
import 'package:pdfsign/presentation/providers/sidebar/sidebar_images_provider.dart';
import 'package:pdfsign/presentation/providers/sidebar/sidebar_selection_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/draggable_image_card.dart';

/// Scrollable, reorderable list of image thumbnails.
///
/// Supports:
/// - Drag grip handle (⋮⋮): reorder within sidebar
/// - Drag image: drag to PDF viewer
class ImageList extends ConsumerWidget {
  const ImageList({
    required this.images,
    super.key,
  });

  final List<SidebarImage> images;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(sidebarSelectionProvider);

    return ReorderableListView.builder(
      buildDefaultDragHandles: false,
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemCount: images.length,
      onReorder: (oldIndex, newIndex) {
        ref.read(sidebarImagesProvider.notifier).reorder(oldIndex, newIndex);
      },
      proxyDecorator: _proxyDecorator,
      itemBuilder: (context, index) {
        final image = images[index];
        return DraggableImageCard(
          key: ValueKey(image.id),
          image: image,
          index: index,
          isSelected: image.id == selectedId,
        );
      },
    );
  }

  /// Decoration for the item being dragged (Figma-style: scale + opacity).
  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final scale = Tween<double>(begin: 1.0, end: 1.02).evaluate(animation);
        final opacity = Tween<double>(begin: 1.0, end: 0.9).evaluate(animation);
        return Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scale,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
