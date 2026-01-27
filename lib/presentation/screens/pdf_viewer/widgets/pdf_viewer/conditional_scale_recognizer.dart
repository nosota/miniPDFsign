import 'package:flutter/gestures.dart';

/// A [ScaleGestureRecognizer] that can conditionally reject gestures.
///
/// This allows child gesture recognizers to win the arena when the parent
/// should not handle the gesture (e.g., when all pointers are on placed objects).
class ConditionalScaleGestureRecognizer extends ScaleGestureRecognizer {
  ConditionalScaleGestureRecognizer({
    required this.shouldAcceptGesture,
    super.supportedDevices,
    super.dragStartBehavior,
  });

  /// Callback to determine if this recognizer should accept the gesture.
  ///
  /// Called when the recognizer is about to accept. Return `true` to accept,
  /// `false` to reject (allowing other recognizers to win the arena).
  final bool Function() shouldAcceptGesture;

  @override
  void acceptGesture(int pointer) {
    if (shouldAcceptGesture()) {
      super.acceptGesture(pointer);
    } else {
      // Reject the gesture, giving other recognizers a chance to win
      rejectGesture(pointer);
    }
  }

  @override
  void rejectGesture(int pointer) {
    // Clean up and reject
    super.rejectGesture(pointer);
  }
}
