import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:minipdfsign/core/theme/app_theme.dart';
import 'package:minipdfsign/data/models/sidebar_image_model.dart';
import 'package:minipdfsign/data/services/incoming_file_service.dart';
import 'package:minipdfsign/domain/entities/recent_file.dart';
import 'package:minipdfsign/l10n/generated/app_localizations.dart';
import 'package:minipdfsign/presentation/providers/data_source_providers.dart';
import 'package:minipdfsign/presentation/providers/editor/file_source_provider.dart';
import 'package:minipdfsign/presentation/providers/locale_preference_provider.dart';
import 'package:minipdfsign/presentation/providers/recent_files_provider.dart';
import 'package:minipdfsign/presentation/providers/shared_preferences_provider.dart';
import 'package:minipdfsign/presentation/screens/home/home_screen.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/pdf_viewer_screen.dart';

/// Global navigator key for navigation from outside widget tree.
final navigatorKey = GlobalKey<NavigatorState>();

/// Application entry point for mobile (iOS/Android).
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  final sharedPrefs = await SharedPreferences.getInstance();
  final isar = await _initializeIsar();
  final incomingFileService = IncomingFileService();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        isarProvider.overrideWithValue(isar),
      ],
      child: MiniPdfSignApp(incomingFileService: incomingFileService),
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
class MiniPdfSignApp extends ConsumerStatefulWidget {
  const MiniPdfSignApp({
    required this.incomingFileService,
    super.key,
  });

  final IncomingFileService incomingFileService;

  @override
  ConsumerState<MiniPdfSignApp> createState() => _MiniPdfSignAppState();
}

class _MiniPdfSignAppState extends ConsumerState<MiniPdfSignApp> {
  StreamSubscription<String>? _incomingFileSubscription;

  @override
  void initState() {
    super.initState();
    // Initialize incoming file handling
    widget.incomingFileService.initialize();

    // Listen for incoming files
    _incomingFileSubscription =
        widget.incomingFileService.incomingFiles.listen(_handleIncomingFile);
  }

  @override
  void dispose() {
    _incomingFileSubscription?.cancel();
    widget.incomingFileService.dispose();
    super.dispose();
  }

  void _handleIncomingFile(String filePath) {
    // Wait for navigator to be ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navigator = navigatorKey.currentState;
      if (navigator == null) return;

      // Mark file as opened from Files app (can be overwritten)
      ref.read(fileSourceProvider.notifier).setFilesApp();

      // Add to recent files
      ref.read(recentFilesProvider.notifier).addFile(
            RecentFile(
              path: filePath,
              fileName: filePath.split('/').last,
              lastOpened: DateTime.now(),
              pageCount: 0,
              isPasswordProtected: false,
            ),
          );

      // Navigate to PDF viewer
      navigator.push(
        MaterialPageRoute<void>(
          builder: (context) => PdfViewerScreen(filePath: filePath),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
      navigatorKey: navigatorKey,
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
