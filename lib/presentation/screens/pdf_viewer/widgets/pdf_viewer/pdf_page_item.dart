import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:minipdfsign/domain/entities/pdf_page_info.dart';
import 'package:minipdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:minipdfsign/presentation/providers/pdf_viewer/pdf_page_cache_provider.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/pdf_viewer/pdf_page_placeholder.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/pdf_viewer/pdf_viewer_constants.dart';

/// A single PDF page widget with shadow and loading state.
class PdfPageItem extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final scaledWidth = pageInfo.width * scale;
    final scaledHeight = pageInfo.height * scale;

    if (!isVisible) {
      return PdfPagePlaceholder(
        width: scaledWidth,
        height: scaledHeight,
      );
    }

    final imageAsync = ref.watch(
      pdfPageImageProvider(
        pageNumber: pageInfo.pageNumber,
        scale: scale,
      ),
    );

    return imageAsync.when(
      data: (bytes) => _buildPageImage(ref, bytes, scaledWidth, scaledHeight),
      loading: () => PdfPagePlaceholder(
        width: scaledWidth,
        height: scaledHeight,
      ),
      error: (error, _) {
        // Render cancellation is not an error - show placeholder (will retry on next build)
        if (error is PageRenderCancelledException) {
          return PdfPagePlaceholder(
            width: scaledWidth,
            height: scaledHeight,
          );
        }
        // Real errors show error state
        return _buildErrorState(scaledWidth, scaledHeight);
      },
    );
  }

  Widget _buildPageImage(
    WidgetRef ref,
    Uint8List bytes,
    double width,
    double height,
  ) {
    return GestureDetector(
      onTap: () {
        // Clear selection when tapping on page background
        ref.read(editorSelectionProvider.notifier).clear();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: PdfViewerConstants.pageBackground,
          borderRadius: BorderRadius.circular(PdfViewerConstants.pageBorderRadius),
          boxShadow: PdfViewerConstants.pageShadow,
        ),
        clipBehavior: Clip.antiAlias,
        // PDF page image only - PlacedImagesLayer is rendered outside ScrollView
        // in pdf_viewer.dart to prevent gesture conflicts
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
        borderRadius: BorderRadius.circular(PdfViewerConstants.pageBorderRadius),
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
