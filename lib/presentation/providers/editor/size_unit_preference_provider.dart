import 'dart:ui' show PlatformDispatcher;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../native_settings_provider.dart';

/// Units for displaying object dimensions.
enum SizeUnit {
  /// Centimeters
  cm,

  /// Inches
  inch,
}

/// Provider for managing the preferred size unit (cm or inch).
///
/// Reads from native settings (UserDefaults on iOS, SharedPreferences on Android).
/// Falls back to region-based default if not explicitly set.
final sizeUnitPreferenceProvider = Provider<SizeUnit>((ref) {
  final nativeSettings = ref.watch(nativeSettingsProvider);
  final stored = nativeSettings.sizeUnitPreference;

  if (stored != null && stored.isNotEmpty) {
    return stored == 'inch' ? SizeUnit.inch : SizeUnit.cm;
  }

  // Default based on device region: USA uses inches
  return _getDefaultUnit();
});

/// Returns default unit based on device locale.
/// USA and other imperial-system countries → inches, all others → cm
SizeUnit _getDefaultUnit() {
  final locale = PlatformDispatcher.instance.locale;
  final countryCode = locale.countryCode?.toUpperCase();

  // Countries using imperial system: USA, Liberia, Myanmar
  const imperialCountries = {'US', 'LR', 'MM'};

  if (countryCode != null && imperialCountries.contains(countryCode)) {
    return SizeUnit.inch;
  }
  return SizeUnit.cm;
}

/// Provider for setting the size unit.
///
/// Use this to change the unit - it will update native settings.
final sizeUnitPreferenceNotifierProvider = Provider<SizeUnitPreferenceSetter>((ref) {
  return SizeUnitPreferenceSetter(ref);
});

/// Helper class for setting size unit preference.
class SizeUnitPreferenceSetter {
  SizeUnitPreferenceSetter(this._ref);

  final Ref _ref;

  /// Toggles between cm and inch.
  Future<void> toggle() async {
    final current = _ref.read(sizeUnitPreferenceProvider);
    final newUnit = current == SizeUnit.cm ? SizeUnit.inch : SizeUnit.cm;
    await setUnit(newUnit);
  }

  /// Sets the unit directly.
  Future<void> setUnit(SizeUnit unit) async {
    await _ref.read(nativeSettingsProvider.notifier).setSizeUnitPreference(unit.name);
  }

  /// Clears the preference (will use region-based default).
  Future<void> clear() async {
    await _ref.read(nativeSettingsProvider.notifier).setSizeUnitPreference(null);
  }
}
