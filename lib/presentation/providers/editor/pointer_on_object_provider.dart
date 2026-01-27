import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for tracking which pointers are currently touching placed objects.
///
/// Maps pointer ID to object ID. Used for hit-test based gesture routing
/// to determine whether PDF or object should handle multi-touch gestures.
final pointerOnObjectProvider =
    StateNotifierProvider<PointerOnObjectNotifier, Map<int, String>>(
  (ref) => PointerOnObjectNotifier(),
);

/// Notifier for pointer-to-object mapping.
class PointerOnObjectNotifier extends StateNotifier<Map<int, String>> {
  PointerOnObjectNotifier() : super({});

  /// Records that a pointer is touching an object.
  void pointerDown(int pointerId, String objectId) {
    state = {...state, pointerId: objectId};
  }

  /// Removes pointer tracking when finger is lifted.
  void pointerUp(int pointerId) {
    if (state.containsKey(pointerId)) {
      state = Map.from(state)..remove(pointerId);
    }
  }

  /// Clears all pointer tracking.
  void clear() {
    if (state.isNotEmpty) {
      state = {};
    }
  }

  /// Checks if all given pointers are on the same object.
  ///
  /// Returns the object ID if all pointers are on the same object,
  /// null otherwise.
  String? allPointersOnSameObject(int pointerCount) {
    if (state.isEmpty || pointerCount == 0) {
      return null;
    }
    if (state.length < pointerCount) {
      return null;
    }

    final objectIds = state.values.toSet();
    if (objectIds.length == 1) {
      return objectIds.first;
    }
    return null;
  }

  /// Checks if any pointer is on an object.
  bool get hasPointersOnObjects => state.isNotEmpty;

  /// Gets the number of pointers currently on objects.
  int get pointerCount => state.length;
}
