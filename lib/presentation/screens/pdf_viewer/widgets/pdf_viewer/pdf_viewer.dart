import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:file_picker/file_picker.dart';

import 'package:minipdfsign/domain/entities/pdf_document_info.dart';
import 'package:minipdfsign/presentation/providers/editor/document_dirty_provider.dart';
import 'package:minipdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:minipdfsign/presentation/providers/editor/original_pdf_provider.dart';
import 'package:minipdfsign/presentation/providers/editor/pdf_save_service_provider.dart';
import 'package:minipdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:minipdfsign/presentation/providers/editor/pointer_on_object_provider.dart';
import 'package:minipdfsign/l10n/generated/app_localizations.dart';
import 'package:minipdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:minipdfsign/presentation/providers/pdf_viewer/pdf_viewer_state.dart';
import 'package:minipdfsign/presentation/providers/pdf_viewer/permission_retry_provider.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/pdf_viewer/conditional_scale_recognizer.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/pdf_viewer/page_indicator.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/pdf_viewer/pdf_drop_target.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/pdf_viewer/pdf_page_list.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/pdf_viewer/pdf_viewer_constants.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/pdf_viewer/placed_images_layer.dart';

/// Main PDF viewer widget with continuous scroll and zoom controls.
///
/// Displays PDF pages in a macOS Preview-style layout with:
/// - Continuous vertical scroll
/// - Pinch-to-zoom (trackpad) with Transform.scale for smooth performance
/// - Keyboard shortcuts (Cmd+/-/0, PageUp/Down, Arrows, Cmd+G)
/// - Center-focused zoom
/// - Auto-hiding page indicator
class PdfViewer extends ConsumerStatefulWidget {
  const PdfViewer({super.key});

