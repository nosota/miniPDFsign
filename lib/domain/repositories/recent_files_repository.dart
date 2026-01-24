import 'package:dartz/dartz.dart';
import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';

/// Abstract repository for recent files operations.
///
/// Returns Either<Failure, T> for type-safe error handling.
abstract class RecentFilesRepository {
  /// Gets list of recent files (max 10, ordered by lastOpened desc).
  Future<Either<Failure, List<RecentFile>>> getRecentFiles();

  /// Adds or updates a recent file entry.
  ///
  /// If a file with the same path exists, it will be moved to the top.
  Future<Either<Failure, Unit>> addRecentFile(RecentFile file);

  /// Removes a specific recent file by path.
  Future<Either<Failure, Unit>> removeRecentFile(String path);

  /// Clears all recent files.
  Future<Either<Failure, Unit>> clearAllRecentFiles();

  /// Validates files and removes entries for non-existent files.
  ///
  /// Should be called on app startup.
  Future<Either<Failure, List<RecentFile>>> cleanupInvalidFiles();
}
