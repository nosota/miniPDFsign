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
    try {
      final imageFile = File(imagePath);
      if (!await imageFile.exists()) {
        return Left(
          FileNotFoundFailure(message: 'Image file not found: $imagePath'),
        );
      }

      // Read image bytes
      final imageBytes = await imageFile.readAsBytes();

      // Decode image to get dimensions
      final codec = await ui.instantiateImageCodec(imageBytes);
      final frame = await codec.getNextFrame();
      final imageWidth = frame.image.width.toDouble();
      final imageHeight = frame.image.height.toDouble();
      frame.image.dispose();

      // Create PDF document with explicit A4 page size
      final pdfDocument = PdfDocument();
      pdfDocument.pageSettings.size = PdfPageSize.a4;

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
        StorageFailure(message: 'Failed to convert image to PDF: $e'),
      );
    }
  }

  /// Saves a PDF to the app's permanent documents directory.
  ///
  /// This is used when the user wants to save a converted image PDF
  /// so it can be added to Recent Files with a persistent path.
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

      // Get app documents directory
      final docsDir = await getApplicationDocumentsDirectory();
      final pdfDir = Directory('${docsDir.path}/converted_pdfs');

      // Create directory if it doesn't exist
      if (!await pdfDir.exists()) {
        await pdfDir.create(recursive: true);
      }

      // Generate unique filename
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final baseName = suggestedFileName.replaceAll(RegExp(r'\.[^.]+$'), '');
      final outputPath = '${pdfDir.path}/${baseName}_$timestamp.pdf';

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
}
