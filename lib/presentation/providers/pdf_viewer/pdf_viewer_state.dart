import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:minipdfsign/domain/entities/pdf_document_info.dart';

part 'pdf_viewer_state.freezed.dart';

/// Predefined zoom levels for quick selection.
enum ZoomPreset {
  fitWidth('Fit Width'),
  percent50('50%'),
  percent75('75%'),
  percent100('100%'),
  percent125('125%'),
  percent150('150%'),
  percent200('200%'),
  percent300('300%'),
  percent400('400%'),
  percent500('500%'),
  custom('Custom');

  const ZoomPreset(this.label);

  final String label;

  /// Returns the scale value for this preset, or null for fitWidth/custom.
  double? get scale => switch (this) {
        ZoomPreset.fitWidth => null,
        ZoomPreset.percent50 => 0.5,
        ZoomPreset.percent75 => 0.75,
        ZoomPreset.percent100 => 1.0,
        ZoomPreset.percent125 => 1.25,
        ZoomPreset.percent150 => 1.5,
        ZoomPreset.percent200 => 2.0,
        ZoomPreset.percent300 => 3.0,
        ZoomPreset.percent400 => 4.0,
        ZoomPreset.percent500 => 5.0,
        ZoomPreset.custom => null,
      };

  /// Returns the next preset (for Cmd+ zoom).
  ZoomPreset? get next {
    final presets = ZoomPreset.values.where((p) => p != ZoomPreset.custom).toList();
    final index = presets.indexOf(this);
    if (index >= 0 && index < presets.length - 1) {
      return presets[index + 1];
    }
    return null;
  }

  /// Returns the previous preset (for Cmd- zoom).
  ZoomPreset? get previous {
    final presets = ZoomPreset.values.where((p) => p != ZoomPreset.custom).toList();
    final index = presets.indexOf(this);
    if (index > 0) {
      return presets[index - 1];
    }
    return null;
  }

  /// Finds the nearest preset for a given scale value.
  static ZoomPreset nearestPreset(double scale) {
    final presets = ZoomPreset.values.where((p) => p.scale != null).toList();
    ZoomPreset nearest = ZoomPreset.percent100;
    double minDiff = double.infinity;

    for (final preset in presets) {
      final diff = (preset.scale! - scale).abs();
      if (diff < minDiff) {
        minDiff = diff;
        nearest = preset;
      }
    }

    return nearest;
  }

  /// Finds the next higher preset for a given scale value.
  static ZoomPreset? nextPresetAbove(double scale) {
    final presets = ZoomPreset.values
        .where((p) => p.scale != null)
        .toList()
      ..sort((a, b) => a.scale!.compareTo(b.scale!));

    for (final preset in presets) {
      if (preset.scale! > scale + 0.01) {
        return preset;
      }
    }
    return null;
  }

  /// Finds the next lower preset for a given scale value.
  static ZoomPreset? nextPresetBelow(double scale) {
    final presets = ZoomPreset.values
        .where((p) => p.scale != null)
        .toList()
      ..sort((a, b) => b.scale!.compareTo(a.scale!));

    for (final preset in presets) {
      if (preset.scale! < scale - 0.01) {
        return preset;
      }
    }
    return null;
  }
}

/// Zoom constraints for the PDF viewer.
abstract final class ZoomConstraints {
  static const double minScale = 0.1;
  static const double maxScale = 5.0;
  static const double zoomStep = 0.1;
}

/// State for the PDF viewer.
@freezed
class PdfViewerState with _$PdfViewerState {
  const factory PdfViewerState.initial() = PdfViewerInitial;

  const factory PdfViewerState.loading({
    required String filePath,
  }) = PdfViewerLoading;

  const factory PdfViewerState.converting({
    required int imageCount,
  }) = PdfViewerConverting;

  const factory PdfViewerState.loaded({
    required PdfDocumentInfo document,
    /// Current scale factor (actual rendered scale).
    required double scale,
    /// Whether currently in "fit to width" mode.
    @Default(true) bool isFitWidth,
    /// The scale value when in fitWidth mode.
    required double fitWidthScale,
    /// Current page number (1-based).
    required int currentPage,
    /// Viewport dimensions.
    required double viewportWidth,
    required double viewportHeight,
  }) = PdfViewerLoaded;

  const factory PdfViewerState.error({
    required String message,
    String? filePath,
  }) = PdfViewerError;

  const factory PdfViewerState.passwordRequired({
    required String filePath,
  }) = PdfViewerPasswordRequired;
}

/// Extension to add convenience methods to PdfViewerState.
extension PdfViewerStateX on PdfViewerState {
  /// Returns the current document info if loaded.
  PdfDocumentInfo? get documentOrNull => maybeMap(
        loaded: (state) => state.document,
        orElse: () => null,
      );

  /// Returns the current scale if loaded.
  double? get scaleOrNull => maybeMap(
        loaded: (state) => state.scale,
        orElse: () => null,
      );

  /// Returns whether a document is loaded.
  bool get isLoaded => this is PdfViewerLoaded;

  /// Returns whether the viewer is in loading state.
  bool get isLoading => this is PdfViewerLoading;

  /// Returns whether the viewer is converting images.
  bool get isConverting => this is PdfViewerConverting;

  /// Returns whether there's an error.
  bool get hasError => this is PdfViewerError;

  /// Returns the current zoom preset based on scale.
  ZoomPreset get currentPreset => maybeMap(
        loaded: (state) {
          if (state.isFitWidth) return ZoomPreset.fitWidth;
          return ZoomPreset.nearestPreset(state.scale);
        },
        orElse: () => ZoomPreset.fitWidth,
      );

  /// Returns display label for current zoom.
  String get zoomLabel => maybeMap(
        loaded: (state) {
          if (state.isFitWidth) return 'Fit Width';
          final percent = (state.scale * 100).round();
          return '$percent%';
        },
        orElse: () => 'Fit Width',
      );
}
