import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

/// A full-screen overlay with a spotlight cutout and hint message.
///
/// Used for contextual onboarding to highlight UI elements.
/// Features animated appearance, pulsing ring effect, and arrow pointer.
class CoachMarkOverlay extends StatefulWidget {
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
  State<CoachMarkOverlay> createState() => _CoachMarkOverlayState();
}

class _CoachMarkOverlayState extends State<CoachMarkOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final AnimationController _bubbleController;
  late final AnimationController _pulseController;

  late final Animation<double> _fadeAnimation;
  late final Animation<double> _bubbleScaleAnimation;
  late final Animation<double> _bubbleFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Fade-in animation for overlay (300ms)
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    // Scale + fade animation for bubble (400ms with delay)
    _bubbleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _bubbleScaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(
        parent: _bubbleController,
        curve: Curves.easeOutBack,
      ),
    );
    _bubbleFadeAnimation = CurvedAnimation(
      parent: _bubbleController,
      curve: Curves.easeOut,
    );

    // Pulsing ring animation (continuous, 1.5s per cycle)
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Start animations
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        _bubbleController.forward();
        _pulseController.repeat();
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _bubbleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final spotlightRect = widget.targetRect.inflate(widget.spotlightPadding);

    // Determine if message should be above or below the spotlight
    final spaceBelow = screenSize.height - spotlightRect.bottom;
    final spaceAbove = spotlightRect.top;
    final showBelow = spaceBelow > 120 || spaceBelow > spaceAbove;

    return GestureDetector(
      onTap: widget.onDismiss,
      behavior: HitTestBehavior.opaque,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            // Animated darkened overlay with spotlight cutout
            FadeTransition(
              opacity: _fadeAnimation,
              child: CustomPaint(
                size: screenSize,
                painter: _SpotlightPainter(
                  spotlightRect: spotlightRect,
                  borderRadius: widget.spotlightBorderRadius,
                  overlayColor:
                      Colors.black.withValues(alpha: widget.overlayOpacity),
                ),
              ),
            ),

            // Pulsing ring around spotlight
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) => CustomPaint(
                size: screenSize,
                painter: _PulsingRingPainter(
                  spotlightRect: spotlightRect,
                  borderRadius: widget.spotlightBorderRadius,
                  progress: _pulseController.value,
                  ringColor: Colors.white,
                ),
              ),
            ),

            // Animated hint message bubble with arrow
            Positioned(
              left: 24,
              right: 24,
              top: showBelow ? spotlightRect.bottom + 24 : null,
              bottom: showBelow
                  ? null
                  : screenSize.height - spotlightRect.top + 24,
              child: FadeTransition(
                opacity: _bubbleFadeAnimation,
                child: ScaleTransition(
                  scale: _bubbleScaleAnimation,
                  alignment: showBelow
                      ? Alignment.topCenter
                      : Alignment.bottomCenter,
                  child: _HintBubble(
                    message: widget.message,
                    dismissText:
                        AppLocalizations.of(context)?.onboardingTapToContinue ??
                            'Tap anywhere to continue',
                    arrowOnTop: !showBelow,
                    targetCenterX: spotlightRect.center.dx,
                    bubbleLeft: 24,
                    bubbleRight: 24,
                    screenWidth: screenSize.width,
                  ),
                ),
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
  bool shouldRepaint(_SpotlightPainter oldDelegate) =>
      spotlightRect != oldDelegate.spotlightRect ||
      borderRadius != oldDelegate.borderRadius ||
      overlayColor != oldDelegate.overlayColor;
}

/// Custom painter that draws pulsing rings around the spotlight.
class _PulsingRingPainter extends CustomPainter {
  _PulsingRingPainter({
    required this.spotlightRect,
    required this.borderRadius,
    required this.progress,
    required this.ringColor,
  });

  final Rect spotlightRect;
  final double borderRadius;
  final double progress;
  final Color ringColor;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw 2 rings with staggered timing
    for (var i = 0; i < 2; i++) {
      final ringProgress = (progress + i * 0.5) % 1.0;
      final opacity = (1.0 - ringProgress) * 0.6;
      final expansion = ringProgress * 20;

      if (opacity > 0) {
        final paint = Paint()
          ..color = ringColor.withValues(alpha: opacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;

        final expandedRect = spotlightRect.inflate(expansion);
        final expandedRadius = borderRadius + expansion * 0.5;

        canvas.drawRRect(
          RRect.fromRectAndRadius(
            expandedRect,
            Radius.circular(expandedRadius),
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_PulsingRingPainter oldDelegate) =>
      progress != oldDelegate.progress ||
      spotlightRect != oldDelegate.spotlightRect;
}

/// A hint message bubble with arrow pointing to target.
class _HintBubble extends StatelessWidget {
  const _HintBubble({
    required this.message,
    required this.dismissText,
    required this.arrowOnTop,
    required this.targetCenterX,
    required this.bubbleLeft,
    required this.bubbleRight,
    required this.screenWidth,
  });

  final String message;
  final String dismissText;
  final bool arrowOnTop;
  final double targetCenterX;
  final double bubbleLeft;
  final double bubbleRight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    // Calculate arrow position relative to bubble
    final bubbleWidth = screenWidth - bubbleLeft - bubbleRight;
    final arrowX =
        (targetCenterX - bubbleLeft).clamp(20.0, bubbleWidth - 20.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Arrow on top (when bubble is below spotlight)
        if (!arrowOnTop)
          Padding(
            padding: EdgeInsets.only(left: arrowX - 10),
            child: CustomPaint(
              size: const Size(20, 10),
              painter: _ArrowPainter(pointUp: true),
            ),
          ),

        // Bubble content
        Container(
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
        ),

        // Arrow on bottom (when bubble is above spotlight)
        if (arrowOnTop)
          Padding(
            padding: EdgeInsets.only(left: arrowX - 10),
            child: CustomPaint(
              size: const Size(20, 10),
              painter: _ArrowPainter(pointUp: false),
            ),
          ),
      ],
    );
  }
}

/// Custom painter for the arrow triangle.
class _ArrowPainter extends CustomPainter {
  _ArrowPainter({required this.pointUp});

  final bool pointUp;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final path = Path();

    if (pointUp) {
      // Triangle pointing up: ▲
      path
        ..moveTo(size.width / 2, 0)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height);
    } else {
      // Triangle pointing down: ▼
      path
        ..moveTo(0, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width / 2, size.height);
    }
    path.close();

    // Draw shadow first, then arrow
    canvas
      ..drawPath(path.shift(const Offset(0, 2)), shadowPaint)
      ..drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ArrowPainter oldDelegate) =>
      pointUp != oldDelegate.pointUp;
}
