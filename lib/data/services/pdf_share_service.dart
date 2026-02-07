import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart';

import 'package:minipdfsign/core/errors/failure.dart';
import 'package:minipdfsign/core/errors/failures.dart';
import 'package:minipdfsign/data/services/pdf_save_service.dart';
import 'package:minipdfsign/domain/entities/placed_image.dart';

/// Service for sharing PDF documents.
///
/// Handles both original PDFs and PDFs with embedded images.
class PdfShareService {
  PdfShareService({
    required PdfSaveService pdfSaveService,
  }) : _pdfSaveService = pdfSaveService;

  final PdfSaveService _pdfSaveService;

  /// Delay before cleaning up temporary files (allows share sheet to finish).
  static const Duration _cleanupDelay = Duration(seconds: 30);

  /// Temporary file path to clean up after sharing.
  String? _tempFilePath;

  /// Timer for scheduled cleanup.
  Timer? _cleanupTimer;

  /// Shares the PDF document.
  ///
  /// If [placedImages] is empty, shares the original PDF directly.
  /// If [placedImages] is not empty, creates a temporary PDF with
  /// embedded images, shares it, then schedules cleanup.
  ///
  /// [originalPath] - Path to the original PDF file.
  /// [placedImages] - List of images placed on the PDF.
  /// [fileName] - Display name for the shared file (used in share sheet).
  /// [sharePositionOrigin] - Required on iOS/iPadOS for popover anchor position.
  /// [password] - Password for encrypted PDFs (applied to the output file).
  /// [originalBytes] - Pre-loaded PDF bytes (e.g. decrypted). If provided,
  ///   used instead of reading from [originalPath].
  ///
  /// Returns [Right] with the share result, or [Left] with a failure.
  Future<Either<Failure, ShareResult>> sharePdf({
    required String originalPath,
    required List<PlacedImage> placedImages,
    String? fileName,
    Rect? sharePositionOrigin,
    String? password,
    Uint8List? originalBytes,
  }) async {
    try {
      // Cancel any pending cleanup and clean up previous temp file
      _cancelCleanupTimer();
      await _cleanupTempFile();

      String pathToShare;

      if (placedImages.isEmpty) {
        // No images placed - share original PDF directly
        pathToShare = originalPath;
      } else {
        // Images placed - create temp PDF with embedded images
        final Either<Failure, String> tempResult;
        if (originalBytes != null) {
          tempResult = await _pdfSaveService.createTempPdfWithImagesFromBytes(
            originalBytes: originalBytes,
            placedImages: placedImages,
            password: password,
          );
        } else {
          tempResult = await _pdfSaveService.createTempPdfWithImages(
            originalPath: originalPath,
            placedImages: placedImages,
            password: password,
          );
        }

        // Propagate failure directly instead of throwing
        if (tempResult.isLeft()) {
          return Left(
            tempResult.fold(
              (failure) => failure,
              (_) => throw StateError('Unreachable'),
            ),
          );
        }

        final tempPath = tempResult.fold(
          (_) => throw StateError('Unreachable'),
          (path) => path,
        );

        _tempFilePath = tempPath;
        pathToShare = tempPath;
      }

      // Verify file exists
      final file = File(pathToShare);
      if (!await file.exists()) {
        return Left(FileNotFoundFailure(message: 'PDF file not found'));
      }

      // Use provided fileName or extract from original path
      final displayName = fileName ?? p.basename(originalPath);

      // Share the file
      final result = await Share.shareXFiles(
        [XFile(pathToShare)],
        subject: displayName,
        sharePositionOrigin: sharePositionOrigin,
      );

      // Schedule cleanup after share completes
      _scheduleCleanup();

      return Right(result);
    } catch (e) {
      await _cleanupTempFile();
      return Left(ShareFailure(message: 'Failed to share PDF: $e'));
    }
  }

  /// Schedules cleanup of temporary file after a delay.
  ///
  /// The delay allows the share sheet to complete its operation.
  void _scheduleCleanup() {
    _cancelCleanupTimer();
    _cleanupTimer = Timer(_cleanupDelay, _cleanupTempFile);
  }

  /// Cancels any pending cleanup timer.
  void _cancelCleanupTimer() {
    _cleanupTimer?.cancel();
    _cleanupTimer = null;
  }

  /// Cleans up the temporary file if it exists.
  Future<void> _cleanupTempFile() async {
    final path = _tempFilePath;
    if (path != null) {
      try {
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
          if (kDebugMode) {
            print('PdfShareService: Cleaned up temp file: $path');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('PdfShareService: Failed to cleanup temp file: $e');
        }
      }
      _tempFilePath = null;
    }
  }
}
