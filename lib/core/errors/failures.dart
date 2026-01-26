import 'package:minipdfsign/core/errors/failure.dart';

/// Failure when a file is not found at the specified path.
class FileNotFoundFailure extends Failure {
  const FileNotFoundFailure({
    super.message = 'File not found',
    super.code = 'FILE_NOT_FOUND',
  });
}

/// Failure when file access is denied (permissions, locked file, etc.).
class FileAccessFailure extends Failure {
  const FileAccessFailure({
    super.message = 'File access denied',
    super.code = 'FILE_ACCESS_DENIED',
  });
}

/// Failure when the file format is invalid (not a valid PDF).
class InvalidFileFormatFailure extends Failure {
  const InvalidFileFormatFailure({
    super.message = 'Invalid file format',
    super.code = 'INVALID_FILE_FORMAT',
  });
}

/// Failure when file size exceeds the allowed limit.
class FileSizeLimitFailure extends Failure {
  const FileSizeLimitFailure({
    super.message = 'File size exceeds limit',
    super.code = 'FILE_SIZE_LIMIT',
  });
}

/// Failure when a password is required to open the PDF.
class PasswordRequiredFailure extends Failure {
  const PasswordRequiredFailure({
    super.message = 'Password required',
    super.code = 'PASSWORD_REQUIRED',
  });
}

/// Failure when the provided password is incorrect.
class PasswordIncorrectFailure extends Failure {
  final int attemptsRemaining;

  const PasswordIncorrectFailure({
    super.message = 'Incorrect password',
    super.code = 'PASSWORD_INCORRECT',
    this.attemptsRemaining = 0,
  });

  @override
  List<Object?> get props => [...super.props, attemptsRemaining];
}

/// Failure when the PDF is write-protected.
class WriteProtectedFailure extends Failure {
  const WriteProtectedFailure({
    super.message = 'PDF is write-protected',
    super.code = 'WRITE_PROTECTED',
  });
}

/// Failure when local storage operations fail (SharedPreferences, Isar, etc.).
class StorageFailure extends Failure {
  const StorageFailure({
    required super.message,
    super.code = 'STORAGE_ERROR',
  });
}

/// Failure when a PDF render operation is cancelled.
class RenderCancelledFailure extends Failure {
  final int pageNumber;

  const RenderCancelledFailure({
    required this.pageNumber,
    super.message = 'Render operation cancelled',
    super.code = 'RENDER_CANCELLED',
  });

  @override
  List<Object?> get props => [...super.props, pageNumber];
}

/// Failure when PDF document loading fails.
class PdfLoadFailure extends Failure {
  const PdfLoadFailure({
    required super.message,
    super.code = 'PDF_LOAD_ERROR',
  });
}

/// Failure when PDF page rendering fails.
class PdfRenderFailure extends Failure {
  final int pageNumber;

  const PdfRenderFailure({
    required this.pageNumber,
    required super.message,
    super.code = 'PDF_RENDER_ERROR',
  });

  @override
  List<Object?> get props => [...super.props, pageNumber];
}

/// Catch-all failure for unexpected errors.
class UnknownFailure extends Failure {
  const UnknownFailure({
    required super.message,
    super.code = 'UNKNOWN_ERROR',
  });
}
