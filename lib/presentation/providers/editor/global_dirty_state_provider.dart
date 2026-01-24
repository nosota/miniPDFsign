import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'global_dirty_state_provider.g.dart';

/// Provider for tracking dirty state of all PDF windows across the app.
///
/// This enables Save All functionality to know if any window has unsaved changes.
/// Each PDF window broadcasts its dirty state, and all windows listen and update
/// their local copy of this global state.
@Riverpod(keepAlive: true)
class GlobalDirtyState extends _$GlobalDirtyState {
  @override
  Map<String, bool> build() {
    return {};
  }

  /// Updates the dirty state for a specific window.
  ///
  /// Called when receiving a dirty state broadcast from another window,
  /// or when the current window's dirty state changes.
  void updateWindowState(String windowId, bool isDirty) {
    state = {...state, windowId: isDirty};
  }

  /// Removes a window from tracking (when it closes).
  void removeWindow(String windowId) {
    final newState = Map<String, bool>.from(state);
    newState.remove(windowId);
    state = newState;
  }

  /// Clears all tracked window states.
  ///
  /// Used when requesting fresh state from all windows.
  void clear() {
    state = {};
  }

  /// Returns true if any tracked window has unsaved changes.
  bool get hasAnyDirtyWindow => state.values.any((isDirty) => isDirty);

  /// Returns the dirty state for a specific window.
  bool? getWindowState(String windowId) => state[windowId];
}
