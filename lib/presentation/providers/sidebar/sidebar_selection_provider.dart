import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sidebar_selection_provider.g.dart';

/// Provider for the currently selected image in the sidebar.
///
/// Stores the ID of the selected image, or null if none is selected.
/// Selection is local to each window (not synced).
@riverpod
class SidebarSelection extends _$SidebarSelection {
  @override
  String? build() => null;

  /// Selects an image by its ID.
  void select(String imageId) {
    state = imageId;
  }

  /// Clears the current selection.
  void clear() {
    state = null;
  }

  /// Toggles selection for an image.
  ///
  /// If the image is already selected, deselects it.
  /// Otherwise, selects it.
  void toggle(String imageId) {
    if (state == imageId) {
      state = null;
    } else {
      state = imageId;
    }
  }
}
