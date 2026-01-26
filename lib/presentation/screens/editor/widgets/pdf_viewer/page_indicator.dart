import 'dart:async';

import 'package:flutter/material.dart';

import 'package:minipdfsign/core/theme/app_colors.dart';
import 'package:minipdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_viewer_constants.dart';

/// Floating page indicator that shows current page and auto-hides.
class PageIndicator extends StatefulWidget {
  const PageIndicator({
    required this.currentPage,
    required this.totalPages,
    required this.isScrolling,
    super.key,
  });

  /// Current page number (1-based).
  final int currentPage;

  /// Total number of pages.
  final int totalPages;

  /// Whether the user is currently scrolling.
  final bool isScrolling;

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  bool _isVisible = false;
  Timer? _hideTimer;

  @override
  void didUpdateWidget(PageIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isScrolling && !_isVisible) {
      _showIndicator();
    } else if (widget.isScrolling) {
      _resetHideTimer();
    }

    if (widget.currentPage != oldWidget.currentPage) {
      _showIndicator();
    }
  }

  void _showIndicator() {
    setState(() {
      _isVisible = true;
    });
    _resetHideTimer();
  }

  void _resetHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(PdfViewerConstants.pageIndicatorHideDuration, () {
      if (mounted && !widget.isScrolling) {
        setState(() {
          _isVisible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: PdfViewerConstants.pageIndicatorFadeDuration,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.textPrimary.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          'Page ${widget.currentPage} of ${widget.totalPages}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
