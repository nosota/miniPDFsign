import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';

part 'recent_files_provider.g.dart';

/// Provider for managing recent files state.
///
/// Handles loading, adding, removing, and clearing recent files.
/// Uses keepAlive to prevent auto-dispose which can cause state loss
/// between operations and race conditions with SharedPreferences.
@Riverpod(keepAlive: true)
class RecentFiles extends _$RecentFiles {
  @override
  Future<List<RecentFile>> build() async {
    final repository = ref.watch(recentFilesRepositoryProvider);

    // IMPORTANT: Never call cleanupInvalidFiles() during build().
    // Each Flutter engine (Welcome, PDF windows) is a separate process.
    // The static lock doesn't work across processes, so concurrent
    // cleanupInvalidFiles() and addRecentFile() will race and corrupt data.
    //
    // Just read the current files. Cleanup of invalid files happens
    // lazily when user tries to open a file that no longer exists.
    final result = await repository.getRecentFiles();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (files) => files,
    );
  }

  /// Adds a file to recent files and refreshes the list.
  Future<void> addFile(RecentFile file) async {
    final repository = ref.read(recentFilesRepositoryProvider);
    final result = await repository.addRecentFile(file);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) => ref.invalidateSelf(),
    );
  }

  /// Removes a file from recent files.
  Future<void> removeFile(String path) async {
    final repository = ref.read(recentFilesRepositoryProvider);
    final result = await repository.removeRecentFile(path);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) => ref.invalidateSelf(),
    );
  }

  /// Clears all recent files.
  Future<void> clearAll() async {
    final repository = ref.read(recentFilesRepositoryProvider);
    final result = await repository.clearAllRecentFiles();

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) => ref.invalidateSelf(),
    );
  }
}
