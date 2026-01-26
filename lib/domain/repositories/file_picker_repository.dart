import 'package:dartz/dartz.dart';
import 'package:minipdfsign/core/errors/failure.dart';

/// Abstract repository for file picking operations.
///
/// Returns Either<Failure, T> for type-safe error handling.
abstract class FilePickerRepository {
  /// Opens native file picker for PDF selection.
  ///
  /// Returns the file path if selected, or null if cancelled.
  Future<Either<Failure, String?>> pickPdfFile();

  /// Checks if a file exists at the given path.
  Future<Either<Failure, bool>> fileExists(String path);

  /// Gets basic file info (size, etc.) for validation.
  Future<Either<Failure, int>> getFileSize(String path);
}
