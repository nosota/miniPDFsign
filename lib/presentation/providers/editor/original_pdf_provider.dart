import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minipdfsign/data/services/original_pdf_storage.dart';

/// Provider for storing the original PDF bytes.
///
/// This provider manages the [OriginalPdfStorage] instance which stores
/// the original PDF when a file is opened. This allows Save operations
/// to always use the original bytes (without previously embedded objects).
final originalPdfStorageProvider = Provider<OriginalPdfStorage>((ref) {
  final storage = OriginalPdfStorage();
  ref.onDispose(() => storage.dispose());
  return storage;
});
