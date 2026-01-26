import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:minipdfsign/presentation/providers/editor/size_unit_preference_provider.dart';

/// Widget displaying object dimensions below the selected image.
///
/// Shows width and height in cm or inch format.
/// Clicking toggles between cm and inch.
/// First dimension is the size of the bottom edge.
class SizeLabel extends ConsumerWidget {
  const SizeLabel({
    required this.firstDimension,
    required this.secondDimension,
    super.key,
  });

  /// Size of the bottom edge in PDF points (1/72 inch).
  final double firstDimension;

  /// Size of the perpendicular edge in PDF points.
  final double secondDimension;

  /// PDF points per inch.
  static const _pointsPerInch = 72.0;

  /// Centimeters per inch.
  static const _cmPerInch = 2.54;

  String _formatSize(SizeUnit unit) {
    if (unit == SizeUnit.inch) {
      final first = (firstDimension / _pointsPerInch).toStringAsFixed(1);
      final second = (secondDimension / _pointsPerInch).toStringAsFixed(1);
      return '$first × $second in';
    } else {
      final first =
          (firstDimension / _pointsPerInch * _cmPerInch).toStringAsFixed(1);
      final second =
          (secondDimension / _pointsPerInch * _cmPerInch).toStringAsFixed(1);
      return '$first × $second cm';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unit = ref.watch(sizeUnitPreferenceProvider);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => ref.read(sizeUnitPreferenceProvider.notifier).toggle(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF0066FF).withOpacity(0.7),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            _formatSize(unit),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ),
    );
  }
}
