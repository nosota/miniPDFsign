import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:minipdfsign/core/errors/failures.dart';
import 'package:minipdfsign/domain/entities/pdf_document_info.dart';
import 'package:minipdfsign/domain/entities/placed_image.dart';
import 'package:minipdfsign/presentation/providers/pdf_viewer/pdf_page_cache_provider.dart';
import 'package:minipdfsign/presentation/providers/pdf_viewer/pdf_viewer_state.dart';
import 'package:minipdfsign/presentation/providers/repository_providers.dart';
import 'package:minipdfsign/presentation/providers/services/image_to_pdf_service_provider.dart';
import 'package:minipdfsign/presentation/providers/viewer_session/viewer_session.dart';

part 'viewer_session_provider.g.dart';

/// Provider for managing viewer sessions.
///
/// Tracks active sessions and provides cleanup functionality.
/// Sessions are automatically disposed when invalidated.
@Riverpod(keepAlive: true)
class ViewerSessions extends _$ViewerSessions {
  @override
  Set<String> build() {
    return {};
  }

  /// Registers a new session.
  void registerSession(ViewerSession session) {
    if (kDebugMode) {
      print('ViewerSessions: Registering session ${session.id}');
    }
    state = {...state, session.id};
  }

  /// Unregisters a session and triggers cleanup of associated providers.
  void unregisterSession(String sessionId) {
    if (kDebugMode) {
      print('ViewerSessions: Unregistering session $sessionId');
    }
    state = state.where((id) => id != sessionId).toSet();

    // Invalidate all family providers for this session
    ref.invalidate(sessionPdfDocumentProvider(sessionId));
    ref.invalidate(sessionFileSourceProvider(sessionId));
    ref.invalidate(sessionDocumentDirtyProvider(sessionId));
    ref.invalidate(sessionPlacedImagesProvider(sessionId));
    ref.invalidate(sessionEditorSelectionProvider(sessionId));
    ref.invalidate(sessionPermissionRetryProvider(sessionId));
  }

  /// Checks if a session is registered.
  bool isRegistered(String sessionId) => state.contains(sessionId);
}

// =============================================================================
// Session-scoped family providers
// =============================================================================
// These providers are isolated per session ID, ensuring that multiple
// PdfViewerScreen instances don't share state.

/// PDF document state provider, scoped to a session.
///
/// This is the main provider for PDF viewing - handles loading, zoom, navigation.
@riverpod
class SessionPdfDocument extends _$SessionPdfDocument {
  @override
  PdfViewerState build(String sessionId) {
    return const PdfViewerState.initial();
  }

  /// Converts images to PDF and opens the resulting document.
  ///
  /// Shows converting state while processing, then transitions to loaded state.
  /// Returns the path of the converted PDF, or null if conversion failed.
  Future<String?> convertAndOpenImages(List<String> imagePaths) async {
    state = PdfViewerState.converting(imageCount: imagePaths.length);

    // Clear old document's cached pages before conversion
    ref.read(pdfPageCacheProvider).clear();

    final imageToPdfService = ref.read(imageToPdfServiceProvider);

    final String? pdfPath;
    if (imagePaths.length == 1) {
      final result = await imageToPdfService.convertImageToPdf(imagePaths.first);
      pdfPath = result.fold(
        (failure) => null,
        (path) => path,
      );
    } else {
      final result = await imageToPdfService.convertImagesToPdf(imagePaths);
      pdfPath = result.fold(
        (failure) => null,
        (path) => path,
      );
    }

    if (pdfPath == null) {
      state = const PdfViewerState.error(
        message: 'Failed to convert images to PDF',
      );
      return null;
    }

    // Now open the converted PDF
    await openDocument(pdfPath);
    return pdfPath;
  }

  /// Opens a PDF document from the given file path.
  Future<void> openDocument(String filePath) async {
    state = PdfViewerState.loading(filePath: filePath);

    // Clear old document's cached pages before loading new one
    ref.read(pdfPageCacheProvider).clear();

    final repository = ref.read(pdfDocumentRepositoryProvider);
    final result = await repository.openDocument(filePath);

    result.fold(
      (failure) {
        if (failure is PasswordRequiredFailure) {
          state = PdfViewerState.passwordRequired(filePath: filePath);
        } else {
          state = PdfViewerState.error(
            message: failure.message,
            filePath: filePath,
          );
        }
      },
      (document) {
        state = PdfViewerState.loaded(
          document: document,
          scale: 1.0,
          isFitWidth: true,
          fitWidthScale: 1.0,
          currentPage: 1,
          viewportWidth: 0,
          viewportHeight: 0,
        );
      },
    );
  }

