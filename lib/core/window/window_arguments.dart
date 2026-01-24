import 'dart:convert';

/// Type of window in the application.
enum WindowType {
  /// Main window showing the welcome screen.
  welcome,

  /// PDF viewer window for displaying a document.
  pdfViewer,

  /// Settings window for app preferences.
  settings,
}

/// Arguments passed between windows.
///
/// Used to communicate window type and file information
/// when creating new windows via desktop_multi_window.
class WindowArguments {
  const WindowArguments({
    required this.windowType,
    this.filePath,
    this.fileName,
  });

  /// Creates arguments for a welcome window.
  factory WindowArguments.welcome() {
    return const WindowArguments(windowType: WindowType.welcome);
  }

  /// Creates arguments for a PDF viewer window.
  factory WindowArguments.pdfViewer({
    required String filePath,
    required String fileName,
  }) {
    return WindowArguments(
      windowType: WindowType.pdfViewer,
      filePath: filePath,
      fileName: fileName,
    );
  }

  /// Creates arguments for a settings window.
  factory WindowArguments.settings() {
    return const WindowArguments(windowType: WindowType.settings);
  }

  /// Creates arguments from a JSON string.
  factory WindowArguments.fromJson(String jsonString) {
    if (jsonString.isEmpty) {
      return WindowArguments.welcome();
    }

    try {
      final map = json.decode(jsonString) as Map<String, dynamic>;
      return WindowArguments(
        windowType: WindowType.values.firstWhere(
          (e) => e.name == map['windowType'],
          orElse: () => WindowType.welcome,
        ),
        filePath: map['filePath'] as String?,
        fileName: map['fileName'] as String?,
      );
    } catch (_) {
      return WindowArguments.welcome();
    }
  }

  /// The type of this window.
  final WindowType windowType;

  /// Path to the PDF file (only for pdfViewer windows).
  final String? filePath;

  /// Name of the PDF file (only for pdfViewer windows).
  final String? fileName;

  /// Converts arguments to a JSON string for passing to new windows.
  String toJson() {
    return json.encode({
      'windowType': windowType.name,
      'filePath': filePath,
      'fileName': fileName,
    });
  }

  @override
  String toString() {
    return 'WindowArguments(windowType: $windowType, filePath: $filePath, '
        'fileName: $fileName)';
  }
}
