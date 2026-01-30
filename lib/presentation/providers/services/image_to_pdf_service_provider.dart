import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/services/image_to_pdf_service.dart';

part 'image_to_pdf_service_provider.g.dart';

/// Provider for [ImageToPdfService].
///
/// Provides a singleton instance of the service for converting images to PDFs.
@riverpod
ImageToPdfService imageToPdfService(ImageToPdfServiceRef ref) {
  return ImageToPdfService();
}
