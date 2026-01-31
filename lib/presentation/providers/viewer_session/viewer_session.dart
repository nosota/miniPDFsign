import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import 'package:minipdfsign/presentation/providers/editor/file_source_provider.dart';

/// Represents a PDF viewer session.
///
/// Each time a PDF is opened, a new session is created with a unique ID.
/// This ensures complete isolation of state between different viewer instances.
@immutable
class ViewerSession {
  ViewerSession({
    required this.filePath,
    required this.fileSource,
    this.originalImageName,
    String? id,
  }) : id = id ?? const Uuid().v4();

  /// Unique identifier for this session.
  final String id;

  /// Path to the PDF file (or converted PDF for images).
  final String filePath;

  /// Source of the file (determines save behavior).
  final FileSourceType fileSource;

  /// Original image file name (for converted images).
  final String? originalImageName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViewerSession &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'ViewerSession(id: $id, filePath: $filePath, fileSource: $fileSource)';
}
