import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pdfsign/data/repositories/file_picker_repository_impl.dart';
import 'package:pdfsign/data/repositories/pdf_document_repository_impl.dart';
import 'package:pdfsign/data/repositories/recent_files_repository_impl.dart';
import 'package:pdfsign/data/repositories/sidebar_image_repository_impl.dart';
import 'package:pdfsign/data/services/image_storage_service.dart';
import 'package:pdfsign/domain/repositories/file_picker_repository.dart';
import 'package:pdfsign/domain/repositories/pdf_document_repository.dart';
import 'package:pdfsign/domain/repositories/recent_files_repository.dart';
import 'package:pdfsign/domain/repositories/sidebar_image_repository.dart';
import 'package:pdfsign/presentation/providers/data_source_providers.dart';

part 'repository_providers.g.dart';

/// Provider for [ImageStorageService].
@Riverpod(keepAlive: true)
ImageStorageService imageStorageService(ImageStorageServiceRef ref) {
  return ImageStorageService();
}

/// Provider for [RecentFilesRepository].
///
/// Uses keepAlive to ensure the repository instance persists for the
/// entire app lifecycle. This is important because FileOpenHandler
/// captures a reference to the repository at init time.
@Riverpod(keepAlive: true)
RecentFilesRepository recentFilesRepository(RecentFilesRepositoryRef ref) {
  final dataSource = ref.watch(recentFilesLocalDataSourceProvider);
  return RecentFilesRepositoryImpl(dataSource);
}

/// Provider for [FilePickerRepository].
@riverpod
FilePickerRepository filePickerRepository(FilePickerRepositoryRef ref) {
  final dataSource = ref.watch(filePickerDataSourceProvider);
  return FilePickerRepositoryImpl(dataSource);
}

/// Provider for [PdfDocumentRepository].
///
/// Maintains the PDF document repository for the app lifecycle.
@Riverpod(keepAlive: true)
PdfDocumentRepository pdfDocumentRepository(PdfDocumentRepositoryRef ref) {
  final dataSource = ref.watch(pdfDataSourceProvider);
  return PdfDocumentRepositoryImpl(dataSource: dataSource);
}

/// Provider for [SidebarImageRepository].
///
/// Maintains sidebar images with multi-window sync via Isar.
@Riverpod(keepAlive: true)
SidebarImageRepository sidebarImageRepository(SidebarImageRepositoryRef ref) {
  final dataSource = ref.watch(sidebarImageLocalDataSourceProvider);
  final storageService = ref.watch(imageStorageServiceProvider);
  return SidebarImageRepositoryImpl(dataSource, storageService);
}
