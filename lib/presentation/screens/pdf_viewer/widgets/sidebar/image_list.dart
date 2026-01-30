import 'package:flutter/material.dart';

import 'package:minipdfsign/domain/entities/sidebar_image.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/sidebar/draggable_image_card.dart';

/// Scrollable list of image thumbnails.
///
/// Supports:
/// - Drag image: drag to PDF viewer
class ImageList extends StatelessWidget {
  const ImageList({
    required this.images,
    super.key,
  });

  final List<SidebarImage> images;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemCount: images.length,
      itemBuilder: (context, index) {
        final image = images[index];
        return DraggableImageCard(
          key: ValueKey(image.id),
          image: image,
          index: index,
          isSelected: false, // No selection on mobile
        );
      },
    );
  }
}
