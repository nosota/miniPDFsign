import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/core/platform/sub_window_channel.dart';
import 'package:pdfsign/presentation/providers/editor/document_dirty_provider.dart';
import 'package:pdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/permission_retry_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_viewer.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/image_sidebar.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/sidebar_resize_handle.dart';

/// Intent for deleting the currently selected image.
class DeleteSelectedImageIntent extends Intent {
  const DeleteSelectedImageIntent();
}

/// Action for deleting selected image that respects text input focus.
///
/// When a text input (EditableText) has focus, this action is disabled
/// to allow normal text editing (Delete/Backspace work in TextField).
class DeleteSelectedImageAction extends Action<DeleteSelectedImageIntent> {
  DeleteSelectedImageAction(this.onDelete);

  final VoidCallback onDelete;

  @override
  bool isEnabled(DeleteSelectedImageIntent intent) {
    // Check if focus is on a text input widget
    final primaryFocus = FocusManager.instance.primaryFocus;
    if (primaryFocus == null) return true;

    final context = primaryFocus.context;
    if (context == null) return true;

    // Walk up the widget tree to find EditableText
    bool isTextInput = false;
    context.visitAncestorElements((element) {
      if (element.widget is EditableText) {
        isTextInput = true;
        return false; // Stop visiting
      }
      return true; // Continue visiting
    });

    // Disable action if text input has focus (let TextField handle the key)
    return !isTextInput;
  }

  @override
  Object? invoke(DeleteSelectedImageIntent intent) {
    onDelete();
    return null;
  }
}

/// PDF Editor screen with PDF viewing capabilities.
///
/// Displays a single PDF document in its own window.
/// Window close handling is done in PdfViewerApp.
class EditorScreen extends ConsumerStatefulWidget {
  const EditorScreen({
    required this.filePath,
    super.key,
  });

  final String? filePath;

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  /// Timer for permission retry loop.
  Timer? _permissionRetryTimer;

  /// Current retry attempt count.
  int _retryCount = 0;

  /// Maximum retry attempts (20 * 1.5s = 30 seconds).
  static const int _maxRetries = 20;

  /// Interval between retry attempts.
  static const Duration _retryInterval = Duration(milliseconds: 1500);

  /// Error message indicating file access permission issue.
  static const String _accessDeniedMessage = 'File access denied';

  @override
  void initState() {
    super.initState();
    _loadDocument();
  }

  @override
  void dispose() {
    _cancelRetryTimer();
    super.dispose();
  }

  void _loadDocument() {
    final path = widget.filePath;
    if (path != null && path.isNotEmpty) {
      // Schedule the document load after the first frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(pdfDocumentProvider.notifier).openDocument(path);
        // Set up listener for permission retry handling
        _setupPermissionRetryListener();
      });
    }
  }

  /// Sets up a listener to handle permission-related errors with retry logic.
  void _setupPermissionRetryListener() {
    ref.listenManual<PdfViewerState>(
      pdfDocumentProvider,
      (previous, next) {
        next.maybeMap(
          error: (errorState) {
            if (errorState.message == _accessDeniedMessage &&
                errorState.filePath != null) {
              _handlePermissionError(errorState.filePath!);
            } else {
              // Not a permission error, stop any retry in progress
              _cancelRetryTimer();
              ref.read(permissionRetryProvider.notifier).state = false;
            }
          },
          loaded: (_) {
            // Successfully loaded, stop retry
            _cancelRetryTimer();
            ref.read(permissionRetryProvider.notifier).state = false;
            _retryCount = 0;
          },
          orElse: () {},
        );
      },
    );
  }

  /// Handles permission error by starting retry loop.
  void _handlePermissionError(String filePath) {
    if (_retryCount >= _maxRetries) {
      // Timeout reached, close the window
      if (kDebugMode) {
        print('Permission retry timeout, closing window');
      }
      _cancelRetryTimer();
      ref.read(permissionRetryProvider.notifier).state = false;
      _retryCount = 0;
      // Close the window
      SubWindowChannel.close();
      return;
    }

    // Start or continue retry
    _retryCount++;
    ref.read(permissionRetryProvider.notifier).state = true;

    if (kDebugMode) {
      print('Permission retry attempt $_retryCount/$_maxRetries');
    }

    _permissionRetryTimer?.cancel();
    _permissionRetryTimer = Timer(_retryInterval, () {
      if (mounted) {
        ref.read(pdfDocumentProvider.notifier).openDocument(filePath);
      }
    });
  }

  void _cancelRetryTimer() {
    _permissionRetryTimer?.cancel();
    _permissionRetryTimer = null;
  }

  @override
  void didUpdateWidget(EditorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final path = widget.filePath;
    if (path != oldWidget.filePath && path != null && path.isNotEmpty) {
      _cancelRetryTimer();
      _retryCount = 0;
      ref.read(permissionRetryProvider.notifier).state = false;
      ref.read(pdfDocumentProvider.notifier).openDocument(path);
    }
  }

  /// Deletes the currently selected image if any.
  void _deleteSelectedImage() {
    final selectedId = ref.read(editorSelectionProvider);
    if (selectedId != null) {
      ref.read(placedImagesProvider.notifier).removeImage(selectedId);
      ref.read(editorSelectionProvider.notifier).clear();
      ref.read(documentDirtyProvider.notifier).markDirty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.delete): DeleteSelectedImageIntent(),
        SingleActivator(LogicalKeyboardKey.backspace): DeleteSelectedImageIntent(),
      },
      child: Actions(
        actions: {
          DeleteSelectedImageIntent: DeleteSelectedImageAction(
            _deleteSelectedImage,
          ),
        },
        child: Scaffold(
          // Force LTR layout direction to keep panels in place for RTL languages.
          // Text inside widgets will still be RTL as it inherits from MaterialApp.
          body: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              children: const [
                // PDF viewer (expands to fill remaining space)
                Expanded(
                  child: PdfViewer(),
                ),

                // Resize handle
                SidebarResizeHandle(),

                // Right sidebar with images
                ImageSidebar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
