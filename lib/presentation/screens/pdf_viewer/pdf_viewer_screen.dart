import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;

import 'package:minipdfsign/domain/entities/recent_file.dart';
import 'package:minipdfsign/presentation/providers/services/image_to_pdf_service_provider.dart';
import 'package:minipdfsign/l10n/generated/app_localizations.dart';
import 'package:minipdfsign/presentation/providers/editor/document_dirty_provider.dart';
import 'package:minipdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:minipdfsign/presentation/providers/editor/file_source_provider.dart';
import 'package:minipdfsign/presentation/providers/editor/pdf_save_service_provider.dart';
import 'package:minipdfsign/presentation/providers/editor/pdf_share_service_provider.dart';
import 'package:minipdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:minipdfsign/presentation/providers/onboarding/onboarding_provider.dart';
import 'package:minipdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:minipdfsign/presentation/providers/pdf_viewer/permission_retry_provider.dart';
import 'package:minipdfsign/presentation/providers/recent_files_provider.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/image_library_sheet.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/pdf_viewer/pdf_viewer.dart';
import 'package:minipdfsign/presentation/widgets/coach_mark/coach_mark_controller.dart';

/// Actions for unsaved changes dialog.
enum _UnsavedAction { save, discard, cancel }

/// PDF Viewer screen with PDF viewing capabilities.
///
/// Displays a single PDF document with ability to place images.
class PdfViewerScreen extends ConsumerStatefulWidget {
  const PdfViewerScreen({
    required this.filePath,
    required this.fileSource,
    this.originalImageName,
    super.key,
  });

  final String? filePath;

  /// Source of the file (determines save behavior).
  final FileSourceType fileSource;

  /// Original image file name (for converted images, used as suggested save name).
  final String? originalImageName;

