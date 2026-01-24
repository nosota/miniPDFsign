/// Application-wide constants.
abstract final class AppConstants {
  /// Maximum number of recent files to store.
  static const int maxRecentFiles = 12;

  /// SharedPreferences key for storing recent files.
  static const String recentFilesKey = 'recent_files';

  /// SharedPreferences key for paste preferences.
  static const String dontAskPasteAgainKey = 'dont_ask_paste_again';

  /// SharedPreferences key for default paste tab.
  static const String pasteDefaultTabKey = 'paste_default_tab';

  /// Maximum allowed image file size in bytes (100MB).
  static const int maxImageFileSize = 100 * 1024 * 1024;

  /// Maximum allowed image resolution (4096x4096).
  static const int maxImageResolution = 4096;

  /// Default undo/redo history depth.
  static const int undoRedoHistoryDepth = 50;
}
