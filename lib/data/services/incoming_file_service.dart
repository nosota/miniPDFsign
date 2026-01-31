import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'package:minipdfsign/data/services/image_to_pdf_service.dart';

/// Native EventChannel for "Open In" files (iOS only).
/// receive_sharing_intent doesn't support direct file URLs, so we handle them natively.
const _openInFilesChannel = EventChannel('com.ivanvaganov.minipdfsign/open_in_files');

/// Type of incoming file.
enum IncomingFileType {
  /// PDF document - open directly.
  pdf,

  /// Single image file - will be converted to single-page PDF.
  image,

  /// Multiple image files - will be converted to multi-page PDF.
  /// Use [imagePaths] to get all image paths.
  multipleImages,
}

/// Represents an incoming file from Share Sheet or "Open In".
class IncomingFile {
  const IncomingFile({
    required this.path,
    required this.type,
    this.originalFileName,
    this.imagePaths,
  });

  /// Path to the file (for PDF or single image).
  final String path;

  /// Type of file (PDF, single image, or multiple images).
  final IncomingFileType type;

  /// Original file name (for images, to use when saving PDF).
  final String? originalFileName;

  /// Paths to all images (for multipleImages type).
  /// Null for PDF or single image types.
  final List<String>? imagePaths;
}

/// Service for handling incoming files from "Open In" and Share sheet.
///
/// Supports both PDF files and images. Images will be flagged for conversion
/// to PDF before opening.
class IncomingFileService {
  StreamSubscription<List<SharedMediaFile>>? _subscription;
  StreamSubscription<dynamic>? _nativeOpenInSubscription;
  final _fileController = StreamController<IncomingFile>.broadcast();

  /// Stream of incoming files (PDF or image).
  Stream<IncomingFile> get incomingFiles => _fileController.stream;

  /// Initialize the service and start listening for incoming files.
  void initialize() {
    // Handle files from receive_sharing_intent (Share Extension)
    _subscription = ReceiveSharingIntent.instance
        .getMediaStream()
        .listen(_handleSharedFiles, onError: (err) {
      if (kDebugMode) {
        print('Error receiving shared files: $err');
      }
    });

    // Handle files from native "Open In" handler (iOS direct file URLs)
    // Note: receive_sharing_intent doesn't support file:// URLs, so we handle them natively
    _nativeOpenInSubscription = _openInFilesChannel
        .receiveBroadcastStream()
        .listen(_handleNativeOpenInFile, onError: (err) {
      if (kDebugMode) {
        print('Error in native open_in_files channel: $err');
      }
    });

    // Handle files received when app was closed (via receive_sharing_intent)
    _checkInitialFile();
  }

  /// Handle file received from native "Open In" handler.
  void _handleNativeOpenInFile(dynamic event) {
    if (event is! Map) return;

    final path = event['path'] as String?;
    final name = event['name'] as String?;
    final mimeType = event['mimeType'] as String?;

    if (path == null || path.isEmpty) return;

    if (kDebugMode) {
      print('Received file via Open In: $path');
    }

    final lowerPath = path.toLowerCase();

    // Check if it's a PDF
    if (lowerPath.endsWith('.pdf') || mimeType == 'application/pdf') {
      _fileController.add(IncomingFile(
        path: path,
        type: IncomingFileType.pdf,
      ));
    }
    // Check if it's a supported image
    else if (ImageToPdfService.isImageFile(path) ||
        mimeType?.startsWith('image/') == true) {
      _fileController.add(IncomingFile(
        path: path,
        type: IncomingFileType.image,
        originalFileName: name ?? path.split('/').last,
      ));
    }
    // Unsupported file type - ignore silently
    else {
      if (kDebugMode) {
        print('Ignoring unsupported file type: $path');
      }
    }
  }

  /// Check for files that opened the app (cold start via receive_sharing_intent).
  Future<void> _checkInitialFile() async {
    final sharedFiles =
        await ReceiveSharingIntent.instance.getInitialMedia();
    _handleSharedFiles(sharedFiles);
    // Clear the intent to prevent re-opening the same file
    ReceiveSharingIntent.instance.reset();
  }

  void _handleSharedFiles(List<SharedMediaFile> files) {
    // Separate PDFs from images
    final pdfFiles = <SharedMediaFile>[];
    final imageFiles = <SharedMediaFile>[];

    for (final file in files) {
      final path = file.path;
      final lowerPath = path.toLowerCase();

      if (lowerPath.endsWith('.pdf')) {
        pdfFiles.add(file);
      } else if (ImageToPdfService.isImageFile(path)) {
        imageFiles.add(file);
      } else {
        if (kDebugMode) {
          print('Ignoring unsupported file type: $path');
        }
      }
    }

    // Emit PDFs individually
    for (final file in pdfFiles) {
      if (kDebugMode) {
        print('Received PDF file: ${file.path}');
      }
      _fileController.add(IncomingFile(
        path: file.path,
        type: IncomingFileType.pdf,
      ));
    }

    // Emit images as a batch (for multi-page PDF conversion)
    if (imageFiles.isNotEmpty) {
      final imagePaths = imageFiles.map((f) => f.path).toList();
      final firstFileName = imageFiles.first.path.split('/').last;

      if (kDebugMode) {
        print('Received ${imageFiles.length} image file(s)');
      }

      if (imageFiles.length == 1) {
        // Single image - use single image type
        _fileController.add(IncomingFile(
          path: imagePaths.first,
          type: IncomingFileType.image,
          originalFileName: firstFileName,
        ));
      } else {
        // Multiple images - create multi-page PDF
        _fileController.add(IncomingFile(
          path: imagePaths.first, // Primary path for reference
          type: IncomingFileType.multipleImages,
          originalFileName: firstFileName,
          imagePaths: imagePaths,
        ));
      }
    }
  }

  /// Dispose resources.
  void dispose() {
    _subscription?.cancel();
    _nativeOpenInSubscription?.cancel();
    _fileController.close();
  }
}
