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

  /// Opens native file picker for PDF or image selection.
  ///
  /// Returns [PickedFile] with path and type, or null if cancelled.
  Future<Either<Failure, PickedFile?>> pickPdfOrImage();

  /// Checks if a file exists at the given path.
  Future<Either<Failure, bool>> fileExists(String path);

  /// Gets basic file info (size, etc.) for validation.
  Future<Either<Failure, int>> getFileSize(String path);
}
