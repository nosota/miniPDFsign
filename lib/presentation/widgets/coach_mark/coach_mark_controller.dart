import 'package:flutter/material.dart';

import 'package:minipdfsign/presentation/widgets/coach_mark/coach_mark_overlay.dart';

/// Controller for showing and dismissing coach mark overlays.
///
/// Uses Flutter's Overlay API to display coach marks on top of the UI.
class CoachMarkController {
  CoachMarkController._();

  static OverlayEntry? _currentOverlay;

  /// Whether a coach mark is currently visible.
  static bool get isVisible => _currentOverlay != null;

  /// Shows a coach mark highlighting the element at [targetKey].
  ///
  /// Parameters:
  /// - [context]: BuildContext for accessing the Overlay.
  /// - [targetKey]: GlobalKey of the element to highlight.
  /// - [message]: Hint message to display.
  /// - [onDismiss]: Optional callback when the coach mark is dismissed.
  /// - [spotlightPadding]: Padding around the spotlight (default: 8.0).
  /// - [spotlightBorderRadius]: Border radius of spotlight (default: 8.0).
  ///
  /// Returns true if the coach mark was shown, false if the target
  /// element couldn't be found or a coach mark is already visible.
  static bool show({
    required BuildContext context,
    required GlobalKey targetKey,
    required String message,
    VoidCallback? onDismiss,
    double spotlightPadding = 8.0,
    double spotlightBorderRadius = 8.0,
  }) {
    // Don't show if already visible
    if (_currentOverlay != null) {
      return false;
    }

    // Get the target element's position and size
    final renderBox =
        targetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) {
      return false;
    }

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final targetRect = position & size;

    // Create and insert the overlay
    _currentOverlay = OverlayEntry(
      builder: (context) => CoachMarkOverlay(
        targetRect: targetRect,
        message: message,
        spotlightPadding: spotlightPadding,
        spotlightBorderRadius: spotlightBorderRadius,
        onDismiss: () {
          dismiss();
          onDismiss?.call();
        },
      ),
    );

    Overlay.of(context).insert(_currentOverlay!);
    return true;
  }

  /// Shows a coach mark at a specific rect position.
  ///
  /// Use this when you need to highlight a specific area that
  /// doesn't have a GlobalKey.
  static bool showAtRect({
    required BuildContext context,
    required Rect targetRect,
    required String message,
    VoidCallback? onDismiss,
    double spotlightPadding = 8.0,
    double spotlightBorderRadius = 8.0,
  }) {
    // Don't show if already visible
    if (_currentOverlay != null) {
      return false;
    }

    // Create and insert the overlay
    _currentOverlay = OverlayEntry(
      builder: (context) => CoachMarkOverlay(
        targetRect: targetRect,
        message: message,
        spotlightPadding: spotlightPadding,
        spotlightBorderRadius: spotlightBorderRadius,
        onDismiss: () {
          dismiss();
          onDismiss?.call();
        },
      ),
    );

    Overlay.of(context).insert(_currentOverlay!);
    return true;
  }

  /// Dismisses the currently visible coach mark.
  static void dismiss() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}
