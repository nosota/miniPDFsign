import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:minipdfsign/core/constants/app_constants.dart';
import 'package:minipdfsign/core/errors/failure.dart';
import 'package:minipdfsign/core/errors/failures.dart';
import 'package:minipdfsign/core/utils/logger.dart';
import 'package:minipdfsign/data/datasources/recent_files_local_data_source.dart';
import 'package:minipdfsign/data/models/recent_file_model.dart';
import 'package:minipdfsign/data/services/file_bookmark_service.dart';
import 'package:minipdfsign/domain/entities/recent_file.dart';
import 'package:minipdfsign/domain/repositories/recent_files_repository.dart';

/// Simple async lock for serializing operations.
///
/// Uses a queue-based approach where each operation waits for the
/// previous one to complete before starting.
class _AsyncLock {
  Future<void>? _last;

  /// Executes [fn] after all previously queued operations complete.
  Future<T> synchronized<T>(Future<T> Function() fn) async {
    final previous = _last;
    final completer = Completer<void>();
    _last = completer.future;

    if (previous != null) {
      await previous;
    }

    try {
      return await fn();
    } finally {
      completer.complete();
    }
  }
}

/// Concrete implementation of [RecentFilesRepository].
///
/// Uses a static lock to serialize all write operations across all instances.
/// This prevents race conditions when multiple files are opened simultaneously.
class RecentFilesRepositoryImpl implements RecentFilesRepository {
  final RecentFilesLocalDataSource _localDataSource;
  final FileBookmarkService _bookmarkService;

  /// Static lock shared by all repository instances.
  ///
  /// Ensures that read-modify-write operations in [addRecentFile],
  /// [removeRecentFile], and [cleanupInvalidFiles] don't overlap.
  static final _lock = _AsyncLock();

  RecentFilesRepositoryImpl(this._localDataSource, this._bookmarkService);

  @override
  Future<Either<Failure, List<RecentFile>>> getRecentFiles() async {
    try {
      final models = await _localDataSource.getRecentFiles();
      final entities = models.map((m) => m.toEntity()).toList();

      // Sort by lastOpened descending
      entities.sort((a, b) => b.lastOpened.compareTo(a.lastOpened));

      // Ensure we don't exceed max files
      final trimmed = entities.take(AppConstants.maxRecentFiles).toList();

      return Right(trimmed);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to load recent files: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> addRecentFile(RecentFile file) async {
    // Use lock to serialize read-modify-write operations
    return _lock.synchronized(() async {
      try {
        final models = await _localDataSource.getRecentFiles();

        // Remove existing entry for same path (will be re-added at top)
        models.removeWhere((m) => m.path == file.path);

        // Create security-scoped bookmark for persistent access
        String? bookmarkData = file.bookmarkData;
        if (bookmarkData == null) {
          bookmarkData = await _bookmarkService.createBookmark(file.path);
          if (bookmarkData != null) {
            AppLogger.debug('Created bookmark for: ${file.path}');
          } else {
            AppLogger.warning('Failed to create bookmark for: ${file.path}');
          }
        }

        // Create file with bookmark data
        final fileWithBookmark = file.copyWith(bookmarkData: bookmarkData);

        // Add new entry at the beginning
        models.insert(0, RecentFileModel.fromEntity(fileWithBookmark));

        // Keep only max entries
        final trimmed = models.take(AppConstants.maxRecentFiles).toList();

        await _localDataSource.saveRecentFiles(trimmed);

        return const Right(unit);
      } catch (e) {
        return Left(StorageFailure(message: 'Failed to save recent file: $e'));
      }
    });
  }

  @override
  Future<Either<Failure, Unit>> removeRecentFile(String path) async {
    // Use lock to serialize read-modify-write operations
    return _lock.synchronized(() async {
      try {
        final models = await _localDataSource.getRecentFiles();

        models.removeWhere((m) => m.path == path);

        await _localDataSource.saveRecentFiles(models);

        return const Right(unit);
      } catch (e) {
        return Left(StorageFailure(message: 'Failed to remove recent file: $e'));
      }
    });
  }

  @override
  Future<Either<Failure, Unit>> clearAllRecentFiles() async {
    // Use lock to prevent race conditions with addRecentFile/removeRecentFile.
    // Without lock, clear could run concurrently and overwrite newly added files.
    return _lock.synchronized(() async {
      try {
        await _localDataSource.clearRecentFiles();
        return const Right(unit);
      } catch (e) {
        return Left(StorageFailure(message: 'Failed to clear recent files: $e'));
      }
    });
  }

  @override
  Future<Either<Failure, List<RecentFile>>> cleanupInvalidFiles() async {
    // Use lock to serialize read-modify-write operations
    return _lock.synchronized(() async {
      try {
        final models = await _localDataSource.getRecentFiles();
        final validModels = <RecentFileModel>[];

        for (final model in models) {
          bool isValid = false;

          // First try using bookmark if available
          if (model.bookmarkData != null) {
            isValid = !await _bookmarkService.isBookmarkStale(model.bookmarkData!);
          }

          // Fallback to file existence check
          if (!isValid) {
            final file = File(model.path);
            isValid = await file.exists();
          }

          if (isValid) {
            validModels.add(model);
          } else {
            AppLogger.debug('Removing invalid recent file: ${model.path}');
          }
        }

        // Save cleaned up list
        await _localDataSource.saveRecentFiles(validModels);

        final entities = validModels.map((m) => m.toEntity()).toList();
        return Right(entities);
      } catch (e) {
        return Left(StorageFailure(message: 'Failed to cleanup files: $e'));
      }
    });
  }

  @override
  Future<Either<Failure, String>> openRecentFile(RecentFile file) async {
    try {
      // If we have a bookmark, use it
      if (file.bookmarkData != null) {
        final resolvedPath = await _bookmarkService.openWithBookmark(file.bookmarkData!);
        if (resolvedPath != null) {
          AppLogger.debug('Opened file via bookmark: $resolvedPath');
          return Right(resolvedPath);
        }
        // Bookmark failed, fall through to try direct path
        AppLogger.warning('Bookmark resolution failed, trying direct path');
      }

      // Try direct file access as fallback
      final fileObj = File(file.path);
      if (await fileObj.exists()) {
        AppLogger.debug('Opened file directly: ${file.path}');
        return Right(file.path);
      }

      return Left(StorageFailure(
        message: 'File no longer accessible: ${file.fileName}',
      ));
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to open file: $e'));
    }
  }

  @override
  Future<void> closeRecentFile(String filePath) async {
    await _bookmarkService.stopAccessing(filePath);
  }
}