  @override
  ConsumerState<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends ConsumerState<PdfViewerScreen> {
  /// Timer for permission retry loop.
  Timer? _permissionRetryTimer;

  /// Current retry attempt count.
  int _retryCount = 0;

  /// Whether a share operation is in progress.
  bool _isSharing = false;

  /// Key for share button to get its position for iOS share popover.
  final _shareButtonKey = GlobalKey();

  /// Key for delete button to show onboarding coach mark.
  final _deleteButtonKey = GlobalKey();

  /// Key for PdfViewer to access scrollToFirstPage() for status bar tap.
  final _pdfViewerKey = GlobalKey<PdfViewerWidgetState>();

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
        // Set file source from widget parameter (prevents race condition)
        ref.read(fileSourceProvider.notifier).state = widget.fileSource;

        // Clear previous state before loading new document
        ref.read(documentDirtyProvider.notifier).markClean();
        ref.read(placedImagesProvider.notifier).clear();
        ref.read(editorSelectionProvider.notifier).clear();

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
        Navigator.pop(context);
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
  void didUpdateWidget(PdfViewerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final path = widget.filePath;
    if (path != oldWidget.filePath && path != null && path.isNotEmpty) {
      _cancelRetryTimer();
      _retryCount = 0;
      ref.read(permissionRetryProvider.notifier).state = false;

      // Clear previous state before loading new document
      ref.read(documentDirtyProvider.notifier).markClean();
      ref.read(placedImagesProvider.notifier).clear();
      ref.read(editorSelectionProvider.notifier).clear();

      ref.read(pdfDocumentProvider.notifier).openDocument(path);
    }
  }

  /// Deletes the currently selected image if any.
  void _deleteSelectedImage() {
    final selectedId = ref.read(editorSelectionProvider);
    if (selectedId != null) {
      HapticFeedback.mediumImpact();
      ref.read(placedImagesProvider.notifier).removeImage(selectedId);
      ref.read(editorSelectionProvider.notifier).clear();
      ref.read(documentDirtyProvider.notifier).markDirty();
    }
  }

  /// Shares the PDF document.
  ///
  /// If no images are placed, shares the original PDF.
  /// If images are placed, creates a temp PDF with embedded images and shares it.
  Future<void> _sharePdf() async {
    if (_isSharing) return;

    // Get the current PDF path and filename
    final pdfState = ref.read(pdfDocumentProvider);
    final (filePath, fileName) = pdfState.maybeMap(
      loaded: (state) => (state.document.filePath, state.document.fileName),
      orElse: () => (null, null),
    );

    if (filePath == null) return;

    HapticFeedback.lightImpact();
    setState(() => _isSharing = true);

    try {
      final placedImages = ref.read(placedImagesProvider);
      final shareService = ref.read(pdfShareServiceProvider);

      // Get share button position for iOS popover anchor
      final shareButtonBox =
          _shareButtonKey.currentContext?.findRenderObject() as RenderBox?;
      final sharePositionOrigin = shareButtonBox != null
          ? shareButtonBox.localToGlobal(Offset.zero) & shareButtonBox.size
          : null;

      final result = await shareService.sharePdf(
        originalPath: filePath,
        placedImages: placedImages,
        fileName: fileName,
        sharePositionOrigin: sharePositionOrigin,
      );

      result.fold(
        (failure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(failure.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        (_) {
          // Share completed successfully
        },
      );
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }

  String _getDisplayName(BuildContext context) {
    // For converted images, show "Untitled.pdf" until saved
    if (widget.fileSource == FileSourceType.convertedImage) {
      return AppLocalizations.of(context)?.untitledDocument ?? 'Untitled.pdf';
    }

    final path = widget.filePath;
    if (path == null || path.isEmpty) return 'PDF Viewer';
    return p.basename(path);
  }

  /// Handles back button press - shows dialog if document has unsaved changes.
  Future<void> _handleBackPress() async {
    final isDirty = ref.read(documentDirtyProvider);
    if (!isDirty) {
      Navigator.pop(context);
      return;
    }
    await _showUnsavedChangesDialog();
  }

  /// Shows the unsaved changes confirmation dialog.
  Future<void> _showUnsavedChangesDialog() async {
    final l10n = AppLocalizations.of(context)!;
    final result = await showDialog<_UnsavedAction>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(l10n.unsavedChangesTitle),
        content: Text(l10n.unsavedChangesMessage(_getDisplayName(context))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, _UnsavedAction.cancel),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, _UnsavedAction.discard),
            child: Text(l10n.discardButton, style: const TextStyle(color: Colors.red)),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, _UnsavedAction.save),
            child: Text(l10n.saveButton),
          ),
        ],
      ),
    );

    if (!mounted) return;

    switch (result) {
      case _UnsavedAction.save:
        await _saveAndClose();
      case _UnsavedAction.discard:
        _discardAndClose();
      case _UnsavedAction.cancel:
      case null:
        // Do nothing, stay on document
        break;
    }
  }

  /// Saves the document and closes the screen.
  Future<void> _saveAndClose() async {
    final fileSource = ref.read(fileSourceProvider);

    bool success;
    if (fileSource == FileSourceType.filesApp) {
      // Overwrite the original file
      success = await _overwriteOriginal();
    } else if (fileSource == FileSourceType.convertedImage) {
      // Save converted image PDF to Documents and add to Recent Files
      success = await _saveConvertedImagePdf();
    } else {
      // Open Share Sheet
      success = await _sharePdfAndReturnResult();
    }

    // Only close if save was successful
    if (success && mounted) {
      ref.read(documentDirtyProvider.notifier).markClean();
      ref.read(placedImagesProvider.notifier).clear();
      Navigator.pop(context);
    }
  }

  /// Overwrites the original PDF file with embedded images.
  /// Returns true if save was successful.
  Future<bool> _overwriteOriginal() async {
    final pdfState = ref.read(pdfDocumentProvider);
    final filePath = pdfState.maybeMap(
      loaded: (state) => state.document.filePath,
      orElse: () => null,
    );
    if (filePath == null) return false;

    final placedImages = ref.read(placedImagesProvider);
    final saveService = ref.read(pdfSaveServiceProvider);

    // Show loading indicator
    setState(() => _isSharing = true);

    try {
      final result = await saveService.savePdf(
        originalPath: filePath,
        placedImages: placedImages,
        outputPath: filePath, // Overwrite original
      );

      return result.fold(
        (failure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(failure.message),
                backgroundColor: Colors.red,
              ),
            );
          }
          return false;
        },
        (_) {
          // Success - file saved
          if (kDebugMode) {
            print('PDF saved successfully to: $filePath');
          }
          return true;
        },
      );
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }

  /// Saves a converted image PDF to app's Documents folder.
  /// Returns true if save was successful.
  Future<bool> _saveConvertedImagePdf() async {
    final pdfState = ref.read(pdfDocumentProvider);
    final filePath = pdfState.maybeMap(
      loaded: (state) => state.document.filePath,
      orElse: () => null,
    );
    if (filePath == null) return false;

    final placedImages = ref.read(placedImagesProvider);
    final saveService = ref.read(pdfSaveServiceProvider);

    // Determine suggested filename from original image name or generate one
    final suggestedName = widget.originalImageName ?? 'converted_image.pdf';
    final baseName = suggestedName.replaceAll(RegExp(r'\.[^.]+$'), '');

    setState(() => _isSharing = true);

    try {
      // First, save PDF with placed images to temp location
      final tempResult = await saveService.savePdf(
        originalPath: filePath,
        placedImages: placedImages,
        outputPath: null, // Will create temp file
      );

      final tempPath = tempResult.fold(
        (failure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(failure.message),
                backgroundColor: Colors.red,
              ),
            );
          }
          return null;
        },
        (path) => path,
      );

      if (tempPath == null) return false;

      // Then save to permanent Documents location
      final imageToPdfService = ref.read(imageToPdfServiceProvider);
      final permanentResult = await imageToPdfService.savePdfToDocuments(
        tempPdfPath: tempPath,
        suggestedFileName: '$baseName.pdf',
      );

      return permanentResult.fold(
        (failure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(failure.message),
                backgroundColor: Colors.red,
              ),
            );
          }
          return false;
        },
        (permanentPath) async {
          // Add to recent files with permanent path
          final fileName = permanentPath.split('/').last;
          await ref.read(recentFilesProvider.notifier).addFile(
                RecentFile(
                  path: permanentPath,
                  fileName: fileName,
                  lastOpened: DateTime.now(),
                  pageCount: 1,
                  isPasswordProtected: false,
                ),
              );

          if (kDebugMode) {
            print('Converted PDF saved to: $permanentPath');
          }

          if (mounted) {
            final l10n = AppLocalizations.of(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n?.documentSaved ?? 'Saved'),
              ),
            );
          }
          return true;
        },
      );
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }

  /// Shares the PDF and returns true if share was initiated successfully.
  Future<bool> _sharePdfAndReturnResult() async {
    if (_isSharing) return false;

    // Get the current PDF path and filename
    final pdfState = ref.read(pdfDocumentProvider);
    final (filePath, fileName) = pdfState.maybeMap(
      loaded: (state) => (state.document.filePath, state.document.fileName),
      orElse: () => (null, null),
    );

    if (filePath == null) return false;

    HapticFeedback.lightImpact();
    setState(() => _isSharing = true);

    try {
      final placedImages = ref.read(placedImagesProvider);
      final shareService = ref.read(pdfShareServiceProvider);

      // Get share button position for iOS popover anchor
      final shareButtonBox =
          _shareButtonKey.currentContext?.findRenderObject() as RenderBox?;
      final sharePositionOrigin = shareButtonBox != null
          ? shareButtonBox.localToGlobal(Offset.zero) & shareButtonBox.size
          : null;

      final result = await shareService.sharePdf(
        originalPath: filePath,
        placedImages: placedImages,
        fileName: fileName,
        sharePositionOrigin: sharePositionOrigin,
      );

      return result.fold(
        (failure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(failure.message),
                backgroundColor: Colors.red,
              ),
            );
          }
          return false;
        },
        (_) => true,
      );
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }

  /// Discards changes and closes the screen.
  void _discardAndClose() {
    ref.read(documentDirtyProvider.notifier).markClean();
    ref.read(placedImagesProvider.notifier).clear();
    Navigator.pop(context);
  }

  /// Scrolls PDF to the first page (iOS status bar tap convention).
  void _scrollToTop() {
    _pdfViewerKey.currentState?.scrollToFirstPage();
  }

  /// Shows the "Delete image" onboarding hint when first selection occurs.
  void _maybeShowDeleteHint() {
    final onboarding = ref.read(onboardingProvider.notifier);

    // Only show if resize hint was already shown (user completed earlier flow)
    // and delete hint hasn't been shown yet
    if (onboarding.isShown(OnboardingStep.resizeObject) &&
        onboarding.shouldShow(OnboardingStep.deleteImage)) {
      final l10n = AppLocalizations.of(context);
      if (l10n == null) return;

      // Schedule for next frame to ensure the delete button is rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        final box =
            _deleteButtonKey.currentContext?.findRenderObject() as RenderBox?;
        if (box == null) return;

        final position = box.localToGlobal(Offset.zero);
        final size = box.size;
        final targetRect = position & size;

        CoachMarkController.showAtRect(
          context: context,
          targetRect: targetRect,
          message: l10n.onboardingDeleteImage,
          onDismiss: () {
            onboarding.markShown(OnboardingStep.deleteImage);
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedId = ref.watch(editorSelectionProvider);
    final hasSelection = selectedId != null;
    final isDirty = ref.watch(documentDirtyProvider);

    // Listen for selection changes to show delete hint
    ref.listen<String?>(editorSelectionProvider, (previous, next) {
      // Show delete hint when user first selects an image
      if (previous == null && next != null) {
        _maybeShowDeleteHint();
      }
    });

    return Stack(
      children: [
        PopScope(
          canPop: !isDirty,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop && isDirty) {
              _showUnsavedChangesDialog();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _handleBackPress,
              ),
              title: Text(
                _getDisplayName(context),
                overflow: TextOverflow.ellipsis,
              ),
              actions: [
                if (hasSelection)
                  IconButton(
                    key: _deleteButtonKey,
                    icon: const Icon(CupertinoIcons.trash, color: Colors.red),
                    onPressed: _deleteSelectedImage,
                    tooltip: AppLocalizations.of(context)!.deleteTooltip,
                  ),
                if (_isSharing)
                  const SizedBox(
                    width: 48,
                    height: 48,
                    child: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  )
                else
                  IconButton(
                    key: _shareButtonKey,
                    icon: Icon(Platform.isIOS ? Icons.ios_share : Icons.share),
                    onPressed: _sharePdf,
                    tooltip: AppLocalizations.of(context)!.shareTooltip,
                  ),
              ],
            ),
            body: Stack(
              children: [
                PdfViewer(key: _pdfViewerKey),
                const ImageLibrarySheet(),
              ],
            ),
          ),
        ),
        // iOS status bar tap to scroll to top
        if (Platform.isIOS)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).padding.top,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _scrollToTop,
            ),
          ),
      ],
    );
  }
}
