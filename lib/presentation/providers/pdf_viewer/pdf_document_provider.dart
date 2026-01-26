import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:minipdfsign/core/errors/failures.dart';
import 'package:minipdfsign/domain/entities/pdf_document_info.dart';
import 'package:minipdfsign/presentation/providers/pdf_viewer/pdf_page_cache_provider.dart';
import 'package:minipdfsign/presentation/providers/pdf_viewer/pdf_viewer_state.dart';
import 'package:minipdfsign/presentation/providers/repository_providers.dart';

export 'package:minipdfsign/presentation/providers/pdf_viewer/pdf_viewer_state.dart';

part 'pdf_document_provider.g.dart';

/// Provider for managing PDF document loading and state.
///
/// Handles document loading, continuous zoom, and page navigation.
@Riverpod(keepAlive: true)
class PdfDocument extends _$PdfDocument {
  @override
  PdfViewerState build() {
    return const PdfViewerState.initial();
  }

  /// Opens a PDF document from the given file path.
  Future<void> openDocument(String filePath) async {
    state = PdfViewerState.loading(filePath: filePath);

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
  /// Does nothing if already at max scale.
  void zoomInStep() {
    state.maybeMap(
      loaded: (current) {
        // Skip if already at max scale
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
          // At max preset, increase by step
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
  /// Does nothing if already at min scale.
  void zoomOutStep() {
    state.maybeMap(
      loaded: (current) {
        // Skip if already at min scale
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
          // At min preset, decrease by step
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

    // Find the widest page
    double maxPageWidth = 0;
    for (final page in document.pages) {
      if (page.width > maxPageWidth) {
        maxPageWidth = page.width;
      }
    }

    if (maxPageWidth <= 0) {
      return 1.0;
    }

    // Account for horizontal padding (40px on each side)
    const horizontalPadding = 80.0;
    final availableWidth = viewportWidth - horizontalPadding;

    return availableWidth / maxPageWidth;
  }
}
