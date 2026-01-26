import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:minipdfsign/presentation/providers/editor/document_dirty_provider.dart';
import 'package:minipdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:minipdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:minipdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:minipdfsign/presentation/providers/pdf_viewer/permission_retry_provider.dart';
import 'package:minipdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_viewer.dart';

/// PDF Editor screen with PDF viewing capabilities.
///
/// Displays a single PDF document with ability to place images.
/// TODO: Add bottom sheet for image library (mobile).
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
      // Timeout reached, go back to home
      if (kDebugMode) {
        print('Permission retry timeout, navigating back');
      }
      _cancelRetryTimer();
      ref.read(permissionRetryProvider.notifier).state = false;
      _retryCount = 0;
      // Navigate back to home screen
      if (mounted) {
        context.go('/');
      }
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

  String get _fileName {
    final path = widget.filePath;
    if (path == null || path.isEmpty) return 'PDF Viewer';
    return path.split('/').last;
  }

  @override
  Widget build(BuildContext context) {
    final selectedId = ref.watch(editorSelectionProvider);
    final hasSelection = selectedId != null;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: Text(
          _fileName,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          if (hasSelection)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _deleteSelectedImage,
            ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: const PdfViewer(),
      // TODO: Add bottom sheet for image library
    );
  }
}
