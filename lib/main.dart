import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:minipdfsign/core/theme/app_theme.dart';
import 'package:minipdfsign/data/models/sidebar_image_model.dart';
import 'package:minipdfsign/l10n/generated/app_localizations.dart';
import 'package:minipdfsign/presentation/providers/data_source_providers.dart';
import 'package:minipdfsign/presentation/providers/locale_preference_provider.dart';
import 'package:minipdfsign/presentation/providers/shared_preferences_provider.dart';
import 'package:minipdfsign/presentation/screens/home/home_screen.dart';

/// Application entry point for mobile (iOS/Android).
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  final sharedPrefs = await SharedPreferences.getInstance();
  final isar = await _initializeIsar();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        isarProvider.overrideWithValue(isar),
      ],
      child: const MiniPdfSignApp(),
    ),
  );
}

/// Initializes Isar database for local storage.
Future<Isar> _initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open(
    [SidebarImageModelSchema],
    directory: dir.path,
    name: 'minipdfsign',
  );
}

/// Root application widget.
class MiniPdfSignApp extends ConsumerWidget {
  const MiniPdfSignApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeCode = ref.watch(localePreferenceProvider);

    // Get the actual Locale from locale code
    Locale? locale;
    if (localeCode != null) {
      for (final supported in supportedLocales) {
        if (supported.code == localeCode) {
          locale = supported.locale;
          break;
        }
      }
    }

    return MaterialApp(
      title: 'miniPDFSign',
      theme: createAppTheme(),
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
