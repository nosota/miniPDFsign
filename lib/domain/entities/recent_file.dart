import 'package:equatable/equatable.dart';

/// Domain entity representing a recently opened PDF file.
///
/// Immutable with value equality via Equatable.
class RecentFile extends Equatable {
  /// Full file system path to the PDF.
  final String path;

  /// File name extracted from path (for display).
  final String fileName;

  /// When the file was last opened.
  final DateTime lastOpened;

  /// Number of pages in the PDF.
  final int pageCount;

  /// Whether the PDF requires a password.
  final bool isPasswordProtected;

  /// Security-scoped bookmark data for persistent file access.
  ///
  /// On iOS: Base64-encoded security-scoped bookmark.
  /// On Android: Base64-encoded content URI with persistable permission.
  /// On Desktop: Same as path (no special handling needed).
  ///
  /// May be null for legacy entries or if bookmark creation failed.
  final String? bookmarkData;

  const RecentFile({
    required this.path,
    required this.fileName,
    required this.lastOpened,
    required this.pageCount,
    required this.isPasswordProtected,
    this.bookmarkData,
  });

  /// Creates a copy with updated fields.
  RecentFile copyWith({
    String? path,
    String? fileName,
    DateTime? lastOpened,
    int? pageCount,
    bool? isPasswordProtected,
    String? bookmarkData,
  }) {
    return RecentFile(
      path: path ?? this.path,
      fileName: fileName ?? this.fileName,
      lastOpened: lastOpened ?? this.lastOpened,
      pageCount: pageCount ?? this.pageCount,
      isPasswordProtected: isPasswordProtected ?? this.isPasswordProtected,
      bookmarkData: bookmarkData ?? this.bookmarkData,
    );
  }

  @override
  List<Object?> get props => [
        path,
        fileName,
        lastOpened,
        pageCount,
        isPasswordProtected,
        bookmarkData,
      ];

  @override
  String toString() {
    return 'RecentFile(fileName: $fileName, lastOpened: $lastOpened)';
  }
}
