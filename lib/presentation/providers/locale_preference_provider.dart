import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:minipdfsign/presentation/providers/shared_preferences_provider.dart';

const _key = 'locale_preference';

/// Supported locales with their display names.
class SupportedLocale {
  const SupportedLocale({
    required this.code,
    required this.nativeName,
    required this.englishName,
    required this.locale,
  });

  /// Locale code (e.g., 'en_US', 'ru', 'ar')
  final String code;

  /// Native name (e.g., 'Русский', 'العربية')
  final String nativeName;

  /// English name (e.g., 'Russian', 'Arabic')
  final String englishName;

  /// Flutter Locale object
  final Locale locale;

  /// Display string for dropdown: "Native (English)"
  String get displayName {
    if (nativeName == englishName) {
      return nativeName;
    }
    return '$nativeName ($englishName)';
  }
}

/// All supported locales sorted alphabetically by native name.
/// System Default is handled separately.
const supportedLocales = <SupportedLocale>[
  // English variants first (sorted by region)
  SupportedLocale(code: 'en_AU', nativeName: 'English (Australia)', englishName: 'English (Australia)', locale: Locale('en', 'AU')),
  SupportedLocale(code: 'en_GB', nativeName: 'English (UK)', englishName: 'English (UK)', locale: Locale('en', 'GB')),
  SupportedLocale(code: 'en_NZ', nativeName: 'English (New Zealand)', englishName: 'English (New Zealand)', locale: Locale('en', 'NZ')),
  SupportedLocale(code: 'en_US', nativeName: 'English (US)', englishName: 'English (US)', locale: Locale('en', 'US')),
  // Rest sorted alphabetically by native name
  SupportedLocale(code: 'sq', nativeName: 'Shqip', englishName: 'Albanian', locale: Locale('sq')),
  SupportedLocale(code: 'ar', nativeName: 'العربية', englishName: 'Arabic', locale: Locale('ar')),
  SupportedLocale(code: 'hy', nativeName: 'Armenian', englishName: 'Armenian', locale: Locale('hy')),
  SupportedLocale(code: 'az', nativeName: 'Azərbaycan', englishName: 'Azerbaijani', locale: Locale('az')),
  SupportedLocale(code: 'eu', nativeName: 'Euskara', englishName: 'Basque', locale: Locale('eu')),
  SupportedLocale(code: 'be', nativeName: 'Беларуская', englishName: 'Belarusian', locale: Locale('be')),
  SupportedLocale(code: 'bn', nativeName: 'বাংলা', englishName: 'Bengali', locale: Locale('bn')),
  SupportedLocale(code: 'bg', nativeName: 'Български', englishName: 'Bulgarian', locale: Locale('bg')),
  SupportedLocale(code: 'my', nativeName: 'မြန်မာ', englishName: 'Burmese', locale: Locale('my')),
  SupportedLocale(code: 'ca', nativeName: 'Català', englishName: 'Catalan', locale: Locale('ca')),
  SupportedLocale(code: 'hr', nativeName: 'Hrvatski', englishName: 'Croatian', locale: Locale('hr')),
  SupportedLocale(code: 'cs', nativeName: 'Čeština', englishName: 'Czech', locale: Locale('cs')),
  SupportedLocale(code: 'da', nativeName: 'Dansk', englishName: 'Danish', locale: Locale('da')),
  SupportedLocale(code: 'nl', nativeName: 'Nederlands', englishName: 'Dutch', locale: Locale('nl')),
  SupportedLocale(code: 'eo', nativeName: 'Esperanto', englishName: 'Esperanto', locale: Locale('eo')),
  SupportedLocale(code: 'et', nativeName: 'Eesti', englishName: 'Estonian', locale: Locale('et')),
  SupportedLocale(code: 'fil', nativeName: 'Filipino', englishName: 'Filipino', locale: Locale('fil')),
  SupportedLocale(code: 'fi', nativeName: 'Suomi', englishName: 'Finnish', locale: Locale('fi')),
  SupportedLocale(code: 'fr', nativeName: 'Français', englishName: 'French', locale: Locale('fr')),
  SupportedLocale(code: 'ka', nativeName: 'ქართული', englishName: 'Georgian', locale: Locale('ka')),
  SupportedLocale(code: 'de', nativeName: 'Deutsch', englishName: 'German', locale: Locale('de')),
  SupportedLocale(code: 'el', nativeName: 'Ελληνικά', englishName: 'Greek', locale: Locale('el')),
  SupportedLocale(code: 'he', nativeName: 'עברית', englishName: 'Hebrew', locale: Locale('he')),
  SupportedLocale(code: 'hi', nativeName: 'हिन्दी', englishName: 'Hindi', locale: Locale('hi')),
  SupportedLocale(code: 'hu', nativeName: 'Magyar', englishName: 'Hungarian', locale: Locale('hu')),
  SupportedLocale(code: 'is', nativeName: 'Íslenska', englishName: 'Icelandic', locale: Locale('is')),
  SupportedLocale(code: 'id', nativeName: 'Bahasa Indonesia', englishName: 'Indonesian', locale: Locale('id')),
  SupportedLocale(code: 'it', nativeName: 'Italiano', englishName: 'Italian', locale: Locale('it')),
  SupportedLocale(code: 'kk', nativeName: 'Қазақ', englishName: 'Kazakh', locale: Locale('kk')),
  SupportedLocale(code: 'km', nativeName: 'ខ្មែរ', englishName: 'Khmer', locale: Locale('km')),
  SupportedLocale(code: 'lv', nativeName: 'Latviešu', englishName: 'Latvian', locale: Locale('lv')),
  SupportedLocale(code: 'lt', nativeName: 'Lietuvių', englishName: 'Lithuanian', locale: Locale('lt')),
  SupportedLocale(code: 'ms', nativeName: 'Bahasa Melayu', englishName: 'Malay', locale: Locale('ms')),
  SupportedLocale(code: 'mn', nativeName: 'Монгол', englishName: 'Mongolian', locale: Locale('mn')),
  SupportedLocale(code: 'nb', nativeName: 'Norsk', englishName: 'Norwegian', locale: Locale('nb')),
  SupportedLocale(code: 'fa', nativeName: 'فارسی', englishName: 'Persian', locale: Locale('fa')),
  SupportedLocale(code: 'pl', nativeName: 'Polski', englishName: 'Polish', locale: Locale('pl')),
  SupportedLocale(code: 'pt_BR', nativeName: 'Português (Brasil)', englishName: 'Portuguese (Brazil)', locale: Locale('pt', 'BR')),
  SupportedLocale(code: 'pt_PT', nativeName: 'Português (Portugal)', englishName: 'Portuguese (Portugal)', locale: Locale('pt', 'PT')),
  SupportedLocale(code: 'ro', nativeName: 'Română', englishName: 'Romanian', locale: Locale('ro')),
  SupportedLocale(code: 'ru', nativeName: 'Русский', englishName: 'Russian', locale: Locale('ru')),
  SupportedLocale(code: 'sr', nativeName: 'Српски', englishName: 'Serbian', locale: Locale('sr')),
  SupportedLocale(code: 'sk', nativeName: 'Slovenčina', englishName: 'Slovak', locale: Locale('sk')),
  SupportedLocale(code: 'sl', nativeName: 'Slovenščina', englishName: 'Slovenian', locale: Locale('sl')),
  SupportedLocale(code: 'es_AR', nativeName: 'Español (Argentina)', englishName: 'Spanish (Argentina)', locale: Locale('es', 'AR')),
  SupportedLocale(code: 'es_ES', nativeName: 'Español (España)', englishName: 'Spanish (Spain)', locale: Locale('es', 'ES')),
  SupportedLocale(code: 'es_MX', nativeName: 'Español (México)', englishName: 'Spanish (Mexico)', locale: Locale('es', 'MX')),
  SupportedLocale(code: 'sv', nativeName: 'Svenska', englishName: 'Swedish', locale: Locale('sv')),
  SupportedLocale(code: 'ta', nativeName: 'தமிழ்', englishName: 'Tamil', locale: Locale('ta')),
  SupportedLocale(code: 'th', nativeName: 'ไทย', englishName: 'Thai', locale: Locale('th')),
  SupportedLocale(code: 'tr', nativeName: 'Türkçe', englishName: 'Turkish', locale: Locale('tr')),
  SupportedLocale(code: 'uk', nativeName: 'Українська', englishName: 'Ukrainian', locale: Locale('uk')),
  SupportedLocale(code: 'uz', nativeName: "O'zbek", englishName: 'Uzbek', locale: Locale('uz')),
  SupportedLocale(code: 'vi', nativeName: 'Tiếng Việt', englishName: 'Vietnamese', locale: Locale('vi')),
];

