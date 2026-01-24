import 'package:flutter/material.dart';

import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_viewer_constants.dart';

/// Placeholder widget shown while a PDF page is loading.
///
/// Displays a centered spinner with the page dimensions.
class PdfPagePlaceholder extends StatelessWidget {
  const PdfPagePlaceholder({
    required this.width,
    required this.height,
    super.key,
  });

  /// Width of the placeholder.
  final double width;

  /// Height of the placeholder.
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: PdfViewerConstants.pageBackground,
        borderRadius: BorderRadius.circular(PdfViewerConstants.pageBorderRadius),
        boxShadow: PdfViewerConstants.pageShadow,
      ),
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
