import 'package:flutter/widgets.dart';

/// InheritedWidget that provides the current viewer session ID to descendants.
///
/// This allows child widgets to access session-scoped providers without
/// passing the session ID explicitly through constructors.
class ViewerSessionScope extends InheritedWidget {
  const ViewerSessionScope({
    required this.sessionId,
    required super.child,
    super.key,
  });

  /// The unique identifier for this viewer session.
  final String sessionId;

  /// Returns the session ID from the nearest ancestor [ViewerSessionScope].
  ///
  /// Throws [FlutterError] if no [ViewerSessionScope] is found in the tree.
  static String of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<ViewerSessionScope>();
    if (scope == null) {
      throw FlutterError(
        'ViewerSessionScope.of() called with a context that does not contain '
        'a ViewerSessionScope.\n'
        'No ViewerSessionScope ancestor could be found starting from the '
        'context that was passed to ViewerSessionScope.of().\n'
        'This usually happens when PdfViewerScreen is used outside of a '
        'ViewerSessionScope, or when trying to access the session ID before '
        'the scope is established.',
      );
    }
    return scope.sessionId;
  }

  /// Returns the session ID from the nearest ancestor [ViewerSessionScope],
  /// or null if no scope is found.
  static String? maybeOf(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<ViewerSessionScope>();
    return scope?.sessionId;
  }

  @override
  bool updateShouldNotify(ViewerSessionScope oldWidget) {
    return sessionId != oldWidget.sessionId;
  }
}
