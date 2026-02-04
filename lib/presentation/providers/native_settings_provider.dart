import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/native_settings_service.dart';

/// Cached native settings loaded at app startup.
///
/// This avoids async calls during provider initialization by pre-loading
/// the settings from native storage.
class NativeSettings {
  const NativeSettings({
    this.localePreference,
    this.sizeUnitPreference,
  });

  /// The locale preference from native settings.
  /// null or "system" means use system default.
  final String? localePreference;

  /// The size unit preference from native settings.
  /// null or empty means use default based on region.
  /// "cm" or "inch" for explicit setting.
  final String? sizeUnitPreference;

  /// Creates a copy with updated values.
  NativeSettings copyWith({
    String? localePreference,
    String? sizeUnitPreference,
    bool clearLocale = false,
    bool clearSizeUnit = false,
  }) {
    return NativeSettings(
      localePreference: clearLocale ? null : (localePreference ?? this.localePreference),
      sizeUnitPreference: clearSizeUnit ? null : (sizeUnitPreference ?? this.sizeUnitPreference),
    );
  }
}

/// Provider for native settings.
///
/// Must be overridden at app startup with pre-loaded values.
final nativeSettingsProvider = StateNotifierProvider<NativeSettingsNotifier, NativeSettings>(
  (ref) => throw UnimplementedError(
    'nativeSettingsProvider must be overridden with pre-loaded settings',
  ),
);

/// Notifier for native settings state.
class NativeSettingsNotifier extends StateNotifier<NativeSettings> {
  NativeSettingsNotifier(super.initial);

  /// Updates the locale preference.
  Future<void> setLocalePreference(String? value) async {
    final effectiveValue = (value == null || value == 'system') ? null : value;
    await NativeSettingsService.setString('locale_preference', effectiveValue ?? 'system');
    state = state.copyWith(
      localePreference: effectiveValue,
      clearLocale: effectiveValue == null,
    );
  }

  /// Updates the size unit preference.
  Future<void> setSizeUnitPreference(String? value) async {
    await NativeSettingsService.setString('size_unit_preference', value);
    state = state.copyWith(
      sizeUnitPreference: value,
      clearSizeUnit: value == null || value.isEmpty,
    );
  }

  /// Reloads settings from native storage.
  ///
  /// Call this when the app returns from background to pick up
  /// changes made in iOS Settings.
  Future<void> reload() async {
    final settings = await NativeSettingsService.getAll();
    final locale = settings['locale_preference'];
    final sizeUnit = settings['size_unit_preference'];

    state = NativeSettings(
      localePreference: (locale == null || locale == 'system') ? null : locale,
      sizeUnitPreference: (sizeUnit == null || sizeUnit.isEmpty) ? null : sizeUnit,
    );
  }
}

/// Loads native settings from platform storage.
///
/// Call this before runApp() to have settings ready synchronously.
Future<NativeSettings> loadNativeSettings() async {
  final settings = await NativeSettingsService.getAll();
  final locale = settings['locale_preference'];
  final sizeUnit = settings['size_unit_preference'];

  return NativeSettings(
    localePreference: (locale == null || locale == 'system') ? null : locale,
    sizeUnitPreference: (sizeUnit == null || sizeUnit.isEmpty) ? null : sizeUnit,
  );
}
