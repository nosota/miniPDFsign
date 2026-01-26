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
class PdfSaveService {
  final Uuid _uuid = const Uuid();

  /// Saves the PDF with all placed images embedded.
  ///
  /// [originalPath] - Path to the original PDF file
  /// [placedImages] - List of images to embed
  /// [outputPath] - Where to save (if null, overwrites original)
  Future<Either<Failure, String>> savePdf({
    required String originalPath,
    required List<PlacedImage> placedImages,
    String? outputPath,
  }) async {
    try {
      // Read the original PDF
      final originalFile = File(originalPath);
      if (!await originalFile.exists()) {
        return Left(FileNotFoundFailure(message: 'Original PDF not found: $originalPath'));
      }

      final originalBytes = await originalFile.readAsBytes();
      final pdfDocument = PdfDocument(inputBytes: originalBytes);

      // Group images by page
      final imagesByPage = <int, List<PlacedImage>>{};
      for (final image in placedImages) {
        imagesByPage.putIfAbsent(image.pageIndex, () => []);
        imagesByPage[image.pageIndex]!.add(image);
      }

      // Embed images on each page
      for (final entry in imagesByPage.entries) {
        final pageIndex = entry.key;
        final pageImages = entry.value;

        if (pageIndex >= pdfDocument.pages.count) continue;

        final page = pdfDocument.pages[pageIndex];
        final graphics = page.graphics;

        for (final placedImage in pageImages) {
          // Load the image file
          final imageFile = File(placedImage.imagePath);
          if (!await imageFile.exists()) continue;

          final imageBytes = await imageFile.readAsBytes();
          final pdfImage = PdfBitmap(imageBytes);

          // Save graphics state for rotation
          graphics.save();

          // Calculate center point for rotation
          final centerX = placedImage.position.dx + placedImage.size.width / 2;
          final centerY = placedImage.position.dy + placedImage.size.height / 2;

          // Apply rotation around center
          if (placedImage.rotation != 0) {
            graphics.translateTransform(centerX, centerY);
            graphics.rotateTransform(_radiansToDegrees(placedImage.rotation));
            graphics.translateTransform(-centerX, -centerY);
          }

          // Draw the image
          graphics.drawImage(
            pdfImage,
            Rect.fromLTWH(
              placedImage.position.dx,
              placedImage.position.dy,
              placedImage.size.width,
              placedImage.size.height,
            ),
          );

          // Restore graphics state
          graphics.restore();
        }
      }

      // Save to output path
      final savePath = outputPath ?? originalPath;
      final savedBytes = await pdfDocument.save();
      pdfDocument.dispose();

      // Write to file
      final outputFile = File(savePath);
      await outputFile.writeAsBytes(savedBytes);

      return Right(savePath);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to save PDF: $e'));
    }
  }

  /// Saves the PDF with all placed images embedded.
  /// Uses provided original bytes instead of reading from disk.
  ///
  /// [originalBytes] - The original PDF bytes (without embedded images)
  /// [placedImages] - List of images to embed
  /// [outputPath] - Where to save the file
  Future<Either<Failure, String>> savePdfFromBytes({
    required Uint8List originalBytes,
    required List<PlacedImage> placedImages,
    required String outputPath,
  }) async {
    try {
      final pdfDocument = PdfDocument(inputBytes: originalBytes);

      // Group images by page
      final imagesByPage = <int, List<PlacedImage>>{};
      for (final image in placedImages) {
        imagesByPage.putIfAbsent(image.pageIndex, () => []);
        imagesByPage[image.pageIndex]!.add(image);
      }

      // Embed images on each page
      for (final entry in imagesByPage.entries) {
        final pageIndex = entry.key;
        final pageImages = entry.value;

        if (pageIndex >= pdfDocument.pages.count) continue;

        final page = pdfDocument.pages[pageIndex];
        final graphics = page.graphics;

        for (final placedImage in pageImages) {
          // Load the image file
          final imageFile = File(placedImage.imagePath);
          if (!await imageFile.exists()) continue;

          final imageBytes = await imageFile.readAsBytes();
          final pdfImage = PdfBitmap(imageBytes);

          // Save graphics state for rotation
          graphics.save();

          // Calculate center point for rotation
          final centerX = placedImage.position.dx + placedImage.size.width / 2;
          final centerY = placedImage.position.dy + placedImage.size.height / 2;

          // Apply rotation around center
          if (placedImage.rotation != 0) {
            graphics.translateTransform(centerX, centerY);
            graphics.rotateTransform(_radiansToDegrees(placedImage.rotation));
            graphics.translateTransform(-centerX, -centerY);
          }

          // Draw the image
          graphics.drawImage(
            pdfImage,
            Rect.fromLTWH(
              placedImage.position.dx,
              placedImage.position.dy,
              placedImage.size.width,
              placedImage.size.height,
            ),
          );

          // Restore graphics state
          graphics.restore();
        }
      }

      // Save to output path
      final savedBytes = await pdfDocument.save();
      pdfDocument.dispose();

      // Write to file
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

      final result = await savePdfFromBytes(
        originalBytes: originalBytes,
        placedImages: placedImages,
        outputPath: tempPath,
      );

      return result;
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to create temp PDF: $e'));
    }
  }

  /// Creates a temporary copy of the PDF with images embedded.
  /// Used for sharing.
  Future<Either<Failure, String>> createTempPdfWithImages({
    required String originalPath,
    required List<PlacedImage> placedImages,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/${_uuid.v4()}.pdf';

      final result = await savePdf(
        originalPath: originalPath,
        placedImages: placedImages,
        outputPath: tempPath,
      );

      return result;
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to create temp PDF: $e'));
    }
  }

  double _radiansToDegrees(double radians) {
    return radians * (180 / 3.141592653589793);
  }
}