  /// Opens a password-protected PDF document.
  Future<void> openProtectedDocument(String filePath, String password) async {
    state = PdfViewerState.loading(filePath: filePath);

    // Clear old document's cached pages before loading new one
    ref.read(pdfPageCacheProvider).clear();

    final repository = ref.read(pdfDocumentRepositoryProvider);
    final result = await repository.openProtectedDocument(filePath, password);

    result.fold(
      (failure) {
        if (failure is PasswordIncorrectFailure) {
          state = PdfViewerState.error(
            message: 'Incorrect password',
            filePath: filePath,
          );
        } else {
          state = PdfViewerState.error(
            message: failure.message,
            filePath: filePath,
          );
        }
      },
      (document) {
        state = PdfViewerState.loaded(
          document: document,
          scale: 1.0,
          isFitWidth: true,
          fitWidthScale: 1.0,
          currentPage: 1,
          viewportWidth: 0,
          viewportHeight: 0,
        );
      },
    );
  }

  /// Closes the current document.
  Future<void> closeDocument() async {
    final repository = ref.read(pdfDocumentRepositoryProvider);
    await repository.closeDocument();
    state = const PdfViewerState.initial();
  }

  /// Reloads the current document, preserving the current page.
  ///
  /// Returns the page number to restore after reload, or null if reload failed.
  Future<int?> reloadDocument() async {
    final currentState = state;
    String? filePath;
    int pageToRestore = 1;

    // Extract file path and current page from current state
    currentState.maybeMap(
      loaded: (loaded) {
        filePath = loaded.document.filePath;
        pageToRestore = loaded.currentPage;
      },
      error: (error) {
        filePath = error.filePath;
      },
      passwordRequired: (pwd) {
        filePath = pwd.filePath;
      },
      orElse: () {},
    );

    if (filePath == null || filePath!.isEmpty) {
      return null;
    }

    // Clear page cache before reload
    ref.read(pdfPageCacheProvider).clear();

    // Close and reopen
    final repository = ref.read(pdfDocumentRepositoryProvider);
    await repository.closeDocument();

    state = PdfViewerState.loading(filePath: filePath!);

    final result = await repository.openDocument(filePath!);

    return result.fold(
      (failure) {
        if (failure is PasswordRequiredFailure) {
          state = PdfViewerState.passwordRequired(filePath: filePath!);
        } else {
          state = PdfViewerState.error(
            message: failure.message,
            filePath: filePath,
          );
        }
        return null;
      },
      (document) {
        // Clamp page to valid range in case document changed
        final validPage = pageToRestore.clamp(1, document.pageCount);

        state = PdfViewerState.loaded(
          document: document,
          scale: 1.0,
          isFitWidth: true,
          fitWidthScale: 1.0,
          currentPage: validPage,
          viewportWidth: 0,
          viewportHeight: 0,
        );

        return validPage;
      },
    );
  }

  /// Sets the scale to a specific value (continuous zoom).
  /// Returns true if scale was changed, false if already at limit.
  bool setScale(double newScale) {
    var changed = false;
    state.maybeMap(
      loaded: (current) {
        final clampedScale = newScale.clamp(
          ZoomConstraints.minScale,
          ZoomConstraints.maxScale,
        );
        // Skip if scale didn't change (already at limit)
        if ((clampedScale - current.scale).abs() < 0.001) {
          return;
        }
        state = current.copyWith(
          scale: clampedScale,
          isFitWidth: false,
        );
        changed = true;
      },
      orElse: () {},
    );
    return changed;
  }

  /// Multiplies the current scale by a factor (for pinch-to-zoom).
  void multiplyScale(double factor) {
    state.maybeMap(
      loaded: (current) {
        final newScale = current.scale * factor;
        final clampedScale = newScale.clamp(
          ZoomConstraints.minScale,
          ZoomConstraints.maxScale,
        );
        state = current.copyWith(
          scale: clampedScale,
          isFitWidth: false,
        );
      },
      orElse: () {},
    );
  }