  @override
  ConsumerState<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends ConsumerState<PdfViewer> {
  final GlobalKey<PdfPageListState> _pageListKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();

  // Scroll controller for PlacedImagesLayer synchronization
  final ScrollController _scrollController = ScrollController();

  bool _isScrolling = false;
  Timer? _scrollEndTimer;

  // For pinch-to-zoom with Transform.scale optimization
  double _baseScale = 1.0;           // Scale at the start of gesture
  double _gestureScaleFactor = 1.0;  // Visual scale factor during gesture (1.0 = no change)
  bool _isPinching = false;
  Offset? _focalPointLocal;          // Focal point for focal-point-centered zoom

  // For double-tap zoom toggle
  Offset? _doubleTapPosition;

  // Scroll amount for arrow keys
  static const double _arrowScrollAmount = 50.0;

  // Internal clipboard for copy/paste (stores image ID to duplicate)
  String? _clipboardImageId;

  /// The visual scale during pinch gesture (baseScale * gestureScaleFactor)
  double get _visualScale => _baseScale * _gestureScaleFactor;

  /// Calculates the maximum page width for horizontal centering.
  double _calculateContentWidth(PdfDocumentInfo document, double scale) {
    double maxWidth = 0;
    for (final page in document.pages) {
      final scaledWidth = page.width * scale;
      if (scaledWidth > maxWidth) {
        maxWidth = scaledWidth;
      }
    }
    return maxWidth;
  }

  @override
  void initState() {
    super.initState();
    // Request focus to receive keyboard events
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _scrollEndTimer?.cancel();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (!_isScrolling) {
      setState(() {
        _isScrolling = true;
      });
    }

    _scrollEndTimer?.cancel();
    _scrollEndTimer = Timer(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() {
          _isScrolling = false;
        });
      }
    });
  }

  // Handle Ctrl+Scroll for zoom (mouse wheel with Ctrl)
  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      final isCtrlPressed = HardwareKeyboard.instance.isControlPressed ||
          HardwareKeyboard.instance.isMetaPressed;

      if (isCtrlPressed) {
        // Zoom with Ctrl/Cmd + scroll
        final delta = event.scrollDelta.dy;
        final notifier = ref.read(pdfDocumentProvider.notifier);

        if (delta < 0) {
          notifier.zoomInStep();
        } else {
          notifier.zoomOutStep();
        }
      }
    }
  }

  /// Checks if PDF should handle the scale gesture.
  ///
  /// Returns false if all pointers are on the same placed object,
  /// allowing the object's gesture recognizer to win the arena.
  bool _shouldAcceptScaleGesture() {
    final pointerNotifier = ref.read(pointerOnObjectProvider.notifier);
    // If all active pointers are on the same object, reject PDF gesture
    // The pointerCount check uses the tracked pointers in the provider
    final objectId = pointerNotifier.allPointersOnSameObject(
      pointerNotifier.pointerCount,
    );
    return objectId == null; // Accept only if NOT all on same object
  }

  // Handle pinch-to-zoom gesture - optimized with Transform.scale
  void _handleScaleStart(ScaleStartDetails details) {
    if (details.pointerCount >= 2) {
      _isPinching = true;
      final state = ref.read(pdfDocumentProvider);
      state.maybeMap(
        loaded: (loaded) {
          _baseScale = loaded.scale;
          _gestureScaleFactor = 1.0;
          _focalPointLocal = details.localFocalPoint;
        },
        orElse: () {},
      );
    }
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    if (_isPinching && details.pointerCount >= 2) {
      // Only update visual scale factor - no re-rendering!
      setState(() {
        _gestureScaleFactor = details.scale;
        _focalPointLocal = details.localFocalPoint;
      });
    }
  }

  void _handleScaleEnd(ScaleEndDetails details) {
    if (_isPinching) {
      _isPinching = false;

      // Capture values before reset
      final finalScale = _baseScale * _gestureScaleFactor;
      final oldScale = _baseScale;
      final focalPoint = _focalPointLocal;

      // Reset gesture state
      setState(() {
        _gestureScaleFactor = 1.0;
      });

      // Apply the new scale (this triggers re-rendering at new resolution)
      // setScale returns false if scale didn't change (at limit)
      final scaleChanged = ref.read(pdfDocumentProvider.notifier).setScale(finalScale);

      // Adjust scroll only if scale actually changed
      if (scaleChanged && focalPoint != null) {
        _pageListKey.currentState?.adjustScrollForFocalZoom(
          oldScale: oldScale,
          newScale: finalScale,
          focalPoint: focalPoint,
        );
      }

      // Clear focal point
      _focalPointLocal = null;
    }
  }

  // Handle double-tap to toggle between Fit Width and 100%
  void _handleDoubleTap() {
    final state = ref.read(pdfDocumentProvider);
    state.maybeMap(
      loaded: (loaded) {
        final tapPosition = _doubleTapPosition;

        if (loaded.isFitWidth || loaded.scale < 1.0) {
          // Zoom to 100% centered on tap position
          final oldScale = loaded.scale;
          ref.read(pdfDocumentProvider.notifier).setScale(1.0);

          // Adjust scroll to keep tap position centered
          if (tapPosition != null) {
            _pageListKey.currentState?.adjustScrollForFocalZoom(
              oldScale: oldScale,
              newScale: 1.0,
              focalPoint: tapPosition,
            );
          }
        } else {
          // Return to Fit Width
          ref.read(pdfDocumentProvider.notifier).fitToWidth();
        }
      },
      orElse: () {},
    );
  }

  // Handle keyboard shortcuts
  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }

    final isCmd = HardwareKeyboard.instance.isMetaPressed;
    final logicalKey = event.logicalKey;

    // Note: Delete/Backspace is handled at EditorScreen level via Shortcuts/Actions
    // to work independently of focus state.

    // Cmd+C: Copy selected image
    if (isCmd && logicalKey == LogicalKeyboardKey.keyC) {
      _copySelectedImage();
      return KeyEventResult.handled;
    }

    // Cmd+V: Paste copied image
    if (isCmd && logicalKey == LogicalKeyboardKey.keyV) {
      _pasteImage();
      return KeyEventResult.handled;
    }

    // Cmd+S: Save document
    if (isCmd && logicalKey == LogicalKeyboardKey.keyS) {
      final isShift = HardwareKeyboard.instance.isShiftPressed;
      if (isShift) {
        _saveAs();
      } else {
        _save();
      }
      return KeyEventResult.handled;
    }

    // Cmd+R: Reload document
    if (isCmd && logicalKey == LogicalKeyboardKey.keyR) {
      _reloadDocument();
      return KeyEventResult.handled;
    }

    // Note: Go to page dialog removed for mobile

    // Cmd+0: Fit to width
    if (isCmd && (logicalKey == LogicalKeyboardKey.digit0 ||
                  logicalKey == LogicalKeyboardKey.numpad0)) {
      ref.read(pdfDocumentProvider.notifier).fitToWidth();
      return KeyEventResult.handled;
    }

    // Cmd+Plus or Cmd+=: Zoom in
    if (isCmd && (logicalKey == LogicalKeyboardKey.equal ||
                  logicalKey == LogicalKeyboardKey.add ||
                  logicalKey == LogicalKeyboardKey.numpadAdd)) {
      ref.read(pdfDocumentProvider.notifier).zoomInStep();
      return KeyEventResult.handled;
    }

    // Cmd+Minus: Zoom out
    if (isCmd && (logicalKey == LogicalKeyboardKey.minus ||
                  logicalKey == LogicalKeyboardKey.numpadSubtract)) {
      ref.read(pdfDocumentProvider.notifier).zoomOutStep();
      return KeyEventResult.handled;
    }

    // Page Up: Previous page
    if (logicalKey == LogicalKeyboardKey.pageUp) {
      _goToPreviousPage();
      return KeyEventResult.handled;
    }

    // Page Down: Next page
    if (logicalKey == LogicalKeyboardKey.pageDown) {
      _goToNextPage();
      return KeyEventResult.handled;
    }

    // Arrow keys: Smooth scroll
    if (logicalKey == LogicalKeyboardKey.arrowUp) {
      _scrollBy(0, -_arrowScrollAmount);
      return KeyEventResult.handled;
    }
    if (logicalKey == LogicalKeyboardKey.arrowDown) {
      _scrollBy(0, _arrowScrollAmount);
      return KeyEventResult.handled;
    }
    if (logicalKey == LogicalKeyboardKey.arrowLeft) {
      _scrollBy(-_arrowScrollAmount, 0);
      return KeyEventResult.handled;
    }
    if (logicalKey == LogicalKeyboardKey.arrowRight) {
      _scrollBy(_arrowScrollAmount, 0);
      return KeyEventResult.handled;
    }

    // Home: Go to first page
    if (logicalKey == LogicalKeyboardKey.home) {
      _goToPage(1);
      return KeyEventResult.handled;
    }

    // End: Go to last page
    if (logicalKey == LogicalKeyboardKey.end) {
      final state = ref.read(pdfDocumentProvider);
      state.maybeMap(
        loaded: (loaded) {
          _goToPage(loaded.document.pageCount);
        },
        orElse: () {},
      );
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  void _copySelectedImage() {
    final selectedId = ref.read(editorSelectionProvider);
    if (selectedId != null) {
      setState(() {
        _clipboardImageId = selectedId;
      });
    }
  }

  void _pasteImage() {
    if (_clipboardImageId != null) {
      final duplicate = ref.read(placedImagesProvider.notifier).duplicateImage(
            _clipboardImageId!,
            offset: const Offset(20, 20),
          );
      if (duplicate != null) {
        ref.read(editorSelectionProvider.notifier).select(duplicate.id);
        ref.read(documentDirtyProvider.notifier).markDirty();
      }
    }
  }

  Future<void> _save() async {
    final state = ref.read(pdfDocumentProvider);
    final filePath = state.maybeMap(
      loaded: (s) => s.document.filePath,
      orElse: () => null,
    );

    if (filePath == null) return;

    final placedImages = ref.read(placedImagesProvider);
    final isDirty = ref.read(documentDirtyProvider);

    // Nothing to save if no changes were made
    if (placedImages.isEmpty && !isDirty) return;

    // Get original bytes from storage
    final storage = ref.read(originalPdfStorageProvider);
    if (!storage.hasData) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.noOriginalPdfStored)),
        );
      }
      return;
    }

    final originalBytes = await storage.getBytes();

    final saveService = ref.read(pdfSaveServiceProvider);
    final result = await saveService.savePdfFromBytes(
      originalBytes: originalBytes,
      placedImages: placedImages,
      outputPath: filePath,
    );

    result.fold(
      (failure) {
        // Show error snackbar
        if (mounted) {
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.errorWithMessage(failure.message))),
          );
        }
      },
      (_) {
        // Mark as clean but DO NOT clear objects or reload document
        // Objects remain editable for further modifications
        ref.read(documentDirtyProvider.notifier).markClean();
      },
    );
  }

  Future<void> _saveAs() async {
    final state = ref.read(pdfDocumentProvider);
    final filePath = state.maybeMap(
      loaded: (s) => s.document.filePath,
      orElse: () => null,
    );

    if (filePath == null) return;

    // Show save dialog
    final l10n = AppLocalizations.of(context)!;
    final outputPath = await FilePicker.platform.saveFile(
      dialogTitle: l10n.savePdfAs,
      fileName: 'document.pdf',
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (outputPath == null) return; // User cancelled

    final placedImages = ref.read(placedImagesProvider);
    final storage = ref.read(originalPdfStorageProvider);

    // Get original bytes from storage or fallback to disk
    final originalBytes = storage.hasData
        ? await storage.getBytes()
        : await File(filePath).readAsBytes();

    final saveService = ref.read(pdfSaveServiceProvider);
    final result = await saveService.savePdfFromBytes(
      originalBytes: originalBytes,
      placedImages: placedImages,
      outputPath: outputPath,
    );

    result.fold(
      (failure) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.errorWithMessage(failure.message))),
          );
        }
      },
      (savedPath) {
        // Mark as clean but DO NOT clear objects
        ref.read(documentDirtyProvider.notifier).markClean();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.savedTo(savedPath))),
          );
        }
      },
    );
  }

  void _scrollBy(double deltaX, double deltaY) {
    _pageListKey.currentState?.scrollBy(deltaX, deltaY);
  }

  void _goToPage(int pageNumber) {
    ref.read(pdfDocumentProvider.notifier).setCurrentPage(pageNumber);
    _pageListKey.currentState?.scrollToPage(pageNumber);
  }

  void _goToPreviousPage() {
    final state = ref.read(pdfDocumentProvider);
    state.maybeMap(
      loaded: (loaded) {
        if (loaded.currentPage > 1) {
          _goToPage(loaded.currentPage - 1);
        }
      },
      orElse: () {},
    );
  }

  void _goToNextPage() {
    final state = ref.read(pdfDocumentProvider);
    state.maybeMap(
      loaded: (loaded) {
        if (loaded.currentPage < loaded.document.pageCount) {
          _goToPage(loaded.currentPage + 1);
        }
      },
      orElse: () {},
    );
  }

  // TODO: Implement mobile-friendly go to page (if needed)

  Future<void> _reloadDocument() async {
    final pageToRestore = await ref.read(pdfDocumentProvider.notifier).reloadDocument();

    if (pageToRestore != null && mounted) {
      // Wait for the widget to rebuild with new document
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _pageListKey.currentState?.scrollToPage(pageToRestore, animate: false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewerState = ref.watch(pdfDocumentProvider);

    // Request focus when an object is selected on PDF
    // This ensures keyboard shortcuts (Delete/Backspace) work after
    // focus was elsewhere (e.g., editing comment in sidebar)
    ref.listen(editorSelectionProvider, (prev, next) {
      if (next != null && prev != next) {
        _focusNode.requestFocus();
      }
    });

    return Focus(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: viewerState.map(
        initial: (_) => _buildEmptyState(),
        loading: (state) => _buildLoadingState(state.filePath),
        loaded: (state) => _buildLoadedState(state),
        error: (state) => _buildErrorState(state.message),
        passwordRequired: (state) => _buildPasswordRequired(state.filePath),
      ),
    );
  }

  Widget _buildEmptyState() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      color: PdfViewerConstants.backgroundColor,
      child: Center(
        child: Text(
          l10n.noDocumentLoaded,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(String filePath) {
    return Container(
      color: PdfViewerConstants.backgroundColor,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildLoadedState(PdfViewerLoaded state) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Update viewport dimensions
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(pdfDocumentProvider.notifier).updateViewport(
                constraints.maxWidth,
                constraints.maxHeight,
              );
        });

        return Listener(
          onPointerSignal: _handlePointerSignal,
          // Use RawGestureDetector with ConditionalScaleGestureRecognizer
          // to properly reject gestures when objects should handle them
          child: RawGestureDetector(
            gestures: <Type, GestureRecognizerFactory>{
              ConditionalScaleGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<
                      ConditionalScaleGestureRecognizer>(
                () => ConditionalScaleGestureRecognizer(
                  shouldAcceptGesture: _shouldAcceptScaleGesture,
                ),
                (ConditionalScaleGestureRecognizer instance) {
                  instance
                    ..onStart = _handleScaleStart
                    ..onUpdate = _handleScaleUpdate
                    ..onEnd = _handleScaleEnd;
                },
              ),
              DoubleTapGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<
                      DoubleTapGestureRecognizer>(
                DoubleTapGestureRecognizer.new,
                (DoubleTapGestureRecognizer instance) {
                  instance.onDoubleTapDown = (details) {
                    _doubleTapPosition = details.localPosition;
                  };
                  instance.onDoubleTap = _handleDoubleTap;
                },
              ),
            },
            child: PdfDropTarget(
              document: state.document,
              scale: state.scale,
              getScrollOffset: () =>
                  _pageListKey.currentState?.scrollOffsetXY ?? Offset.zero,
              child: Container(
                color: PdfViewerConstants.backgroundColor,
                child: Stack(
                  children: [
                    // PDF pages with Transform.scale for smooth pinch-to-zoom
                    ClipRect(
                      child: _isPinching
                          ? Transform.scale(
                              scale: _gestureScaleFactor,
                              child: PdfPageList(
                                key: _pageListKey,
                                document: state.document,
                                scale: state.scale, // Use render scale, not visual
                                scrollController: _scrollController,
                                onPageChanged: (page) {
                                  ref.read(pdfDocumentProvider.notifier).setCurrentPage(page);
                                },
                                onScroll: _handleScroll,
                              ),
                            )
                          : PdfPageList(
                              key: _pageListKey,
                              document: state.document,
                              scale: state.scale,
                              scrollController: _scrollController,
                              onPageChanged: (page) {
                                ref.read(pdfDocumentProvider.notifier).setCurrentPage(page);
                              },
                              onScroll: _handleScroll,
                            ),
                    ),

                    // Placed images layer - OUTSIDE ScrollView for gesture isolation
                    // Apply same Transform.scale as PDF pages during pinch (no ClipRect for handles)
                    if (_isPinching)
                      Transform.scale(
                        scale: _gestureScaleFactor,
                        child: PlacedImagesLayer(
                          document: state.document,
                          scale: state.scale,
                          scrollController: _scrollController,
                          horizontalScrollController:
                              _pageListKey.currentState?.horizontalScrollController,
                          viewportSize: Size(
                            constraints.maxWidth,
                            constraints.maxHeight,
                          ),
                          contentWidth: _calculateContentWidth(state.document, state.scale),
                        ),
                      )
                    else
                      PlacedImagesLayer(
                        document: state.document,
                        scale: state.scale,
                        scrollController: _scrollController,
                        horizontalScrollController:
                            _pageListKey.currentState?.horizontalScrollController,
                        viewportSize: Size(
                          constraints.maxWidth,
                          constraints.maxHeight,
                        ),
                        contentWidth: _calculateContentWidth(state.document, state.scale),
                      ),

                    // Page indicator (bottom center)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 16,
                      child: Center(
                        child: PageIndicator(
                          currentPage: state.currentPage,
                          totalPages: state.document.pageCount,
                          isScrolling: _isScrolling || _isPinching,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(String message) {
    // If we're retrying due to permission issues, show loading instead of error
    final isRetrying = ref.watch(permissionRetryProvider);
    if (isRetrying) {
      return _buildPermissionWaitingState();
    }

    final l10n = AppLocalizations.of(context)!;
    return Container(
      color: PdfViewerConstants.backgroundColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.failedToLoadPdf,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionWaitingState() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      color: PdfViewerConstants.backgroundColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              l10n.waitingForFolderPermission,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordRequired(String filePath) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      color: PdfViewerConstants.backgroundColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.lock_outline,
              size: 48,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.passwordRequired,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.pdfPasswordProtected,
              style: const TextStyle(color: Colors.grey),
            ),
            // TODO: Add password input dialog
          ],
        ),
      ),
    );
  }
}
