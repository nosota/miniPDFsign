import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:minipdfsign/data/services/pdf_share_service.dart';
import 'package:minipdfsign/presentation/providers/editor/pdf_save_service_provider.dart';

part 'pdf_share_service_provider.g.dart';

/// Provider for the PDF share service.
///
/// Uses keepAlive to preserve temp file cleanup state across calls.
@Riverpod(keepAlive: true)
PdfShareService pdfShareService(PdfShareServiceRef ref) {
  return PdfShareService(
    pdfSaveService: ref.read(pdfSaveServiceProvider),
  );
}
