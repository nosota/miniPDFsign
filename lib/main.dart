import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:minipdfsign/core/theme/app_theme.dart';
import 'package:minipdfsign/data/models/sidebar_image_model.dart';
import 'package:minipdfsign/data/services/incoming_file_service.dart';
import 'package:minipdfsign/l10n/generated/app_localizations.dart';
import 'package:minipdfsign/presentation/providers/data_source_providers.dart';
import 'package:minipdfsign/presentation/providers/editor/file_source_provider.dart';
import 'package:minipdfsign/presentation/providers/locale_preference_provider.dart';
import 'package:minipdfsign/presentation/providers/native_settings_provider.dart';
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

  // Load native settings (iOS UserDefaults / Android SharedPreferences)
  // This is needed for iOS Settings.bundle integration
  final nativeSettings = await loadNativeSettings();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        isarProvider.overrideWithValue(isar),
        nativeSettingsProvider.overrideWith(
          (ref) => NativeSettingsNotifier(nativeSettings),
        ),
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

class _MiniPdfSignAppState extends ConsumerState<MiniPdfSignApp>
    with WidgetsBindingObserver {
  StreamSubscription<IncomingFile>? _incomingFileSubscription;

  @override
  void initState() {
    super.initState();

    // Register lifecycle observer to reload settings when app resumes (iOS)
    WidgetsBinding.instance.addObserver(this);

    // IMPORTANT: Set up listener BEFORE initialize() to avoid race condition.
    // initialize() calls _checkInitialFile() which immediately emits files.
    // If we subscribe after initialize(), we miss files that opened the app.
    _incomingFileSubscription =
        widget.incomingFileService.incomingFiles.listen(_handleIncomingFile);

    // Now initialize - any emitted files will be caught by the listener above
    widget.incomingFileService.initialize();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _incomingFileSubscription?.cancel();
    widget.incomingFileService.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // On iOS, reload settings when app resumes to pick up changes
    // made in the system Settings app
    if (state == AppLifecycleState.resumed && Platform.isIOS) {
      ref.read(nativeSettingsProvider.notifier).reload();
    }
  }

  Future<void> _handleIncomingFile(IncomingFile incomingFile) async {
    if (kDebugMode) {
      print('Incoming file: ${incomingFile.path} (${incomingFile.type})');
    }

    // Wait for navigator to be ready
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final navigator = navigatorKey.currentState;
      if (navigator == null) {
        if (kDebugMode) {
          print('Navigator not ready, cannot open file');
        }
        return;
      }

      // Note: We intentionally do NOT add shared files to Recent Files.
      // Files from Share Sheet have temporary paths that become invalid
      // after app restart. For converted images, we'll add to Recent Files
      // only after the user saves the PDF to a permanent location.

      // Navigate to PDF viewer, closing any existing viewer first.
      // Using pushAndRemoveUntil ensures:
      // 1. Any existing PdfViewerScreen is disposed (cleans up session)
      // 2. Back button returns to HomeScreen, not to previous file

      switch (incomingFile.type) {
        case IncomingFileType.pdf:
          // PDF file - open directly
          navigator.pushAndRemoveUntil(
            MaterialPageRoute<void>(
              builder: (context) => PdfViewerScreen(
                filePath: incomingFile.path,
                fileSource: FileSourceType.filesApp,
              ),
            ),
            (route) => route.isFirst,
          );

        case IncomingFileType.image:
          // Single image - navigate immediately, convert in PdfViewerScreen
          navigator.pushAndRemoveUntil(
            MaterialPageRoute<void>(
              builder: (context) => PdfViewerScreen(
                filePath: null,
                fileSource: FileSourceType.convertedImage,
                originalImageName: incomingFile.originalFileName,
                imagesToConvert: [incomingFile.path],
              ),
            ),
            (route) => route.isFirst,
          );

        case IncomingFileType.multipleImages:
          // Multiple images - navigate immediately, convert in PdfViewerScreen
          final imagePaths = incomingFile.imagePaths ?? [incomingFile.path];
          navigator.pushAndRemoveUntil(
            MaterialPageRoute<void>(
              builder: (context) => PdfViewerScreen(
                filePath: null,
                fileSource: FileSourceType.convertedImage,
                originalImageName: incomingFile.originalFileName,
                imagesToConvert: imagePaths,
              ),
            ),
            (route) => route.isFirst,
          );
      }
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
