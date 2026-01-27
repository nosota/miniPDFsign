import 'dart:io';

import 'package:flutter/services.dart';
import 'package:minipdfsign/core/utils/logger.dart';

/// Result of resolving a bookmark.
class BookmarkResolution {
  final String path;
  final bool isStale;

  const BookmarkResolution({
    required this.path,
    required this.isStale,
  });
}

/// Service for managing file bookmarks for persistent file access.
///
/// On iOS: Uses Security-Scoped Bookmarks to maintain access to files
/// outside the app sandbox across app launches.
///
/// On Android: Uses Persistable URI Permissions to maintain access
/// to content URIs across app launches.
class FileBookmarkService {
  static const _channel = MethodChannel('com.ivanvaganov.minipdfsign/file_bookmarks');

  /// Creates a bookmark for persistent file access.
  ///
  /// Returns base64-encoded bookmark data that can be stored and used
  /// later to regain access to the file.
  ///
  /// On iOS: Creates a security-scoped bookmark.
  /// On Android: Takes persistable URI permission and returns encoded URI.
  ///
  /// Returns null if bookmark creation fails.
  Future<String?> createBookmark(String filePath, {String? contentUri}) async {
    if (!Platform.isIOS && !Platform.isAndroid) {
      // On desktop platforms, just return the path as-is
      // Desktop apps typically have broader file access
      return filePath;
    }

    try {
      final result = await _channel.invokeMethod<String>('createBookmark', {
        'filePath': filePath,
        if (contentUri != null) 'contentUri': contentUri,
      });
      AppLogger.debug('Created bookmark for: $filePath');
      return result;
    } on PlatformException catch (e) {
      AppLogger.error('Failed to create bookmark', e);
      return null;
    }
  }

  /// Resolves a bookmark to get the current file path.
  ///
  /// Returns the resolved path and whether the bookmark is stale.
  /// A stale bookmark means the file was moved/renamed and a new
  /// bookmark should be created.
  ///
  /// Returns null if resolution fails completely.
  Future<BookmarkResolution?> resolveBookmark(String bookmarkData) async {
    if (!Platform.isIOS && !Platform.isAndroid) {
      // On desktop, the bookmark IS the path
      return BookmarkResolution(
        path: bookmarkData,
        isStale: !File(bookmarkData).existsSync(),
      );
    }

    try {
      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>('resolveBookmark', {
        'bookmarkData': bookmarkData,
      });

      if (result == null) return null;

      return BookmarkResolution(
        path: result['path'] as String,
        isStale: result['isStale'] as bool,
      );
    } on PlatformException catch (e) {
      AppLogger.error('Failed to resolve bookmark', e);
      return null;
    }
  }

  /// Starts accessing a security-scoped resource.
  ///
  /// On iOS: Must be called before reading/writing to the file.
  /// On Android: Verifies that permission is still valid.
  ///
  /// Returns true if access was granted successfully.
  Future<bool> startAccessing(String filePath) async {
    if (!Platform.isIOS && !Platform.isAndroid) {
      return File(filePath).existsSync();
    }

    try {
      final result = await _channel.invokeMethod<bool>('startAccessing', {
        'filePath': filePath,
      });
      return result ?? false;
    } on PlatformException catch (e) {
      AppLogger.error('Failed to start accessing', e);
      return false;
    }
  }

  /// Stops accessing a security-scoped resource.
  ///
  /// On iOS: Releases the security scope. Should be called when done
  /// with the file to avoid resource leaks.
  /// On Android: No-op (permissions persist automatically).
  Future<void> stopAccessing(String filePath) async {
    if (!Platform.isIOS && !Platform.isAndroid) {
      return;
    }

    try {
      await _channel.invokeMethod<void>('stopAccessing', {
        'filePath': filePath,
      });
    } on PlatformException catch (e) {
      AppLogger.error('Failed to stop accessing', e);
    }
  }

  /// Checks if a bookmark is stale (file moved/renamed).
  ///
  /// Returns true if the bookmark is stale and needs to be recreated.
  Future<bool> isBookmarkStale(String bookmarkData) async {
    if (!Platform.isIOS && !Platform.isAndroid) {
      return !File(bookmarkData).existsSync();
    }

    try {
      final result = await _channel.invokeMethod<bool>('isBookmarkStale', {
        'bookmarkData': bookmarkData,
      });
      return result ?? true;
    } on PlatformException catch (e) {
      AppLogger.error('Failed to check bookmark staleness', e);
      return true;
    }
  }

  /// Opens a file with bookmark, handling the full access lifecycle.
  ///
  /// 1. Resolves the bookmark to get current path
  /// 2. Starts accessing the security-scoped resource
  /// 3. Returns the path for use
  ///
  /// The caller should call [stopAccessing] when done with the file.
  ///
  /// Returns null if the file cannot be accessed.
  Future<String?> openWithBookmark(String bookmarkData) async {
    // Resolve bookmark to get current path
    final resolution = await resolveBookmark(bookmarkData);
    if (resolution == null) {
      AppLogger.warning('Failed to resolve bookmark');
      return null;
    }

    if (resolution.isStale) {
      AppLogger.warning('Bookmark is stale, file may have been moved');
      // Still try to access - the path might still work
    }

    // Start accessing the resource
    final canAccess = await startAccessing(resolution.path);
    if (!canAccess) {
      AppLogger.warning('Cannot access file: ${resolution.path}');
      return null;
    }

    return resolution.path;
  }
}
