import 'package:dartz/dartz.dart';
import 'package:minipdfsign/core/errors/failure.dart';

/// Result of picking a file that can be PDF or image.
class PickedFile {
  const PickedFile({
    required this.path,
    required this.isPdf,
  });

  /// Path to the selected file.
  final String path;

  /// Whether the file is a PDF (true) or an image (false).
  final bool isPdf;
}

/// Abstract repository for file picking operations.
///
/// Returns Either<Failure, T> for type-safe error handling.
abstract class FilePickerRepository {
  /// Opens native file picker for PDF selection.
  ///
  /// Returns the file path if selected, or null if cancelled.
  Future<Either<Failure, String?>> pickPdfFile();

  /// Opens native file picker for PDF or image selection (single file).
  ///
  /// Returns [PickedFile] with path and type, or null if cancelled.
  Future<Either<Failure, PickedFile?>> pickPdfOrImage();

  /// Opens native file picker for PDF or image selection (multiple files).
  ///
  /// Returns list of [PickedFile] with path and type. Empty list if cancelled.
  /// When multiple images are selected, they will be converted to a multi-page PDF.
  Future<Either<Failure, List<PickedFile>>> pickPdfOrImages();

  /// Checks if a file exists at the given path.
  Future<Either<Failure, bool>> fileExists(String path);

  /// Gets basic file info (size, etc.) for validation.
  Future<Either<Failure, int>> getFileSize(String path);
}