/// List of all supported Flutter Locales for MaterialApp.
final allSupportedLocales = supportedLocales.map((e) => e.locale).toList();

/// RTL (Right-to-Left) language codes.
const rtlLanguageCodes = {'ar', 'he', 'fa'};

/// Returns true if the given locale uses RTL text direction.
bool isRtlLocale(Locale? locale) {
  if (locale == null) return false;
  return rtlLanguageCodes.contains(locale.languageCode);
}

/// Provider for managing the preferred locale.
///
/// Persists the preference in SharedPreferences.
/// null or 'system' means use system locale.
final localePreferenceProvider =
    NotifierProvider<LocalePreferenceNotifier, String?>(
  LocalePreferenceNotifier.new,
);

/// Notifier for locale preference state.
class LocalePreferenceNotifier extends Notifier<String?> {
  @override
  String? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final stored = prefs.getString(_key);
    if (stored == null || stored == 'system') {
      return null; // System default
    }
    return stored;
  }

  /// Sets the locale. Pass null for system default.
  void setLocale(String? localeCode) {
    final prefs = ref.read(sharedPreferencesProvider);
    if (localeCode == null) {
      prefs.setString(_key, 'system');
    } else {
      prefs.setString(_key, localeCode);
    }
    state = localeCode;
  }

  /// Reloads the preference from SharedPreferences.
  ///
  /// Call this when receiving a broadcast from another window
  /// to sync with changes made there.
  Future<void> reload() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.reload(); // Refresh cache from disk
    final stored = prefs.getString(_key);
    final newLocale = (stored == null || stored == 'system') ? null : stored;
    if (state != newLocale) {
      state = newLocale;
    }
  }

  /// Gets the actual Locale to use.
  /// Returns null if system default should be used.
  Locale? getLocale() {
    if (state == null) {
      return null; // Let Flutter use system locale
    }
    // Find the locale in supported locales
    for (final supported in supportedLocales) {
      if (supported.code == state) {
        return supported.locale;
      }
    }
    return null;
  }
}
