import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/core/errors/failures.dart';
import 'package:pdfsign/data/datasources/pdf_data_source.dart';
import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/domain/repositories/pdf_document_repository.dart';

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
  Future<Either<Failure, PdfDocumentInfo>> openDocument(
    String filePath,
  ) async {
    try {
      final documentInfo = await _dataSource.openDocument(filePath);
      return Right(documentInfo);
    } on Exception catch (e) {
      final message = e.toString();
      if (message.contains('password') ||
          message.contains('encrypted') ||
          message.contains('protected')) {
        return const Left(PasswordRequiredFailure());
      }
      if (message.contains('not found') || message.contains('No such file')) {
        return const Left(FileNotFoundFailure());
      }
      if (message.contains('permission') || message.contains('access')) {
        return const Left(FileAccessFailure());
      }
      return Left(PdfLoadFailure(message: 'Failed to open PDF: $message'));
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
    } on Exception catch (e) {
      final message = e.toString();
      if (message.contains('password') || message.contains('incorrect')) {
        return const Left(PasswordIncorrectFailure());
      }
      return Left(PdfLoadFailure(message: 'Failed to open PDF: $message'));
    }
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
