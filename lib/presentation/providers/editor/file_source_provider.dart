import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'file_source_provider.g.dart';

/// Identifies where the current PDF file was opened from.
///
/// This determines the save behavior:
/// - [filesApp]: File opened via iOS Files app "Open In" → overwrite original
/// - [filePicker]: File selected via in-app picker → use Share Sheet
/// - [recentFile]: File opened from recent files list → use Share Sheet
/// - [convertedImage]: Image converted to PDF → save to Documents, add to Recent
enum FileSourceType {
  /// iOS Files app "Open In" - can overwrite original file.
  filesApp,

  /// In-app file picker - use Share Sheet for saving.
  filePicker,

  /// Recent files list - use Share Sheet for saving.
  recentFile,

  /// Image converted to PDF on-the-fly.
  /// Always shows save dialog on close, saves to app Documents.
  convertedImage,
}

/// Provider for tracking the source of the currently opened PDF file.
///
/// Uses keepAlive to persist state throughout the viewing session.
@Riverpod(keepAlive: true)
class FileSource extends _$FileSource {
  @override
  FileSourceType build() => FileSourceType.filePicker;

  /// Set source to Files app (iOS "Open In").
  void setFilesApp() => state = FileSourceType.filesApp;

  /// Set source to in-app file picker.
  void setFilePicker() => state = FileSourceType.filePicker;

  /// Set source to recent files list.
  void setRecentFile() => state = FileSourceType.recentFile;

  /// Set source to converted image (image → PDF).
  void setConvertedImage() => state = FileSourceType.convertedImage;

  /// Whether the file can be overwritten in place.
  bool get canOverwrite => state == FileSourceType.filesApp;

  /// Whether this is a converted image that needs special save handling.
  bool get isConvertedImage => state == FileSourceType.convertedImage;
}
