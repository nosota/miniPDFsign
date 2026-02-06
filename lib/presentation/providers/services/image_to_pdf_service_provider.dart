import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/services/image_to_pdf_service.dart';
import '../repository_providers.dart';

part 'image_to_pdf_service_provider.g.dart';

/// Provider for [ImageToPdfService].
///
/// Provides a singleton instance of the service for converting images to PDFs.
/// EXIF orientation is automatically handled via [ImageNormalizationService].
@riverpod
ImageToPdfService imageToPdfService(ImageToPdfServiceRef ref) {
  final normalizationService = ref.watch(imageNormalizationServiceProvider);
  return ImageToPdfService(normalizationService);
}
