import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'editor_selection_provider.g.dart';

/// Provider for tracking the currently selected placed image.
///
/// Only one image can be selected at a time.
@riverpod
class EditorSelection extends _$EditorSelection {
  @override
  String? build() {
    return null;
  }

  /// Selects an image by its ID.
  void select(String id) {
    state = id;
  }

  /// Clears the selection.
  void clear() {
    state = null;
  }

  /// Toggles selection for an image.
  void toggle(String id) {
    if (state == id) {
      state = null;
    } else {
      state = id;
    }
  }

  /// Checks if a specific image is selected.
  bool isSelected(String id) => state == id;
}
