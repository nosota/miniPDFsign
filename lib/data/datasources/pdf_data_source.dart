import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:pdfx/pdfx.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sf;

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

  /// Decrypted PDF bytes from the last [openProtectedDocument] call.
  ///
  /// Available after a password-protected PDF is successfully opened.
  /// Null for non-encrypted PDFs or after [closeDocument].
  Uint8List? get decryptedBytes;
}

/// Implementation of [PdfDataSource] using pdfx library.
class PdfDataSourceImpl implements PdfDataSource {
  PdfDocument? _document;
  PdfDocumentInfo? _documentInfo;
  Uint8List? _decryptedBytes;

  /// Counter for generating unique render IDs.
  int _renderIdCounter = 0;

  /// Maps page number to the current active render ID.
  /// Only the render with this ID should complete successfully.
  final Map<int, int> _activeRenderIds = {};

  /// Maps render ID to its completer.
  final Map<int, Completer<Uint8List>> _pendingRenders = {};

  /// Serializes page rendering to prevent concurrent getPage/render/close
  /// calls. Android's PdfRenderer only allows one open page at a time
  /// per document; concurrent access causes PlatformException.
  Completer<void>? _renderGate;

  @override
  bool get isDocumentLoaded => _document != null;

  @override
  PdfDocumentInfo? get currentDocument => _documentInfo;

  @override
  Uint8List? get decryptedBytes => _decryptedBytes;

  /// ASCII code units for `/Encrypt` — the PDF spec (§7.6) requires
  /// this dictionary entry in every encrypted document.
  static const _encryptMarker = <int>[
    0x2F, 0x45, 0x6E, 0x63, 0x72, 0x79, 0x70, 0x74, // /Encrypt
  ];

  @override
  Future<PdfDocumentInfo> openDocument(String filePath) async {
    await closeDocument();

    try {
      _document = await PdfDocument.openFile(filePath);
    } catch (e) {
      // Android's PdfRenderer throws SecurityException for encrypted
      // PDFs, but pdfx wraps it as generic "Unknown error".
      // Fall back to scanning the file for the /Encrypt marker.
      if (await _hasEncryptMarker(filePath)) {
        throw PasswordProtectedException();
      }
      rethrow;
    }
    _documentInfo = await _extractDocumentInfo(filePath, _document!);

    return _documentInfo!;
  }

  /// Scans raw PDF bytes for the `/Encrypt` dictionary entry.
  ///
  /// Only called when pdfx fails to open a file, so the cost of
  /// reading the file is acceptable.
  Future<bool> _hasEncryptMarker(String filePath) async {
    try {
      final bytes = await File(filePath).readAsBytes();
      for (var i = 0; i <= bytes.length - _encryptMarker.length; i++) {
        if (bytes[i] != 0x2F) continue;
        var match = true;
        for (var j = 1; j < _encryptMarker.length; j++) {
          if (bytes[i + j] != _encryptMarker[j]) {
            match = false;
            break;
          }
        }
        if (match) return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<PdfDocumentInfo> openProtectedDocument(
    String filePath,
    String password,
  ) async {
    await closeDocument();

    // pdfx ignores password on iOS/Android, so we decrypt with Syncfusion
    // first, then open the decrypted bytes with pdfx for rendering.
    final encryptedBytes = await File(filePath).readAsBytes();
    final sfDoc = sf.PdfDocument(inputBytes: encryptedBytes, password: password);
    sfDoc.security.userPassword = '';
    sfDoc.security.ownerPassword = '';
    final decryptedBytes = Uint8List.fromList(await sfDoc.save());
    sfDoc.dispose();

    _decryptedBytes = decryptedBytes;
    _document = await PdfDocument.openData(decryptedBytes);
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

      // Wait for any in-progress render to finish. Android's PdfRenderer
      // allows only one open page at a time; concurrent getPage/render
      // calls cause PlatformException.
      while (_renderGate != null) {
        // Check cancellation before waiting to avoid queueing stale
        // requests that would block newer ones.
        if (_activeRenderIds[pageNumber] != renderId) {
          throw RenderCancelledException(pageNumber);
        }
        await _renderGate!.future;
      }

      // Re-check after waiting — a newer request may have replaced us.
      if (_activeRenderIds[pageNumber] != renderId) {
        throw RenderCancelledException(pageNumber);
      }

      // Acquire the render gate.
      final gate = Completer<void>();
      _renderGate = gate;

      try {
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

        // Final check before completing
        if (_activeRenderIds[pageNumber] != renderId) {
          throw RenderCancelledException(pageNumber);
        }

        // pageImage can be null on Android under memory pressure.
        if (pageImage == null) {
          throw RenderCancelledException(pageNumber);
        }

        final bytes = pageImage.bytes;
        completer.complete(bytes);
        return bytes;
      } finally {
        // Release the gate so the next queued render can proceed.
        _renderGate = null;
        gate.complete();
      }
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
    _renderGate = null;
    _decryptedBytes = null;

    if (_document != null) {
      await _document!.close();
      _document = null;
      _documentInfo = null;
    }
  }
}

/// Exception thrown when a PDF file is password-protected.
class PasswordProtectedException implements Exception {
  @override
  String toString() => 'PDF is password protected';
}

/// Exception thrown when a render operation is cancelled.
class RenderCancelledException implements Exception {
  final int pageNumber;

  RenderCancelledException(this.pageNumber);

  @override
  String toString() => 'Render cancelled for page $pageNumber';
}
