import 'package:equatable/equatable.dart';

/// Type of application window.
enum WindowType {
  /// Main Welcome window (window ID "0").
  welcome,

  /// PDF viewer window.
  pdf,

  /// Settings window.
  settings,
}

/// Information about an open application window.
///
/// Used in the Window menu to display list of open windows
/// with checkmark on the currently focused one.
class WindowInfo extends Equatable {
  const WindowInfo({
    required this.windowId,
    required this.title,
    required this.type,
    required this.isKey,
    this.filePath,
  });

  /// Unique window identifier from desktop_multi_window.
  final String windowId;

  /// Display title for the window (filename for PDF, "Settings" for settings).
  final String title;

  /// Type of window (welcome, pdf, settings).
  final WindowType type;

  /// Whether this window is currently the key (focused) window.
  final bool isKey;

  /// File path for PDF windows, null for other window types.
  final String? filePath;

  /// Creates WindowInfo from native map data.
  factory WindowInfo.fromMap(Map<dynamic, dynamic> map) {
    final typeString = map['type'] as String? ?? 'pdf';
    final type = switch (typeString) {
      'welcome' => WindowType.welcome,
      'settings' => WindowType.settings,
      _ => WindowType.pdf,
    };

    return WindowInfo(
      windowId: map['windowId'] as String? ?? '',
      title: map['title'] as String? ?? '',
      type: type,
      isKey: map['isKey'] as bool? ?? false,
      filePath: map['filePath'] as String?,
    );
  }

  @override
  List<Object?> get props => [windowId, title, type, isKey, filePath];
}
