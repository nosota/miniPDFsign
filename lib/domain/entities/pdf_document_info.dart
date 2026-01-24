import 'package:equatable/equatable.dart';

import 'package:pdfsign/domain/entities/pdf_page_info.dart';

/// Information about a PDF document.
///
/// Contains metadata and page information needed for rendering
/// and navigation.
class PdfDocumentInfo extends Equatable {
  const PdfDocumentInfo({
    required this.filePath,
    required this.fileName,
    required this.pageCount,
    required this.pages,
    this.isPasswordProtected = false,
  });

  /// Full path to the PDF file.
  final String filePath;

  /// File name extracted from path.
  final String fileName;

  /// Total number of pages in the document.
  final int pageCount;

  /// Information about each page.
  final List<PdfPageInfo> pages;

  /// Whether the document is password protected.
  final bool isPasswordProtected;

  /// Creates a copy with modified fields.
  PdfDocumentInfo copyWith({
    String? filePath,
    String? fileName,
    int? pageCount,
    List<PdfPageInfo>? pages,
    bool? isPasswordProtected,
  }) {
    return PdfDocumentInfo(
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
      pageCount: pageCount ?? this.pageCount,
      pages: pages ?? this.pages,
      isPasswordProtected: isPasswordProtected ?? this.isPasswordProtected,
    );
  }

  @override
  List<Object?> get props => [
        filePath,
        fileName,
        pageCount,
        pages,
        isPasswordProtected,
      ];
}
