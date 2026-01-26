import 'dart:collection';
import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:minipdfsign/core/errors/failures.dart';
import 'package:minipdfsign/presentation/providers/repository_providers.dart';

part 'pdf_page_cache_provider.g.dart';

/// Quantizes scale to 2 decimal places to avoid floating-point key mismatches.
///
/// Without quantization, scale 1.5 and 1.5000001 would create different cache keys,
/// causing cache misses during rapid zooming.
String _quantizedScale(double scale) => scale.toStringAsFixed(2);

/// Cache entry for a rendered PDF page.
class PageCacheEntry {
  PageCacheEntry({
    required this.pageNumber,
    required this.scale,
    required this.bytes,
  }) : timestamp = DateTime.now();

  final int pageNumber;
  final double scale;
  final Uint8List bytes;
  final DateTime timestamp;

  /// Cache key combining page number and quantized scale.
  String get key => '${pageNumber}_${_quantizedScale(scale)}';
}

/// LRU cache for rendered PDF pages.
///
/// Keeps up to [maxCacheSize] pages in memory, evicting least recently
/// used entries when the limit is exceeded.
class PdfPageCache {
  PdfPageCache({this.maxCacheSize = 10});

  final int maxCacheSize;
  final LinkedHashMap<String, PageCacheEntry> _cache = LinkedHashMap();

  /// Gets a cached page, or null if not found.
  /// Updates LRU order if found.
  PageCacheEntry? get(int pageNumber, double scale) {
    final key = '${pageNumber}_${_quantizedScale(scale)}';
    final entry = _cache.remove(key);
    if (entry != null) {
      // Re-insert to update LRU order
      _cache[key] = entry;
    }
    return entry;
  }

  /// Adds or updates a page in the cache.
  void put(PageCacheEntry entry) {
    final key = entry.key;

    // Remove existing entry if present
    _cache.remove(key);

    // Evict oldest entries if at capacity
    while (_cache.length >= maxCacheSize) {
      _cache.remove(_cache.keys.first);
    }

    _cache[key] = entry;
  }

  /// Removes a specific page from the cache.
  void remove(int pageNumber, double scale) {
    final key = '${pageNumber}_${_quantizedScale(scale)}';
    _cache.remove(key);
  }

  /// Removes all entries for a specific page (all scales).
  void removeAllForPage(int pageNumber) {
    // Use regex to match exact page number followed by underscore
    // This prevents "1_" from matching "12_" or "10_"
    final pattern = RegExp('^${pageNumber}_');
    _cache.removeWhere((key, _) => pattern.hasMatch(key));
  }

  /// Clears all cached pages.
  void clear() {
    _cache.clear();
  }

  /// Returns true if the page is cached at the given scale.
  bool contains(int pageNumber, double scale) {
    final key = '${pageNumber}_${_quantizedScale(scale)}';
    return _cache.containsKey(key);
  }

  /// Number of entries in the cache.
  int get length => _cache.length;
}

/// Provider for the PDF page cache.
@Riverpod(keepAlive: true)
PdfPageCache pdfPageCache(PdfPageCacheRef ref) {
  return PdfPageCache();
}

/// Exception thrown when render is cancelled (not an error, just retry later).
class PageRenderCancelledException implements Exception {
  final int pageNumber;
  PageRenderCancelledException(this.pageNumber);

  @override
  String toString() => 'Render cancelled for page $pageNumber';
}

/// Provider for rendering a PDF page with caching.
///
/// Returns the rendered page bytes, using cache if available.
/// The [pageNumber] parameter is 1-based.
///
/// Throws [PageRenderCancelledException] if the render was cancelled
/// (this is not an error - the page should show placeholder and retry).
@riverpod
Future<Uint8List> pdfPageImage(
  PdfPageImageRef ref, {
  required int pageNumber,
  required double scale,
}) async {
  final cache = ref.watch(pdfPageCacheProvider);
  final repository = ref.watch(pdfDocumentRepositoryProvider);

  // Check cache first
  final cached = cache.get(pageNumber, scale);
  if (cached != null) {
    return cached.bytes;
  }

  // Render the page
  final result = await repository.renderPage(
    pageNumber: pageNumber,
    scale: scale,
  );

  return result.fold(
    (failure) {
      // Check if this was a cancellation (not a real error)
      if (failure is RenderCancelledFailure) {
        throw PageRenderCancelledException(failure.pageNumber);
      }
      // For real errors, throw an exception
      throw Exception('Failed to render page $pageNumber: ${failure.message}');
    },
    (bytes) {
      // Cache the result
      cache.put(PageCacheEntry(
        pageNumber: pageNumber,
        scale: scale,
        bytes: bytes,
      ));
      return bytes;
    },
  );
}

/// Provider for tracking which pages should be rendered.
///
/// Pages within the visible range plus buffer are rendered,
/// others are cancelled.
@riverpod
class VisiblePages extends _$VisiblePages {
  static const int _bufferSize = 2;

  @override
  Set<int> build() {
    return {};
  }

  /// Updates the visible page range based on scroll position.
  void updateVisibleRange({
    required int firstVisible,
    required int lastVisible,
    required int totalPages,
  }) {
    final start = (firstVisible - _bufferSize).clamp(1, totalPages);
    final end = (lastVisible + _bufferSize).clamp(1, totalPages);

    final newVisible = <int>{};
    for (int i = start; i <= end; i++) {
      newVisible.add(i);
    }

    // Cancel renders for pages no longer in range
    final repository = ref.read(pdfDocumentRepositoryProvider);
    for (final pageNumber in state) {
      if (!newVisible.contains(pageNumber)) {
        repository.cancelRender(pageNumber);
      }
    }

    state = newVisible;
  }

  /// Checks if a page should be rendered.
  bool shouldRender(int pageNumber) {
    return state.contains(pageNumber);
  }
}
