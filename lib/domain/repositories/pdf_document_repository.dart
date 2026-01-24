import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/domain/entities/pdf_document_info.dart';

/// Repository interface for PDF document operations.
///
/// Handles opening, loading, and rendering PDF documents.
abstract class PdfDocumentRepository {
  /// Opens a PDF document from the given file path.
  ///
  /// Returns [PdfDocumentInfo] with document metadata and page information.
  /// Returns a [Failure] if the document cannot be opened.
  Future<Either<Failure, PdfDocumentInfo>> openDocument(String filePath);

  /// Opens a password-protected PDF document.
  ///
  /// Returns [PdfDocumentInfo] with document metadata and page information.
  /// Returns [PasswordIncorrectFailure] if the password is wrong.
  Future<Either<Failure, PdfDocumentInfo>> openProtectedDocument(
    String filePath,
    String password,
  );

  /// Renders a page at the specified scale.
  ///
  /// [pageNumber] is 1-based.
  /// [scale] is the zoom factor (1.0 = 100%).
  ///
  /// Returns the rendered page as PNG bytes.
  /// Returns a [Failure] if rendering fails.
  Future<Either<Failure, Uint8List>> renderPage({
    required int pageNumber,
    required double scale,
  });

  /// Cancels any pending render operation for the specified page.
  ///
  /// Used when pages are scrolled out of view to free resources.
  void cancelRender(int pageNumber);

  /// Closes the currently opened document and releases resources.
  Future<void> closeDocument();

  /// Whether a document is currently loaded.
  bool get isDocumentLoaded;

  /// The currently loaded document info, or null if none.
  PdfDocumentInfo? get currentDocument;
}
