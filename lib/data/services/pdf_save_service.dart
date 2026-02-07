import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' show Rect;

import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:uuid/uuid.dart';

import 'package:minipdfsign/core/errors/failure.dart';
import 'package:minipdfsign/core/errors/failures.dart';
import 'package:minipdfsign/domain/entities/placed_image.dart';

/// Service for saving PDFs with placed images embedded.
///
/// Password-protected PDFs are exported **without** re-encryption.
/// The user has already authenticated by entering the password, so
/// the exported content is decrypted. This also ensures compatibility
/// with printers and other share targets that cannot handle passwords.
class PdfSaveService {
  final Uuid _uuid = const Uuid();

  /// Saves the PDF with all placed images embedded.
  ///
  /// [originalPath] - Path to the original PDF file.
  /// [placedImages] - List of images to embed.
  /// [outputPath] - Where to save (if null, overwrites original).
  /// [password] - Password to open an encrypted source file.
  ///   Used only for decryption; the output is always unencrypted.
  Future<Either<Failure, String>> savePdf({
    required String originalPath,
    required List<PlacedImage> placedImages,
    String? outputPath,
    String? password,
  }) async {
    try {
      final originalFile = File(originalPath);
      if (!await originalFile.exists()) {
        return Left(FileNotFoundFailure(
          message: 'Original PDF not found: $originalPath',
        ));
      }

      final originalBytes = await originalFile.readAsBytes();
      final pdfDocument = password != null
          ? PdfDocument(inputBytes: originalBytes, password: password)
          : PdfDocument(inputBytes: originalBytes);

      final Uint8List savedBytes;
      try {
        // Strip encryption so the output is always unencrypted.
        if (password != null) {
          pdfDocument.security.userPassword = '';
          pdfDocument.security.ownerPassword = '';
        }

        await _embedImages(pdfDocument, placedImages);
        savedBytes = Uint8List.fromList(await pdfDocument.save());
      } finally {
        pdfDocument.dispose();
      }

      final savePath = outputPath ?? originalPath;
      await File(savePath).writeAsBytes(savedBytes);

      return Right(savePath);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to save PDF: $e'));
    }
  }

  /// Saves the PDF with all placed images embedded.
  /// Uses provided original bytes instead of reading from disk.
  ///
  /// [originalBytes] are expected to be already decrypted (from
  /// [OriginalPdfStorage]). The output is always unencrypted.
  Future<Either<Failure, String>> savePdfFromBytes({
    required Uint8List originalBytes,
    required List<PlacedImage> placedImages,
    required String outputPath,
  }) async {
    try {
      // originalBytes from OriginalPdfStorage are already decrypted,
      // so no password is needed to open them.
      final pdfDocument = PdfDocument(inputBytes: originalBytes);

      final Uint8List savedBytes;
      try {
        await _embedImages(pdfDocument, placedImages);
        savedBytes = Uint8List.fromList(await pdfDocument.save());
      } finally {
        pdfDocument.dispose();
      }

      final outputFile = File(outputPath);
      await outputFile.writeAsBytes(savedBytes);

      return Right(outputPath);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to save PDF: $e'));
    }
  }

  /// Creates a temporary copy of the PDF with images embedded using bytes.
  /// Used for sharing.
  Future<Either<Failure, String>> createTempPdfWithImagesFromBytes({
    required Uint8List originalBytes,
    required List<PlacedImage> placedImages,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/${_uuid.v4()}.pdf';

      return await savePdfFromBytes(
        originalBytes: originalBytes,
        placedImages: placedImages,
        outputPath: tempPath,
      );
    } catch (e) {
      return Left(
        StorageFailure(message: 'Failed to create temp PDF: $e'),
      );
    }
  }

  /// Creates a temporary copy of the PDF with images embedded.
  /// Used for sharing.
  Future<Either<Failure, String>> createTempPdfWithImages({
    required String originalPath,
    required List<PlacedImage> placedImages,
    String? password,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/${_uuid.v4()}.pdf';

      return await savePdf(
        originalPath: originalPath,
        placedImages: placedImages,
        outputPath: tempPath,
        password: password,
      );
    } catch (e) {
      return Left(
        StorageFailure(message: 'Failed to create temp PDF: $e'),
      );
    }
  }

  /// Embeds placed images onto the pages of [pdfDocument].
  Future<void> _embedImages(
    PdfDocument pdfDocument,
    List<PlacedImage> placedImages,
  ) async {
    final imagesByPage = <int, List<PlacedImage>>{};
    for (final image in placedImages) {
      imagesByPage.putIfAbsent(image.pageIndex, () => []);
      imagesByPage[image.pageIndex]!.add(image);
    }

    for (final entry in imagesByPage.entries) {
      final pageIndex = entry.key;
      final pageImages = entry.value;

      if (pageIndex >= pdfDocument.pages.count) continue;

      final page = pdfDocument.pages[pageIndex];
      final graphics = page.graphics;

      for (final placedImage in pageImages) {
        final imageFile = File(placedImage.imagePath);
        if (!await imageFile.exists()) continue;

        final imageBytes = await imageFile.readAsBytes();
        final pdfImage = PdfBitmap(imageBytes);

        graphics.save();

        final centerX =
            placedImage.position.dx + placedImage.size.width / 2;
        final centerY =
            placedImage.position.dy + placedImage.size.height / 2;

        if (placedImage.rotation != 0) {
          graphics.translateTransform(centerX, centerY);
          graphics.rotateTransform(
            _radiansToDegrees(placedImage.rotation),
          );
          graphics.translateTransform(-centerX, -centerY);
        }

        graphics.drawImage(
          pdfImage,
          Rect.fromLTWH(
            placedImage.position.dx,
            placedImage.position.dy,
            placedImage.size.width,
            placedImage.size.height,
          ),
        );

        graphics.restore();
      }
    }
  }

  double _radiansToDegrees(double radians) {
    return radians * (180 / 3.141592653589793);
  }
}
