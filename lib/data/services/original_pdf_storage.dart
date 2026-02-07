import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

/// Threshold for storing PDF in memory vs temp file.
const _memoryThreshold = 50 * 1024 * 1024; // 50 MB

/// Storage for original PDF bytes.
///
/// Stores the original PDF when a file is opened, allowing Save operations
/// to always use the original bytes (without previously embedded objects).
///
/// Small files (≤50MB) are stored in memory for fast access.
/// Large files (>50MB) are copied to a temp file to conserve RAM.
class OriginalPdfStorage {
  Uint8List? _inMemory;
  String? _tempFilePath;
  String? _originalFilePath;

  /// Stores the original PDF from the given path.
  ///
  /// If a previous PDF was stored, it will be disposed first.
  /// Returns false if the file doesn't exist or can't be read.
  Future<bool> store(String sourcePath) async {
    await dispose(); // Clean up any previous storage

    final file = File(sourcePath);
    if (!await file.exists()) {
      return false;
    }

    _originalFilePath = sourcePath;
    final size = await file.length();

    if (size <= _memoryThreshold) {
      // Small file — store in memory
      _inMemory = await file.readAsBytes();
    } else {
      // Large file — copy to temp file
      final tempDir = await getTemporaryDirectory();
      _tempFilePath =
          '${tempDir.path}/pdfsign_original_${DateTime.now().millisecondsSinceEpoch}.pdf';
      await file.copy(_tempFilePath!);
    }
    return true;
  }

  /// Stores pre-loaded PDF bytes directly (e.g. decrypted bytes).
  ///
  /// Use this when bytes are already in memory and don't need
  /// to be read from disk (e.g. after Syncfusion decryption).
  Future<void> storeBytes(Uint8List bytes, {String? filePath}) async {
    await dispose();

    _originalFilePath = filePath;

    if (bytes.length <= _memoryThreshold) {
      _inMemory = bytes;
    } else {
      final tempDir = await getTemporaryDirectory();
      _tempFilePath =
          '${tempDir.path}/pdfsign_original_${DateTime.now().millisecondsSinceEpoch}.pdf';
      await File(_tempFilePath!).writeAsBytes(bytes);
    }
  }

  /// Gets the original PDF bytes.
  ///
  /// Throws [StateError] if no PDF is stored or temp file was deleted.
  Future<Uint8List> getBytes() async {
    if (_inMemory != null) {
      return _inMemory!;
    }
    if (_tempFilePath != null) {
      final file = File(_tempFilePath!);
      if (!await file.exists()) {
        throw StateError('Temp file was deleted: $_tempFilePath');
      }
      return await file.readAsBytes();
    }
    throw StateError('No original PDF stored');
  }

  /// Returns the original file path (for display purposes).
  String? get originalFilePath => _originalFilePath;

  /// Whether any PDF is stored.
  bool get hasData => _inMemory != null || _tempFilePath != null;

  /// Whether the PDF is stored in memory (vs temp file).
  bool get isInMemory => _inMemory != null;

  /// Disposes the storage, freeing memory and deleting temp file.
  Future<void> dispose() async {
    _inMemory = null;
    _originalFilePath = null;
    if (_tempFilePath != null) {
      try {
        final file = File(_tempFilePath!);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (_) {
        // Ignore cleanup errors
      }
      _tempFilePath = null;
    }
  }
}
