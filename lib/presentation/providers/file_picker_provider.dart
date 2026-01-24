import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';

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
