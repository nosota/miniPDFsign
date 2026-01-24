import 'package:equatable/equatable.dart';

/// Information about a single PDF page.
///
/// Contains the page dimensions and number, used for layout calculations
/// and rendering.
class PdfPageInfo extends Equatable {
  const PdfPageInfo({
    required this.pageNumber,
    required this.width,
    required this.height,
  });

  /// 1-based page number.
  final int pageNumber;

  /// Original page width in points.
  final double width;

  /// Original page height in points.
  final double height;

  /// Aspect ratio (width / height).
  double get aspectRatio => width / height;

  /// Creates a copy with modified fields.
  PdfPageInfo copyWith({
    int? pageNumber,
    double? width,
    double? height,
  }) {
    return PdfPageInfo(
      pageNumber: pageNumber ?? this.pageNumber,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  @override
  List<Object?> get props => [pageNumber, width, height];
}
