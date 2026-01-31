import 'dart:io';
import 'dart:ui' as ui;

import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:uuid/uuid.dart';

import 'package:minipdfsign/core/errors/failure.dart';
import 'package:minipdfsign/core/errors/failures.dart';

/// Service for converting images to PDF documents.
///
/// Creates A4-sized PDFs with the image centered and scaled to fit
/// while maintaining aspect ratio.
class ImageToPdfService {
  final Uuid _uuid = const Uuid();

  /// A4 page dimensions in points (72 points = 1 inch)
  static const double _a4Width = 595.0; // 210mm
  static const double _a4Height = 842.0; // 297mm

  /// Margin from page edges in points
  static const double _margin = 36.0; // 0.5 inch

  /// Supported image extensions
  static const List<String> supportedExtensions = [
    '.jpg',
    '.jpeg',
    '.png',
    '.gif',
    '.webp',
    '.bmp',
    '.heic',
    '.heif',
    '.tiff',
    '.tif',
  ];

  /// Checks if a file is a supported image based on extension.
  static bool isImageFile(String path) {
    final lowerPath = path.toLowerCase();
    return supportedExtensions.any((ext) => lowerPath.endsWith(ext));
  }

  /// Converts an image file to a single-page A4 PDF.
  ///
  /// The image is centered on the page and scaled to fit within margins
  /// while preserving aspect ratio.
  ///
  /// Returns the path to the generated PDF file in the temp directory.
  Future<Either<Failure, String>> convertImageToPdf(String imagePath) async {
    return convertImagesToPdf([imagePath]);
  }

  /// Converts multiple image files to a multi-page A4 PDF.
  ///
  /// Each image becomes a separate page. Images are centered and scaled
  /// to fit within margins while preserving aspect ratio.
  /// Page order matches the order of images in the list.
  ///
  /// Returns the path to the generated PDF file in the temp directory.
  Future<Either<Failure, String>> convertImagesToPdf(
    List<String> imagePaths,
  ) async {
    if (imagePaths.isEmpty) {
      return Left(
        StorageFailure(message: 'No images provided for conversion'),
      );
    }

    try {
      // Create PDF document with explicit A4 page size
      final pdfDocument = PdfDocument();
      pdfDocument.pageSettings.size = PdfPageSize.a4;

      // Process each image
      for (final imagePath in imagePaths) {
        final imageFile = File(imagePath);
        if (!await imageFile.exists()) {
          // Skip missing files but continue with others
          continue;
        }

        // Read image bytes
        final imageBytes = await imageFile.readAsBytes();

        // Decode image to get dimensions
        final codec = await ui.instantiateImageCodec(imageBytes);
        final frame = await codec.getNextFrame();
        final imageWidth = frame.image.width.toDouble();
        final imageHeight = frame.image.height.toDouble();
        frame.image.dispose();

        // Add A4 page
        final page = pdfDocument.pages.add();

        // Calculate available area (with margins)
        final availableWidth = _a4Width - (2 * _margin);
        final availableHeight = _a4Height - (2 * _margin);

        // Calculate scale to fit image within available area
        final scaleX = availableWidth / imageWidth;
        final scaleY = availableHeight / imageHeight;
        final scale = scaleX < scaleY ? scaleX : scaleY;

        // Calculate scaled dimensions
        final scaledWidth = imageWidth * scale;
        final scaledHeight = imageHeight * scale;

        // Calculate position to center image
        final x = (_a4Width - scaledWidth) / 2;
        final y = (_a4Height - scaledHeight) / 2;

        // Load and draw image
        final pdfImage = PdfBitmap(imageBytes);
        page.graphics.drawImage(
          pdfImage,
          ui.Rect.fromLTWH(x, y, scaledWidth, scaledHeight),
        );
      }

      // Verify at least one page was created
      if (pdfDocument.pages.count == 0) {
        pdfDocument.dispose();
        return Left(
          FileNotFoundFailure(message: 'No valid images found to convert'),
        );
      }

      // Save to temp directory
      final tempDir = await getTemporaryDirectory();
      final outputFileName = '${_uuid.v4()}.pdf';
      final outputPath = '${tempDir.path}/$outputFileName';

      final savedBytes = await pdfDocument.save();
      pdfDocument.dispose();

      final outputFile = File(outputPath);
      await outputFile.writeAsBytes(savedBytes);

      return Right(outputPath);
    } on Exception catch (e) {
      return Left(
        StorageFailure(message: 'Failed to convert images to PDF: $e'),
      );
    }
  }

  /// Saves a PDF to the app's Documents directory.
  ///
  /// Files are saved directly to Documents (not a subfolder) so they're
  /// visible in iOS Files app under "On My iPhone > miniPDFSign".
  ///
  /// If a file with the same name exists, a numbered suffix is added.
  Future<Either<Failure, String>> savePdfToDocuments({
    required String tempPdfPath,
    required String suggestedFileName,
  }) async {
    try {
      final tempFile = File(tempPdfPath);
      if (!await tempFile.exists()) {
        return Left(
          FileNotFoundFailure(message: 'Temp PDF not found: $tempPdfPath'),
        );
      }

      // Get app documents directory (visible in Files app on iOS)
      final docsDir = await getApplicationDocumentsDirectory();

      // Sanitize and ensure .pdf extension
      var fileName = _sanitizeFileName(suggestedFileName);
      if (!fileName.toLowerCase().endsWith('.pdf')) {
        fileName = '$fileName.pdf';
      }

      // Get unique path (adds suffix if file exists)
      final outputPath = await _getUniquePath(docsDir.path, fileName);

      // Copy file to permanent location
      await tempFile.copy(outputPath);

      // Clean up temp file
      try {
        await tempFile.delete();
      } catch (_) {
        // Ignore deletion errors - temp will be cleaned by OS eventually
      }

      return Right(outputPath);
    } on Exception catch (e) {
      return Left(
        StorageFailure(message: 'Failed to save PDF to documents: $e'),
      );
    }
  }

  /// Sanitizes filename by removing invalid characters.
  String _sanitizeFileName(String name) {
    return name
        .replaceAll(RegExp(r'[<>:"/\\|?*]'), '_')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  /// Returns a unique file path, adding (1), (2), etc. if file exists.
  Future<String> _getUniquePath(String dirPath, String fileName) async {
    var path = '$dirPath/$fileName';
    var file = File(path);

    if (!await file.exists()) {
      return path;
    }

    // File exists - add numbered suffix
    final dotIndex = fileName.lastIndexOf('.');
    final nameWithoutExt =
        dotIndex > 0 ? fileName.substring(0, dotIndex) : fileName;
    final ext = dotIndex > 0 ? fileName.substring(dotIndex) : '.pdf';

    var counter = 1;
    while (await file.exists()) {
      path = '$dirPath/$nameWithoutExt ($counter)$ext';
      file = File(path);
      counter++;
    }

    return path;
  }
}
