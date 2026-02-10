import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/utils/logger.dart';

/// Service for reading image data from the system clipboard.
///
/// Uses a native platform channel to access clipboard image content
/// on iOS (UIPasteboard) and Android (ClipboardManager).
/// Returns the path to a temporary PNG file if an image is found.
class ClipboardImageService {
  static const _channel = MethodChannel(
    'com.ivanvaganov.minipdfsign/clipboard',
  );

  /// Reads image data from the system clipboard.
  ///
  /// Returns the file path to a temporary PNG image if the clipboard
  /// contains image data, or `null` if no image is available.
  ///
  /// The returned file is saved in the app's temporary directory
  /// and should be processed (validated/normalized) before use.
  Future<String?> getClipboardImage() async {
    try {
      final imageBytes =
          await _channel.invokeMethod<Uint8List>('getImage');

      if (imageBytes == null || imageBytes.isEmpty) {
        AppLogger.debug('No image data in clipboard');
        return null;
      }

      // Save to temporary file
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final tempFile = File('${tempDir.path}/clipboard_$timestamp.png');
      await tempFile.writeAsBytes(imageBytes);

      AppLogger.debug(
        'Clipboard image saved: ${tempFile.path} '
        '(${imageBytes.length} bytes)',
      );
      return tempFile.path;
    } on PlatformException catch (e) {
      AppLogger.error('Failed to read clipboard image', e);
      return null;
    } on Exception catch (e, stackTrace) {
      AppLogger.error('Clipboard image error', e, stackTrace);
      return null;
    }
  }
}
