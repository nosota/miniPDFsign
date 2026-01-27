import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

/// Service for handling incoming files from "Open In" and Share sheet.
class IncomingFileService {
  StreamSubscription<List<SharedMediaFile>>? _subscription;
  final _fileController = StreamController<String>.broadcast();

  /// Stream of incoming PDF file paths.
  Stream<String> get incomingFiles => _fileController.stream;

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
      // Only handle PDF files
      if (path.toLowerCase().endsWith('.pdf')) {
        if (kDebugMode) {
          print('Received PDF file: $path');
        }
        _fileController.add(path);
      }
    }
  }

  /// Dispose resources.
  void dispose() {
    _subscription?.cancel();
    _fileController.close();
  }
}