  /// Zooms to fit width mode.
  void fitToWidth() {
    state.maybeMap(
      loaded: (current) {
        state = current.copyWith(
          scale: current.fitWidthScale,
          isFitWidth: true,
        );
      },
      orElse: () {},
    );
  }

  /// Zooms in to the next preset level (for Cmd+).
  void zoomInStep() {
    state.maybeMap(
      loaded: (current) {
        if (current.scale >= ZoomConstraints.maxScale - 0.001) {
          return;
        }
        final nextPreset = ZoomPreset.nextPresetAbove(current.scale);
        if (nextPreset != null && nextPreset.scale != null) {
          state = current.copyWith(
            scale: nextPreset.scale!,
            isFitWidth: false,
          );
        } else {
          final newScale = (current.scale + ZoomConstraints.zoomStep)
              .clamp(ZoomConstraints.minScale, ZoomConstraints.maxScale);
          state = current.copyWith(
            scale: newScale,
            isFitWidth: false,
          );
        }
      },
      orElse: () {},
    );
  }

  /// Zooms out to the previous preset level (for Cmd-).
  void zoomOutStep() {
    state.maybeMap(
      loaded: (current) {
        if (current.scale <= ZoomConstraints.minScale + 0.001) {
          return;
        }
        final prevPreset = ZoomPreset.nextPresetBelow(current.scale);
        if (prevPreset != null && prevPreset.scale != null) {
          state = current.copyWith(
            scale: prevPreset.scale!,
            isFitWidth: false,
          );
        } else {
          final newScale = (current.scale - ZoomConstraints.zoomStep)
              .clamp(ZoomConstraints.minScale, ZoomConstraints.maxScale);
          state = current.copyWith(
            scale: newScale,
            isFitWidth: false,
          );
        }
      },
      orElse: () {},
    );
  }

  /// Sets the current page number (1-based).
  void setCurrentPage(int pageNumber) {
    state.maybeMap(
      loaded: (current) {
        final clampedPage = pageNumber.clamp(1, current.document.pageCount);
        if (clampedPage != current.currentPage) {
          state = current.copyWith(currentPage: clampedPage);
        }
      },
      orElse: () {},
    );
  }

  /// Goes to the next page.
  void nextPage() {
    state.maybeMap(
      loaded: (current) {
        if (current.currentPage < current.document.pageCount) {
          state = current.copyWith(currentPage: current.currentPage + 1);
        }
      },
      orElse: () {},
    );
  }

  /// Goes to the previous page.
  void previousPage() {
    state.maybeMap(
      loaded: (current) {
        if (current.currentPage > 1) {
          state = current.copyWith(currentPage: current.currentPage - 1);
        }
      },
      orElse: () {},
    );
  }

  /// Updates the viewport dimensions.
  void updateViewport(double width, double height) {
    state.maybeMap(
      loaded: (current) {
        if (width != current.viewportWidth ||
            height != current.viewportHeight) {
          final fitWidthScale = _calculateFitWidthScale(width, current.document);
          final newScale = current.isFitWidth ? fitWidthScale : current.scale;

          state = current.copyWith(
            viewportWidth: width,
            viewportHeight: height,
            fitWidthScale: fitWidthScale,
            scale: newScale,
          );
        }
      },
      orElse: () {},
    );
  }

  double _calculateFitWidthScale(double viewportWidth, PdfDocumentInfo document) {
    if (viewportWidth <= 0 || document.pages.isEmpty) {
      return 1.0;
    }

    double maxPageWidth = 0;
    for (final page in document.pages) {
      if (page.width > maxPageWidth) {
        maxPageWidth = page.width;
      }
    }

    if (maxPageWidth <= 0) {
      return 1.0;
    }

    const horizontalPadding = 80.0;
    final availableWidth = viewportWidth - horizontalPadding;

    return availableWidth / maxPageWidth;
  }
}

/// File source type for session.
enum FileSourceTypeSession {
  filesApp,
  filePicker,
  recentFile,
  convertedImage,
}

/// File source state for session.
@immutable
class SessionFileSourceState {
  const SessionFileSourceState({
    this.type = FileSourceTypeSession.filePicker,
    this.originalImageName,
  });

  final FileSourceTypeSession type;
  final String? originalImageName;

  bool get canOverwrite => type == FileSourceTypeSession.filesApp;
  bool get isConvertedImage => type == FileSourceTypeSession.convertedImage;
}

