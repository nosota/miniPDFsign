import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:minipdfsign/data/datasources/file_picker_data_source.dart';
import 'package:minipdfsign/data/datasources/pdf_data_source.dart';
import 'package:minipdfsign/data/datasources/recent_files_local_data_source.dart';
import 'package:minipdfsign/data/datasources/sidebar_image_local_data_source.dart';
import 'package:minipdfsign/presentation/providers/shared_preferences_provider.dart';

part 'data_source_providers.g.dart';

/// Provider for [Isar] database instance.
///
/// Must be overridden in main.dart with a pre-initialized Isar instance.
/// Throws if accessed without override.
@Riverpod(keepAlive: true)
Isar isar(IsarRef ref) {
  throw UnimplementedError(
    'isarProvider must be overridden with a pre-initialized Isar instance',
  );
}

/// Provider for [RecentFilesLocalDataSource].
///
/// Uses keepAlive to ensure the data source persists for the entire
/// app lifecycle, matching the repository's lifecycle.
@Riverpod(keepAlive: true)
RecentFilesLocalDataSource recentFilesLocalDataSource(
  RecentFilesLocalDataSourceRef ref,
) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return RecentFilesLocalDataSourceImpl(prefs);
}

/// Provider for [FilePickerDataSource].
@riverpod
FilePickerDataSource filePickerDataSource(FilePickerDataSourceRef ref) {
  return FilePickerDataSourceImpl();
}

/// Provider for [PdfDataSource].
///
/// This provider maintains state across the app lifecycle to keep
/// the PDF document loaded while the user is working with it.
@Riverpod(keepAlive: true)
PdfDataSource pdfDataSource(PdfDataSourceRef ref) {
  final dataSource = PdfDataSourceImpl();
  ref.onDispose(() async {
    await dataSource.closeDocument();
  });
  return dataSource;
}

/// Provider for [SidebarImageLocalDataSource].
///
/// Uses Isar for persistent storage with real-time multi-window sync.
@Riverpod(keepAlive: true)
SidebarImageLocalDataSource sidebarImageLocalDataSource(
  SidebarImageLocalDataSourceRef ref,
) {
  final db = ref.watch(isarProvider);
  return SidebarImageLocalDataSourceImpl(db);
}
