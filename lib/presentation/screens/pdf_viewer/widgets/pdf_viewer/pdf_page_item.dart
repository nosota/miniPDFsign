import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:minipdfsign/domain/entities/pdf_page_info.dart';
import 'package:minipdfsign/presentation/providers/pdf_viewer/pdf_page_cache_provider.dart';
import 'package:minipdfsign/presentation/providers/viewer_session/viewer_session_provider.dart';
import 'package:minipdfsign/presentation/providers/viewer_session/viewer_session_scope.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/pdf_viewer/pdf_page_placeholder.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/pdf_viewer/pdf_viewer_constants.dart';

/// A single PDF page widget with shadow and loading state.
///
/// Automatically retries rendering on transient errors (up to 3 times)
/// to handle platform-specific race conditions.
class PdfPageItem extends ConsumerStatefulWidget {
  const PdfPageItem({
    required this.pageInfo,
    required this.scale,
    required this.isVisible,
    super.key,
  });

  /// Information about this page (dimensions, number).
  final PdfPageInfo pageInfo;

  /// Current scale factor for rendering.
  final double scale;

  /// Whether this page is in the visible + buffer range.
  final bool isVisible;

  @override
  ConsumerState<PdfPageItem> createState() => _PdfPageItemState();
}

class _PdfPageItemState extends ConsumerState<PdfPageItem> {
  static const int _maxRetries = 3;
  int _retryCount = 0;
  bool _retryScheduled = false;

  @override
  void didUpdateWidget(PdfPageItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset retry count when page or scale changes — fresh render.
    if (oldWidget.pageInfo.pageNumber != widget.pageInfo.pageNumber ||
        oldWidget.scale != widget.scale) {
      _retryCount = 0;
      _retryScheduled = false;
    }
  }

  void _scheduleRetry() {
    if (_retryScheduled || _retryCount >= _maxRetries) return;
    _retryScheduled = true;
    _retryCount++;

    Future<void>.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      _retryScheduled = false;
      ref.invalidate(
        pdfPageImageProvider(
          pageNumber: widget.pageInfo.pageNumber,
          scale: widget.scale,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaledWidth = widget.pageInfo.width * widget.scale;
    final scaledHeight = widget.pageInfo.height * widget.scale;

    if (!widget.isVisible) {
      return PdfPagePlaceholder(
        width: scaledWidth,
        height: scaledHeight,
      );
    }

    final imageAsync = ref.watch(
      pdfPageImageProvider(
        pageNumber: widget.pageInfo.pageNumber,
        scale: widget.scale,
      ),
    );

    final sessionId = ViewerSessionScope.of(context);

    return imageAsync.when(
      data: (bytes) {
        _retryCount = 0;
        return _buildPageImage(
          bytes,
          scaledWidth,
          scaledHeight,
          sessionId,
        );
      },
      loading: () => PdfPagePlaceholder(
        width: scaledWidth,
        height: scaledHeight,
      ),
      error: (error, _) {
        if (error is PageRenderCancelledException) {
          return PdfPagePlaceholder(
            width: scaledWidth,
            height: scaledHeight,
          );
        }
        // Transient errors: show placeholder and retry automatically.
        if (_retryCount < _maxRetries) {
          _scheduleRetry();
          return PdfPagePlaceholder(
            width: scaledWidth,
            height: scaledHeight,
          );
        }
        // Exhausted retries — show error state.
        return _buildErrorState(scaledWidth, scaledHeight);
      },
    );
  }

  Widget _buildPageImage(
    Uint8List bytes,
    double width,
    double height,
    String sessionId,
  ) {
    return GestureDetector(
      onTap: () {
        ref
            .read(
              sessionEditorSelectionProvider(sessionId).notifier,
            )
            .clear();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: PdfViewerConstants.pageBackground,
          borderRadius: BorderRadius.circular(
            PdfViewerConstants.pageBorderRadius,
          ),
          boxShadow: PdfViewerConstants.pageShadow,
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.memory(
          bytes,
          width: width,
          height: height,
          fit: BoxFit.contain,
          gaplessPlayback: true,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }

  Widget _buildErrorState(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: PdfViewerConstants.pageBackground,
        borderRadius: BorderRadius.circular(
          PdfViewerConstants.pageBorderRadius,
        ),
        boxShadow: PdfViewerConstants.pageShadow,
      ),
      child: const Center(
        child: Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 32,
        ),
      ),
    );
  }
}
