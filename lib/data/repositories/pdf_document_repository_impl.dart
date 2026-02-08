import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:minipdfsign/core/errors/failure.dart';
import 'package:minipdfsign/core/errors/failures.dart';
import 'package:minipdfsign/data/datasources/pdf_data_source.dart';
import 'package:minipdfsign/domain/entities/pdf_document_info.dart';
import 'package:minipdfsign/domain/repositories/pdf_document_repository.dart';

/// Implementation of [PdfDocumentRepository] using [PdfDataSource].
class PdfDocumentRepositoryImpl implements PdfDocumentRepository {
  PdfDocumentRepositoryImpl({
    required PdfDataSource dataSource,
  }) : _dataSource = dataSource;

  final PdfDataSource _dataSource;

  @override
  bool get isDocumentLoaded => _dataSource.isDocumentLoaded;

  @override
  PdfDocumentInfo? get currentDocument => _dataSource.currentDocument;

  @override
  Uint8List? get decryptedBytes => _dataSource.decryptedBytes;

  @override
  Future<Either<Failure, PdfDocumentInfo>> openDocument(
    String filePath,
  ) async {
    try {
      final documentInfo = await _dataSource.openDocument(filePath);
      return Right(documentInfo);
    } on PasswordProtectedException {
      return const Left(PasswordRequiredFailure());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('PdfDocumentRepositoryImpl.openDocument PlatformException: '
            'code=${e.code}, message=${e.message}');
      }
      if (_isPasswordRelatedError(e)) {
        return const Left(PasswordRequiredFailure());
      }
      return Left(PdfLoadFailure(
        message: 'Failed to open PDF: ${e.message ?? e.code}',
      ));
    } on Exception catch (e) {
      if (kDebugMode) {
        print('PdfDocumentRepositoryImpl.openDocument error: '
            'type=${e.runtimeType}, message=${e.toString()}');
      }
      final message = e.toString().toLowerCase();
      if (message.contains('password') ||
          message.contains('encrypted') ||
          message.contains('protected')) {
        return const Left(PasswordRequiredFailure());
      }
      if (message.contains('not found') || message.contains('no such file')) {
        return const Left(FileNotFoundFailure());
      }
      if (message.contains('permission') || message.contains('access')) {
        return const Left(FileAccessFailure());
      }
      return Left(
        PdfLoadFailure(message: 'Failed to open PDF: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, PdfDocumentInfo>> openProtectedDocument(
    String filePath,
    String password,
  ) async {
    try {
      final documentInfo = await _dataSource.openProtectedDocument(
        filePath,
        password,
      );
      return Right(documentInfo);
    } on ArgumentError catch (e) {
      // Syncfusion throws ArgumentError (not Exception) for wrong password:
      // ArgumentError('password', 'Cannot open an encrypted document...')
      if (kDebugMode) {
        print('PdfDocumentRepositoryImpl.openProtectedDocument '
            'ArgumentError: ${e.message}');
      }
      return const Left(PasswordIncorrectFailure());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('PdfDocumentRepositoryImpl.openProtectedDocument '
            'PlatformException: code=${e.code}, message=${e.message}');
      }
      if (_isPasswordRelatedError(e)) {
        return const Left(PasswordIncorrectFailure());
      }
      return Left(
        PdfLoadFailure(
          message: 'Failed to open PDF: ${e.message ?? e.code}',
        ),
      );
    } on Exception catch (e) {
      final message = e.toString().toLowerCase();
      if (message.contains('password') || message.contains('incorrect')) {
        return const Left(PasswordIncorrectFailure());
      }
      return Left(PdfLoadFailure(message: 'Failed to open PDF: $e'));
    }
  }

  /// Checks if a PlatformException from pdfx indicates a password-protected PDF.
  ///
  /// pdfx throws different errors per platform for encrypted PDFs:
  /// - iOS/macOS: PlatformException(RENDER_ERROR, Invalid PDF format, null)
  /// - Android: PlatformException(pdf_renderer, Can't open file, null)
  bool _isPasswordRelatedError(PlatformException e) {
    final code = e.code;
    final message = (e.message ?? '').toLowerCase();

    // iOS/macOS: CGPDFDocument returns nil for encrypted PDFs
    if (code == 'RENDER_ERROR' && message.contains('invalid pdf format')) {
      return true;
    }

    // Android: PdfRenderer throws IOException for encrypted PDFs
    if (code == 'pdf_renderer' && message.contains("can't open file")) {
      return true;
    }

    // Generic fallback for future pdfx versions or other platforms
    if (message.contains('password') ||
        message.contains('encrypted') ||
        message.contains('protected')) {
      return true;
    }

    return false;
  }

  @override
  Future<Either<Failure, Uint8List>> renderPage({
    required int pageNumber,
    required double scale,
  }) async {
    try {
      final bytes = await _dataSource.renderPage(
        pageNumber: pageNumber,
        scale: scale,
      );
      return Right(bytes);
    } on RenderCancelledException catch (e) {
      return Left(RenderCancelledFailure(pageNumber: e.pageNumber));
    } on Exception catch (e) {
      return Left(PdfRenderFailure(
        pageNumber: pageNumber,
        message: 'Failed to render page $pageNumber: $e',
      ));
    }
  }

  @override
  void cancelRender(int pageNumber) {
    _dataSource.cancelRender(pageNumber);
  }

  @override
  Future<void> closeDocument() async {
    await _dataSource.closeDocument();
  }
}