/// File source provider, scoped to a session.
@riverpod
class SessionFileSource extends _$SessionFileSource {
  @override
  SessionFileSourceState build(String sessionId) {
    return const SessionFileSourceState();
  }

  void setFileSource(
    FileSourceTypeSession type, {
    String? originalImageName,
  }) {
    state = SessionFileSourceState(
      type: type,
      originalImageName: originalImageName,
    );
  }
}

/// Document dirty state provider, scoped to a session.
@riverpod
class SessionDocumentDirty extends _$SessionDocumentDirty {
  @override
  bool build(String sessionId) {
    return false;
  }

  void markDirty() => state = true;
  void markClean() => state = false;
}

/// Placed images provider, scoped to a session.
///
/// Uses the domain PlacedImage entity for compatibility with existing code.
@riverpod
class SessionPlacedImages extends _$SessionPlacedImages {
  final _uuid = const Uuid();

  @override
  List<PlacedImage> build(String sessionId) {
    return [];
  }

  /// Adds a new image to the PDF at the specified position.
  void addImage({
    required String sourceImageId,
    required String imagePath,
    required int pageIndex,
    required Offset position,
    required Size size,
  }) {
    final image = PlacedImage(
      id: _uuid.v4(),
      sourceImageId: sourceImageId,
      imagePath: imagePath,
      pageIndex: pageIndex,
      position: position,
      size: size,
    );

    state = [...state, image];
  }

  /// Removes an image by its ID.
  void removeImage(String id) {
    state = state.where((img) => img.id != id).toList();
  }

  /// Updates an existing image.
  void updateImage(PlacedImage updated) {
    state = state.map((img) => img.id == updated.id ? updated : img).toList();
  }

  /// Moves an image to a new position.
  void moveImage(String id, Offset newPosition) {
    state = state.map((img) {
      if (img.id == id) {
        return img.copyWith(position: newPosition);
      }
      return img;
    }).toList();
  }

  /// Resizes an image.
  void resizeImage(String id, Size newSize) {
    state = state.map((img) {
      if (img.id == id) {
        return img.copyWith(size: newSize);
      }
      return img;
    }).toList();
  }

  /// Rotates an image.
  void rotateImage(String id, double newRotation) {
    state = state.map((img) {
      if (img.id == id) {
        return img.copyWith(rotation: newRotation);
      }
      return img;
    }).toList();
  }

  /// Updates image position, size, and rotation together (for smooth manipulation).
  void transformImage(
    String id, {
    Offset? position,
    Size? size,
    double? rotation,
    int? pageIndex,
  }) {
    state = state.map((img) {
      if (img.id == id) {
        return img.copyWith(
          position: position,
          size: size,
          rotation: rotation,
          pageIndex: pageIndex,
        );
      }
      return img;
    }).toList();
  }

  /// Gets images for a specific page.
  List<PlacedImage> getImagesForPage(int pageIndex) {
    return state.where((img) => img.pageIndex == pageIndex).toList();
  }

  /// Creates a duplicate of an image at an offset position.
  PlacedImage? duplicateImage(String id, {Offset offset = const Offset(20, 20)}) {
    final original = state.firstWhere(
      (img) => img.id == id,
      orElse: () => throw StateError('Image not found'),
    );

    final duplicate = PlacedImage(
      id: _uuid.v4(),
      sourceImageId: original.sourceImageId,
      imagePath: original.imagePath,
      pageIndex: original.pageIndex,
      position: original.position + offset,
      size: original.size,
      rotation: original.rotation,
    );

    state = [...state, duplicate];
    return duplicate;
  }

  /// Clears all placed images.
  void clear() {
    state = [];
  }

  /// Checks if there are any placed images.
  bool get hasImages => state.isNotEmpty;
}

/// Editor selection provider, scoped to a session.
@riverpod
class SessionEditorSelection extends _$SessionEditorSelection {
  @override
  String? build(String sessionId) {
    return null;
  }

  void select(String id) => state = id;
  void clear() => state = null;
  void toggle(String id) => state = state == id ? null : id;
  bool isSelected(String id) => state == id;
}

/// Permission retry provider, scoped to a session.
@riverpod
class SessionPermissionRetry extends _$SessionPermissionRetry {
  @override
  bool build(String sessionId) {
    return false;
  }

  void setRetrying(bool value) => state = value;
}
