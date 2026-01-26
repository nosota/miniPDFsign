import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:minipdfsign/data/services/pdf_save_service.dart';

part 'pdf_save_service_provider.g.dart';

/// Provider for the PDF save service.
@riverpod
PdfSaveService pdfSaveService(PdfSaveServiceRef ref) {
  return PdfSaveService();
}
