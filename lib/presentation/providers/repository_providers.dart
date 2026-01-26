import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:minipdfsign/data/repositories/file_picker_repository_impl.dart';
import 'package:minipdfsign/data/repositories/pdf_document_repository_impl.dart';
import 'package:minipdfsign/data/repositories/recent_files_repository_impl.dart';
import 'package:minipdfsign/data/repositories/sidebar_image_repository_impl.dart';
import 'package:minipdfsign/data/services/image_picker_service.dart';
import 'package:minipdfsign/data/services/image_storage_service.dart';
import 'package:minipdfsign/data/services/image_validation_service.dart';
import 'package:minipdfsign/domain/repositories/file_picker_repository.dart';
import 'package:minipdfsign/domain/repositories/pdf_document_repository.dart';
import 'package:minipdfsign/domain/repositories/recent_files_repository.dart';
import 'package:minipdfsign/domain/repositories/sidebar_image_repository.dart';
import 'package:minipdfsign/presentation/providers/data_source_providers.dart';

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

/// Provider for [ImageValidationService].
@Riverpod(keepAlive: true)
ImageValidationService imageValidationService(ImageValidationServiceRef ref) {
  return ImageValidationService();
}

/// Provider for [ImagePickerService].
@Riverpod(keepAlive: true)
ImagePickerService imagePickerService(ImagePickerServiceRef ref) {
  return ImagePickerService();
}
