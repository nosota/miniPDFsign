import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pdfsign/core/constants/app_constants.dart';
import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/core/errors/failures.dart';
import 'package:pdfsign/data/datasources/recent_files_local_data_source.dart';
import 'package:pdfsign/data/models/recent_file_model.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';
import 'package:pdfsign/domain/repositories/recent_files_repository.dart';

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

  /// Static lock shared by all repository instances.
  ///
  /// Ensures that read-modify-write operations in [addRecentFile],
  /// [removeRecentFile], and [cleanupInvalidFiles] don't overlap.
  static final _lock = _AsyncLock();

  RecentFilesRepositoryImpl(this._localDataSource);

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

        // Add new entry at the beginning
        models.insert(0, RecentFileModel.fromEntity(file));

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
          final file = File(model.path);
          if (await file.exists()) {
            validModels.add(model);
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
}
