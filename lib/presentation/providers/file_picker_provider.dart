import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:minipdfsign/domain/repositories/file_picker_repository.dart';
import 'package:minipdfsign/presentation/providers/repository_providers.dart';

part 'file_picker_provider.g.dart';

/// Provider for file picking operations.
///
/// Handles opening the native file picker and returning selected file path.
@riverpod
class PdfFilePicker extends _$PdfFilePicker {
  @override
  String? build() => null;

  /// Opens file picker and returns selected PDF file path.
  ///
  /// Returns null if user cancelled the picker.
  /// Throws exception if there was an error.
  Future<String?> pickPdf() async {
    final repository = ref.read(filePickerRepositoryProvider);
    final result = await repository.pickPdfFile();

    return result.fold(
      (failure) => throw Exception(failure.message),
      (path) {
        state = path;
        return path;
      },
    );
  }

  /// Opens file picker for PDF or image selection (single file).
  ///
  /// Returns [PickedFile] with path and type info, or null if cancelled.
  /// Throws exception if there was an error.
  Future<PickedFile?> pickPdfOrImage() async {
    final repository = ref.read(filePickerRepositoryProvider);
    final result = await repository.pickPdfOrImage();

    return result.fold(
      (failure) => throw Exception(failure.message),
      (pickedFile) {
        state = pickedFile?.path;
        return pickedFile;
      },
    );
  }

  /// Opens file picker for PDF or image selection (multiple files).
  ///
  /// Returns list of [PickedFile] with path and type info. Empty list if cancelled.
  /// Throws exception if there was an error.
  Future<List<PickedFile>> pickPdfOrImages() async {
    final repository = ref.read(filePickerRepositoryProvider);
    final result = await repository.pickPdfOrImages();

    return result.fold(
      (failure) => throw Exception(failure.message),
      (pickedFiles) {
        state = pickedFiles.isNotEmpty ? pickedFiles.first.path : null;
        return pickedFiles;
      },
    );
  }

  /// Checks if a file exists at the given path.
  Future<bool> fileExists(String path) async {
    final repository = ref.read(filePickerRepositoryProvider);
    final result = await repository.fileExists(path);

    return result.fold(
      (failure) => false,
      (exists) => exists,
    );
  }

  /// Clears the selected file state.
  void clear() {
    state = null;
  }
}
