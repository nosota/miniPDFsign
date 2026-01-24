import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'document_dirty_provider.g.dart';

/// Provider for tracking whether the document has unsaved changes.
///
/// This is used to show a confirmation dialog when closing with unsaved changes.
/// Uses keepAlive to persist state throughout the app lifecycle.
@Riverpod(keepAlive: true)
class DocumentDirty extends _$DocumentDirty {
  @override
  bool build() {
    return false;
  }

  /// Marks the document as having unsaved changes.
  void markDirty() {
    state = true;
  }

  /// Marks the document as saved (no unsaved changes).
  void markClean() {
    state = false;
  }
}
