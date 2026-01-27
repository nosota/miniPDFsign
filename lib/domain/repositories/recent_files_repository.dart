import 'package:dartz/dartz.dart';
import 'package:minipdfsign/core/errors/failure.dart';
import 'package:minipdfsign/domain/entities/recent_file.dart';

/// Abstract repository for recent files operations.
///
/// Returns Either<Failure, T> for type-safe error handling.
abstract class RecentFilesRepository {
  /// Gets list of recent files (max 10, ordered by lastOpened desc).
  Future<Either<Failure, List<RecentFile>>> getRecentFiles();

  /// Adds or updates a recent file entry.
  ///
  /// If a file with the same path exists, it will be moved to the top.
  /// Creates a security-scoped bookmark for persistent access.
  Future<Either<Failure, Unit>> addRecentFile(RecentFile file);

  /// Removes a specific recent file by path.
  Future<Either<Failure, Unit>> removeRecentFile(String path);

  /// Clears all recent files.
  Future<Either<Failure, Unit>> clearAllRecentFiles();

  /// Validates files and removes entries for non-existent files.
  ///
  /// Should be called on app startup. Uses bookmarks to verify access.
  Future<Either<Failure, List<RecentFile>>> cleanupInvalidFiles();

  /// Opens a recent file using its security-scoped bookmark.
  ///
  /// Returns the resolved file path if access was granted,
  /// or a failure if the file is no longer accessible.
  ///
  /// On iOS: Resolves bookmark and calls startAccessingSecurityScopedResource.
  /// On Android: Resolves persistable URI and verifies permission.
  Future<Either<Failure, String>> openRecentFile(RecentFile file);

  /// Releases access to a previously opened file.
  ///
  /// Should be called when done with the file to release resources.
  /// On iOS: Calls stopAccessingSecurityScopedResource.
  /// On Android: No-op.
  Future<void> closeRecentFile(String filePath);
}
