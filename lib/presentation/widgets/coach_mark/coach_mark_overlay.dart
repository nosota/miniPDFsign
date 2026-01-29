import 'package:flutter/material.dart';

import 'package:minipdfsign/l10n/generated/app_localizations.dart';

/// A full-screen overlay with a spotlight cutout and hint message.
///
/// Used for contextual onboarding to highlight UI elements.
class CoachMarkOverlay extends StatelessWidget {
  const CoachMarkOverlay({
    required this.targetRect,
    required this.message,
    required this.onDismiss,
    this.spotlightPadding = 8.0,
    this.spotlightBorderRadius = 8.0,
    this.overlayOpacity = 0.75,
    super.key,
  });

  /// The rectangle of the target element to highlight.
  final Rect targetRect;

  /// The hint message to display.
  final String message;

  /// Callback when the overlay is dismissed (tap anywhere).
  final VoidCallback onDismiss;

  /// Padding around the spotlight cutout.
  final double spotlightPadding;

  /// Border radius of the spotlight cutout.
  final double spotlightBorderRadius;

  /// Opacity of the dark overlay (0.0 - 1.0).
  final double overlayOpacity;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final spotlightRect = targetRect.inflate(spotlightPadding);

    // Determine if message should be above or below the spotlight
    final spaceBelow = screenSize.height - spotlightRect.bottom;
    final spaceAbove = spotlightRect.top;
    final showBelow = spaceBelow > 120 || spaceBelow > spaceAbove;

    return GestureDetector(
      onTap: onDismiss,
      behavior: HitTestBehavior.opaque,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            // Darkened overlay with spotlight cutout
            CustomPaint(
              size: screenSize,
              painter: _SpotlightPainter(
                spotlightRect: spotlightRect,
                borderRadius: spotlightBorderRadius,
                overlayColor: Colors.black.withValues(alpha: overlayOpacity),
              ),
            ),

            // Hint message bubble
            Positioned(
              left: 24,
              right: 24,
              top: showBelow ? spotlightRect.bottom + 16 : null,
              bottom: showBelow ? null : screenSize.height - spotlightRect.top + 16,
              child: _HintBubble(
                message: message,
                dismissText: AppLocalizations.of(context)?.onboardingTapToContinue ??
                    'Tap anywhere to continue',
                arrowOnTop: !showBelow,
                targetCenterX: spotlightRect.center.dx,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter that draws a dark overlay with a spotlight cutout.
class _SpotlightPainter extends CustomPainter {
  _SpotlightPainter({
    required this.spotlightRect,
    required this.borderRadius,
    required this.overlayColor,
  });

  final Rect spotlightRect;
  final double borderRadius;
  final Color overlayColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = overlayColor;

    // Create a path that covers the entire screen
    final overlayPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Create the spotlight cutout path
    final spotlightPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          spotlightRect,
          Radius.circular(borderRadius),
        ),
      );

    // Subtract the spotlight from the overlay
    final combinedPath = Path.combine(
      PathOperation.difference,
      overlayPath,
      spotlightPath,
    );

    canvas.drawPath(combinedPath, paint);
  }

  @override
  bool shouldRepaint(_SpotlightPainter oldDelegate) {
    return spotlightRect != oldDelegate.spotlightRect ||
        borderRadius != oldDelegate.borderRadius ||
        overlayColor != oldDelegate.overlayColor;
  }
}

/// A hint message bubble with optional arrow pointing to target.
class _HintBubble extends StatelessWidget {
  const _HintBubble({
    required this.message,
    required this.dismissText,
    required this.arrowOnTop,
    required this.targetCenterX,
  });

  final String message;
  final String dismissText;
  final bool arrowOnTop;
  final double targetCenterX;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            dismissText,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
