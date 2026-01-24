import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pdfsign/core/window/window_arguments.dart';
import 'package:pdfsign/core/window/window_manager_service.dart';
import 'package:pdfsign/data/models/sidebar_image_model.dart';
import 'package:pdfsign/presentation/apps/pdf_viewer_app.dart';
import 'package:pdfsign/presentation/apps/settings_app.dart';
import 'package:pdfsign/presentation/apps/welcome_app.dart';
import 'package:pdfsign/presentation/providers/data_source_providers.dart';
import 'package:pdfsign/presentation/providers/shared_preferences_provider.dart';

/// Application entry point.
///
/// Handles multi-window support:
/// - Main window (no args) → Welcome Screen
/// - Sub windows (with args) → PDF Viewer, Settings, etc.
Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Main window has no args, sub-windows receive JSON args from desktop_multi_window
  if (args.isEmpty) {
    // Main window → Welcome Screen
    await _runWelcomeWindow();
  } else {
    // Sub window → route based on window type
    final controller = await WindowController.fromCurrentEngine();
    final arguments = WindowArguments.fromJson(controller.arguments);

    switch (arguments.windowType) {
      case WindowType.pdfViewer:
        await _runPdfViewerWindow(controller, arguments);
      case WindowType.settings:
        await _runSettingsWindow();
      case WindowType.welcome:
        // Should not happen, but handle gracefully
        await _runWelcomeWindow();
    }
  }
}

/// Initializes shared Isar database.
///
/// All windows share the same database file for instant sync.
Future<Isar> _initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open(
    [SidebarImageModelSchema],
    directory: dir.path,
    name: 'pdfsign',
  );
}

/// Runs the welcome window (main window).
Future<void> _runWelcomeWindow() async {
  // Initialize window manager for main window
  await WindowManagerService.instance.initializeMainWindow();

  // Pre-initialize dependencies
  final sharedPrefs = await SharedPreferences.getInstance();
  final isar = await _initializeIsar();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        isarProvider.overrideWithValue(isar),
      ],
      child: const WelcomeApp(),
    ),
  );
}

/// Runs a PDF viewer window (sub window).
Future<void> _runPdfViewerWindow(
  WindowController controller,
  WindowArguments arguments,
) async {
  // Initialize window for this sub-window
  await WindowManagerService.instance.initializeSubWindow(
    title: arguments.fileName ?? 'PDF Viewer',
  );

  // Pre-initialize dependencies
  final sharedPrefs = await SharedPreferences.getInstance();
  final isar = await _initializeIsar();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        isarProvider.overrideWithValue(isar),
      ],
      child: PdfViewerApp(
        filePath: arguments.filePath ?? '',
        fileName: arguments.fileName ?? 'PDF Viewer',
      ),
    ),
  );
}

/// Runs a settings window (sub window).
Future<void> _runSettingsWindow() async {
  // Get localized title (fallback to English)
  const title = 'Settings';

  // Initialize window for settings
  await WindowManagerService.instance.initializeSettingsWindow(title: title);

  // Pre-initialize dependencies
  final sharedPrefs = await SharedPreferences.getInstance();
  final isar = await _initializeIsar();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        isarProvider.overrideWithValue(isar),
      ],
      child: const SettingsApp(),
    ),
  );
}
