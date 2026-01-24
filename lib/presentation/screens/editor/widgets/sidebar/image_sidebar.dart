import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:super_clipboard/super_clipboard.dart';
import 'package:uuid/uuid.dart';

import 'package:pdfsign/presentation/providers/sidebar/sidebar_images_provider.dart';
import 'package:pdfsign/presentation/providers/sidebar/sidebar_selection_provider.dart';
import 'package:pdfsign/presentation/providers/sidebar/sidebar_width_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/add_image_button.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/image_list.dart';

/// Main sidebar panel widget for displaying and managing images.
///
/// Features:
/// - Resizable width
/// - Drag-drop from Finder
/// - Scrollable image list with reordering
/// - Add button at bottom
class ImageSidebar extends ConsumerStatefulWidget {
  const ImageSidebar({super.key});

  @override
  ConsumerState<ImageSidebar> createState() => _ImageSidebarState();
}

class _ImageSidebarState extends ConsumerState<ImageSidebar> {
  bool _isDragging = false;
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = ref.watch(sidebarWidthProvider);
    final imagesAsync = ref.watch(sidebarImagesProvider);

    return Focus(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      child: GestureDetector(
        // Focus sidebar when clicking, clear selection
        onTap: () {
          _focusNode.requestFocus();
          ref.read(sidebarSelectionProvider.notifier).clear();
        },
        child: Container(
        width: width,
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            // Image list with drop target
            Expanded(
              child: DropTarget(
                onDragEntered: (_) => setState(() => _isDragging = true),
                onDragExited: (_) => setState(() => _isDragging = false),
                onDragDone: _handleFileDrop,
                child: Container(
                  decoration: BoxDecoration(
                    border: _isDragging
                        ? Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          )
                        : null,
                  ),
                  child: imagesAsync.when(
                    data: (images) {
                      if (images.isEmpty) {
                        return _buildEmptyState(context);
                      }
                      return ImageList(images: images);
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, _) => Center(
                      child: Text('Error: $error'),
                    ),
                  ),
                ),
              ),
            ),

            // Add button
            const AddImageButton(),
          ],
        ),
      ),
      ),
    );
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.keyV &&
        (HardwareKeyboard.instance.isMetaPressed ||
            HardwareKeyboard.instance.isControlPressed)) {
      _handlePaste();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  Future<void> _handlePaste() async {
    final clipboard = SystemClipboard.instance;
    if (clipboard == null) return;

    final reader = await clipboard.read();

    // Try PNG format first, then JPEG
    for (final format in [Formats.png, Formats.jpeg]) {
      if (reader.canProvide(format)) {
        reader.getFile(format, (file) async {
          final data = await file.readAll();

          // Save to temp file
          final tempDir = await getTemporaryDirectory();
          final ext = format == Formats.png ? 'png' : 'jpg';
          final tempFile = File('${tempDir.path}/${const Uuid().v4()}.$ext');
          await tempFile.writeAsBytes(data);

          // Add to sidebar using existing flow
          ref.read(sidebarImagesProvider.notifier).addImages([tempFile.path]);
        });
        return;
      }
    }
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              'Drop images here',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'or paste / click Add',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _handleFileDrop(DropDoneDetails details) {
    setState(() => _isDragging = false);

    final paths = details.files
        .where((f) => _isImageFile(f.path))
        .map((f) => f.path)
        .toList();

    if (paths.isNotEmpty) {
      ref.read(sidebarImagesProvider.notifier).addImages(paths);
    }
  }

  bool _isImageFile(String path) {
    final lower = path.toLowerCase();
    return lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.webp') ||
        lower.endsWith('.bmp') ||
        lower.endsWith('.tiff') ||
        lower.endsWith('.tif');
  }
}
