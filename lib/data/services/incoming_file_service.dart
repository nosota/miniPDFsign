import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'package:minipdfsign/data/services/image_to_pdf_service.dart';

/// Type of incoming file.
enum IncomingFileType {
  /// PDF document - open directly.
  pdf,

  /// Image file - will be converted to PDF.
  image,
}

/// Represents an incoming file from Share Sheet or "Open In".
class IncomingFile {
  const IncomingFile({
    required this.path,
    required this.type,
    this.originalFileName,
  });

  /// Path to the file.
  final String path;

  /// Type of file (PDF or image).
  final IncomingFileType type;

  /// Original file name (for images, to use when saving PDF).
  final String? originalFileName;
}

/// Service for handling incoming files from "Open In" and Share sheet.
///
/// Supports both PDF files and images. Images will be flagged for conversion
/// to PDF before opening.
class IncomingFileService {
  StreamSubscription<List<SharedMediaFile>>? _subscription;
  final _fileController = StreamController<IncomingFile>.broadcast();

  /// Stream of incoming files (PDF or image).
  Stream<IncomingFile> get incomingFiles => _fileController.stream;

  /// Initialize the service and start listening for incoming files.
  void initialize() {
    // Handle files received while app is running
    _subscription = ReceiveSharingIntent.instance
        .getMediaStream()
        .listen(_handleSharedFiles, onError: (err) {
      if (kDebugMode) {
        print('Error receiving shared files: $err');
      }
    });

    // Handle files received when app was closed
    _checkInitialFile();
  }

  /// Check for files that opened the app.
  Future<void> _checkInitialFile() async {
    final sharedFiles =
        await ReceiveSharingIntent.instance.getInitialMedia();
    _handleSharedFiles(sharedFiles);
    // Clear the intent to prevent re-opening the same file
    ReceiveSharingIntent.instance.reset();
  }

  void _handleSharedFiles(List<SharedMediaFile> files) {
    for (final file in files) {
      final path = file.path;
      final lowerPath = path.toLowerCase();
      final fileName = path.split('/').last;

      // Check if it's a PDF
      if (lowerPath.endsWith('.pdf')) {
        if (kDebugMode) {
          print('Received PDF file: $path');
        }
        _fileController.add(IncomingFile(
          path: path,
          type: IncomingFileType.pdf,
        ));
      }
      // Check if it's a supported image
      else if (ImageToPdfService.isImageFile(path)) {
        if (kDebugMode) {
          print('Received image file: $path');
        }
        _fileController.add(IncomingFile(
          path: path,
          type: IncomingFileType.image,
          originalFileName: fileName,
        ));
      }
      // Unsupported file type - ignore silently
      else {
        if (kDebugMode) {
          print('Ignoring unsupported file type: $path');
        }
      }
    }
  }

  /// Dispose resources.
  void dispose() {
    _subscription?.cancel();
    _fileController.close();
  }
}
