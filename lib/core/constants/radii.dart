import 'package:flutter/widgets.dart';

/// Border radius constants.
///
/// Per REQUIREMENTS.md UI-1.4.
abstract final class Radii {
  /// For inputs, small buttons.
  static const double small = 4.0;

  /// For buttons, chips.
  static const double medium = 6.0;

  /// For cards, panels.
  static const double large = 8.0;

  /// For dialogs, bottom sheets.
  static const double xlarge = 12.0;

  // Pre-built BorderRadius instances for convenience.
  static final BorderRadius smallRadius = BorderRadius.circular(small);
  static final BorderRadius mediumRadius = BorderRadius.circular(medium);
  static final BorderRadius largeRadius = BorderRadius.circular(large);
  static final BorderRadius xlargeRadius = BorderRadius.circular(xlarge);
}
