import 'dart:async';
import 'dart:typed_data';

import 'package:pdfx/pdfx.dart';

import 'package:minipdfsign/domain/entities/pdf_document_info.dart';
import 'package:minipdfsign/domain/entities/pdf_page_info.dart';

/// Data source interface for PDF operations.
abstract class PdfDataSource {
  /// Opens a PDF document from the given file path.
  Future<PdfDocumentInfo> openDocument(String filePath);

  /// Opens a password-protected PDF document.
  Future<PdfDocumentInfo> openProtectedDocument(
    String filePath,
    String password,
  );

  /// Renders a page at the specified scale.
  ///
  /// [pageNumber] is 1-based.
  /// [scale] is the zoom factor (1.0 = 100%).
  Future<Uint8List> renderPage({
    required int pageNumber,
    required double scale,
  });

  /// Cancels any pending render operation for the specified page.
  void cancelRender(int pageNumber);

  /// Closes the currently opened document.
  Future<void> closeDocument();

  /// Whether a document is currently loaded.
  bool get isDocumentLoaded;

  /// The currently loaded document info, or null if none.
  PdfDocumentInfo? get currentDocument;
}

/// Implementation of [PdfDataSource] using pdfx library.
class PdfDataSourceImpl implements PdfDataSource {
  PdfDocument? _document;
  PdfDocumentInfo? _documentInfo;

  /// Counter for generating unique render IDs.
  int _renderIdCounter = 0;

  /// Maps page number to the current active render ID.
  /// Only the render with this ID should complete successfully.
  final Map<int, int> _activeRenderIds = {};

  /// Maps render ID to its completer.
  final Map<int, Completer<Uint8List>> _pendingRenders = {};

  @override
  bool get isDocumentLoaded => _document != null;

  @override
  PdfDocumentInfo? get currentDocument => _documentInfo;

  @override
  Future<PdfDocumentInfo> openDocument(String filePath) async {
    await closeDocument();

    _document = await PdfDocument.openFile(filePath);
    _documentInfo = await _extractDocumentInfo(filePath, _document!);

    return _documentInfo!;
  }

  @override
  Future<PdfDocumentInfo> openProtectedDocument(
    String filePath,
    String password,
  ) async {
    await closeDocument();

    _document = await PdfDocument.openFile(filePath, password: password);
    _documentInfo = await _extractDocumentInfo(filePath, _document!);

    return _documentInfo!;
  }

  Future<PdfDocumentInfo> _extractDocumentInfo(
    String filePath,
    PdfDocument document,
  ) async {
    final fileName = filePath.split('/').last;
    final pageCount = document.pagesCount;
    final pages = <PdfPageInfo>[];

    for (int i = 1; i <= pageCount; i++) {
      final page = await document.getPage(i);
      pages.add(PdfPageInfo(
        pageNumber: i,
        width: page.width,
        height: page.height,
      ));
      await page.close();
    }

    return PdfDocumentInfo(
      filePath: filePath,
      fileName: fileName,
      pageCount: pageCount,
      pages: pages,
    );
  }

  @override
  Future<Uint8List> renderPage({
    required int pageNumber,
    required double scale,
  }) async {
    if (_document == null) {
      throw StateError('No document loaded');
    }

    // Generate unique render ID for this request
    final renderId = ++_renderIdCounter;

    // Cancel any previous render for this page and set new active ID
    _activeRenderIds[pageNumber] = renderId;

    final completer = Completer<Uint8List>();
    _pendingRenders[renderId] = completer;

    try {
      // Check if this render is still active before expensive operations
      if (_activeRenderIds[pageNumber] != renderId) {
        throw RenderCancelledException(pageNumber);
      }

      final page = await _document!.getPage(pageNumber);

      // Check again after async operation
      if (_activeRenderIds[pageNumber] != renderId) {
        await page.close();
        throw RenderCancelledException(pageNumber);
      }

      final pageImage = await page.render(
        width: page.width * scale,
        height: page.height * scale,
        format: PdfPageImageFormat.png,
        backgroundColor: '#FFFFFF',
      );

      await page.close();

      // Final check before completing - only complete if still active
      if (_activeRenderIds[pageNumber] != renderId) {
        throw RenderCancelledException(pageNumber);
      }

      final bytes = pageImage!.bytes;
      completer.complete(bytes);
      return bytes;
    } catch (e) {
      if (e is RenderCancelledException) {
        rethrow;
      }
      completer.completeError(e);
      rethrow;
    } finally {
      _pendingRenders.remove(renderId);
    }
  }

  @override
  void cancelRender(int pageNumber) {
    // Remove active render ID - any ongoing render for this page will fail
    // its check and throw RenderCancelledException
    _activeRenderIds.remove(pageNumber);
  }

  @override
  Future<void> closeDocument() async {
    // Clear all active renders
    _activeRenderIds.clear();
    _pendingRenders.clear();

    if (_document != null) {
      await _document!.close();
      _document = null;
      _documentInfo = null;
    }
  }
}

/// Exception thrown when a render operation is cancelled.
class RenderCancelledException implements Exception {
  final int pageNumber;

  RenderCancelledException(this.pageNumber);

  @override
  String toString() => 'Render cancelled for page $pageNumber';
}
