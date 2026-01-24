import 'dart:io';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:window_manager/window_manager.dart';

import 'package:pdfsign/core/platform/open_pdf_files_channel.dart';
import 'package:pdfsign/core/platform/sub_window_channel.dart';
import 'package:pdfsign/core/platform/toolbar_channel.dart';
import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/core/window/window_broadcast.dart';
import 'package:pdfsign/core/window/window_manager_service.dart';
import 'package:pdfsign/data/services/pdf_save_service.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/providers/editor/document_dirty_provider.dart';
import 'package:pdfsign/presentation/providers/editor/global_dirty_state_provider.dart';
import 'package:pdfsign/presentation/providers/editor/original_pdf_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/editor/size_unit_preference_provider.dart';
import 'package:pdfsign/presentation/providers/locale_preference_provider.dart';
import 'package:pdfsign/presentation/providers/recent_files_provider.dart';
import 'package:pdfsign/presentation/providers/shared_preferences_provider.dart';
import 'package:pdfsign/presentation/screens/editor/editor_screen.dart';
import 'package:pdfsign/presentation/widgets/dialogs/close_all_dialog.dart';
import 'package:pdfsign/presentation/widgets/dialogs/save_changes_dialog.dart';
import 'package:pdfsign/presentation/widgets/menus/app_menu_bar.dart';

/// Root app widget for PDF viewer windows (sub windows).
///
/// Each PDF viewer window displays a single PDF document.
/// Includes File menu with Open, Open Recent, Save, Save As, Share, Close Window.
/// Has a Share button in the native macOS toolbar.
class PdfViewerApp extends ConsumerStatefulWidget {
  const PdfViewerApp({
    required this.filePath,
    required this.fileName,
    super.key,
  });

  /// Path to the PDF file to display.
  final String filePath;

  /// Name of the PDF file (for window title).
  final String fileName;

  @override
  ConsumerState<PdfViewerApp> createState() => _PdfViewerAppState();
}

class _PdfViewerAppState extends ConsumerState<PdfViewerApp> {
  /// Navigator key for showing dialogs.
  final _navigatorKey = GlobalKey<NavigatorState>();

  /// Whether the document has been modified at least once.
  /// Used to determine if status suffix should be shown in title.
  bool _hasBeenModified = false;

  /// Current window ID for dirty state tracking.
  String? _windowId;

  /// Notifier for menu state updates.
  /// Used to bypass MaterialApp.builder caching issues.
  final _menuStateNotifier = ValueNotifier<_MenuState>(
    const _MenuState(isDirty: false, hasAnyDirtyWindow: false),
  );

  /// Whether this window currently has focus.
  /// Only focused window renders PlatformMenuBar to avoid conflicts.
  /// Starts as false - we wait for native onWindowFocus event to enable menu.
  /// This prevents menu rendering issues when SubWindowDelegate setup is delayed.
  bool _isWindowFocused = false;

  @override
  void initState() {
    super.initState();
    // Initialize toolbar channel for native toolbar
    ToolbarChannel.init();
    ToolbarChannel.setOnSharePressed(_handleShare);
    // Delay toolbar setup to ensure native window is fully ready
    Future.delayed(const Duration(milliseconds: 200), () {
      ToolbarChannel.setupToolbar(); // Request native toolbar with Share button
    });

    // Initialize window channel for close interception and focus tracking
    _initWindowChannel();

    // Initialize window broadcast for inter-window communication
    _initWindowBroadcast();

    // Store original PDF bytes for Save operations
    _initOriginalPdfStorage();

    // Set initial window title (just filename, no suffix)
    // Note: windowManager.setTitle works for sub-windows too
    WidgetsBinding.instance.addPostFrameCallback((_) {
      windowManager.setTitle(widget.fileName);
    });
  }

  /// Initializes window channel for close interception and focus tracking.
  void _initWindowChannel() {
    SubWindowChannel.setOnWindowClose(_handleWindowClose);
    SubWindowChannel.setOnWindowFocus(_handleWindowFocus);
    SubWindowChannel.setOnWindowBlur(_handleWindowBlur);
    // Enable close prevention immediately - native side has retry mechanism
    // if window is not ready yet. This ensures focus/blur events are captured
    // even when multiple windows are created rapidly (e.g., opening 4 PDFs).
    SubWindowChannel.setPreventClose(true);
  }

  /// Initializes window broadcast for receiving preference change notifications.
  Future<void> _initWindowBroadcast() async {
    // Get current window ID
    final currentWindow = await WindowController.fromCurrentEngine();
    _windowId = currentWindow.windowId;

    // Register own dirty state in global tracker (starts as clean)
    ref.read(globalDirtyStateProvider.notifier).updateWindowState(
          _windowId!,
          false,
        );

    // Set up broadcast callbacks
    WindowBroadcast.setOnUnitChanged(_handleUnitChanged);
    WindowBroadcast.setOnLocaleChanged(_handleLocaleChanged);
    WindowBroadcast.setOnSaveAll(_handleSaveAllBroadcast);
    WindowBroadcast.setOnCloseAll(_handleCloseAllBroadcast);
    WindowBroadcast.setOnDirtyStateChanged(_handleDirtyStateChanged);
    WindowBroadcast.setOnRequestDirtyStates(_handleRequestDirtyStates);

    await WindowBroadcast.init();

    // Request dirty states from all other windows
    await WindowBroadcast.broadcastRequestDirtyStates();
  }

  /// Stores the original PDF bytes for use in Save operations.
  Future<void> _initOriginalPdfStorage() async {
    final storage = ref.read(originalPdfStorageProvider);
    await storage.store(widget.filePath);
  }

  @override
  void dispose() {
    // Dispose menu state notifier
    _menuStateNotifier.dispose();

    // Remove this window from global dirty state tracker
    if (_windowId != null) {
      ref.read(globalDirtyStateProvider.notifier).removeWindow(_windowId!);
    }

    // Unregister callbacks
    ToolbarChannel.setOnSharePressed(null);
    WindowBroadcast.setOnUnitChanged(null);
    WindowBroadcast.setOnLocaleChanged(null);
    WindowBroadcast.setOnSaveAll(null);
    WindowBroadcast.setOnCloseAll(null);
    WindowBroadcast.setOnDirtyStateChanged(null);
    WindowBroadcast.setOnRequestDirtyStates(null);

    // Clean up window channel
    SubWindowChannel.dispose();
    // Clean up original PDF storage
    ref.read(originalPdfStorageProvider).dispose();
    super.dispose();
  }

  /// Updates the window title based on dirty state.
  ///
  /// Shows no suffix until document is modified for the first time.
  /// After first modification: "- Edited" when dirty, "- Saved" when clean.
  void _updateWindowTitle(bool isDirty) {
    // Track if document has ever been modified
    if (isDirty) {
      _hasBeenModified = true;
    }

    // No suffix until first modification
    if (!_hasBeenModified) {
      windowManager.setTitle(widget.fileName);
      return;
    }

    final navigatorContext = _navigatorKey.currentContext;
    if (navigatorContext == null) return;

    final l10n = AppLocalizations.of(navigatorContext);
    if (l10n == null) return;

    final suffix = isDirty ? l10n.documentEdited : l10n.documentSaved;
    windowManager.setTitle('${widget.fileName} - $suffix');
  }

  /// Handles window close request (system close button or Cmd+W).
  /// Shows save dialog if document has unsaved changes.
  void _handleWindowClose() async {
    final isDirty = ref.read(documentDirtyProvider);

    if (kDebugMode) {
      print('>>> _handleWindowClose called, isDirty=$isDirty');
    }

    if (!isDirty) {
      await _destroyWindow();
      return;
    }

    // Show save dialog
    final navigatorContext = _navigatorKey.currentContext;
    if (navigatorContext == null) {
      if (kDebugMode) {
        print('>>> _handleWindowClose: navigatorContext is null, destroying');
      }
      await _destroyWindow();
      return;
    }

    if (kDebugMode) {
      print('>>> _handleWindowClose: showing SaveChangesDialog');
    }

    final result = await SaveChangesDialog.show(
      navigatorContext,
      widget.fileName,
    );

    if (kDebugMode) {
      print('>>> _handleWindowClose: dialog result=$result');
    }

    if (result == SaveChangesResult.save) {
      await _handleSave();
      await _destroyWindow();
    } else if (result == SaveChangesResult.discard) {
      await _destroyWindow();
    }
    // null = dialog dismissed or cancelled, don't close
  }

  /// Unregisters from global tracker and closes the window.
  /// If this is the last visible window, terminates the application.
  Future<void> _destroyWindow() async {
    // Unregister this file from open files tracker
    await OpenPdfFilesChannel.unregisterPdfFile(widget.filePath);

    // Get all windows from native to check if there are other visible windows.
    // We can't rely on local _openWindows because each sub-window runs in
    // its own Flutter engine with its own WindowManagerService instance.
    final allWindows = await WindowController.getAll();

    // Count windows: exclude this window (we're closing it) and main window (ID "0", Welcome is hidden)
    final otherVisibleWindows = allWindows.where((w) {
      return w.windowId != _windowId && w.windowId != '0';
    }).toList();

    if (kDebugMode) {
      print('>>> PDF _destroyWindow:');
      print('>>>   this windowId: $_windowId');
      print('>>>   all windows: ${allWindows.map((w) => w.windowId).toList()}');
      print('>>>   other visible: ${otherVisibleWindows.map((w) => w.windowId).toList()}');
    }

    if (otherVisibleWindows.isEmpty) {
      // This is the last visible window - terminate the app
      if (kDebugMode) {
        print('>>> PDF: last visible window, calling exit(0)');
      }
      exit(0);
    }

    // Other visible windows exist - just close this window
    if (kDebugMode) {
      print('>>> PDF: other windows exist, calling destroy()');
    }
    await SubWindowChannel.destroy();
  }

  /// Reloads preferences and refreshes UI when window becomes active.
  ///
  /// This syncs settings changed in other windows (e.g., Settings window)
  /// and ensures menu state reflects current dirty state.
  void _handleWindowFocus() async {
    _isWindowFocused = true;
    // Force rebuild to render PlatformMenuBar and update menu state
    setState(() {});
    // Reload size unit preference to sync with changes from Settings
    ref.read(sizeUnitPreferenceProvider.notifier).reload();

    // Reload SharedPreferences from disk to get latest recent files
    // (other windows may have added files while this window was in background)
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.reload();
    // Invalidate provider to re-read from the now-updated cache
    ref.invalidate(recentFilesProvider);
  }

  /// Called when window loses focus.
  /// Stops rendering PlatformMenuBar so focused window can take control.
  void _handleWindowBlur() {
    _isWindowFocused = false;
    setState(() {});
  }

  /// Handles unit changed broadcast from another window.
  ///
  /// This is called instantly when another window changes the size unit,
  /// without waiting for window focus.
  void _handleUnitChanged() {
    ref.read(sizeUnitPreferenceProvider.notifier).reload();
  }

  /// Handles locale changed broadcast from another window.
  void _handleLocaleChanged() {
    ref.read(localePreferenceProvider.notifier).reload();
  }

  /// Handles dirty state changed broadcast from another window.
  void _handleDirtyStateChanged(String windowId, bool isDirty) {
    ref.read(globalDirtyStateProvider.notifier).updateWindowState(
          windowId,
          isDirty,
        );
  }

  /// Handles request for dirty states from another window.
  ///
  /// Responds by broadcasting this window's current dirty state.
  void _handleRequestDirtyStates() {
    if (_windowId == null) return;
    final isDirty = ref.read(documentDirtyProvider);
    WindowBroadcast.broadcastDirtyStateChanged(_windowId!, isDirty);
  }

  /// Broadcasts this window's dirty state change to all other windows.
  void _broadcastDirtyState(bool isDirty) {
    if (_windowId == null) return;

    // Update local global state
    ref.read(globalDirtyStateProvider.notifier).updateWindowState(
          _windowId!,
          isDirty,
        );

    // Broadcast to other windows
    WindowBroadcast.broadcastDirtyStateChanged(_windowId!, isDirty);
  }

  /// Updates menu state notifier from current provider values.
  ///
  /// Called from listeners - computes fresh state each time to avoid
  /// race conditions between nested listener executions.
  void _updateMenuState() {
    final isDirty = ref.read(documentDirtyProvider);
    final globalState = ref.read(globalDirtyStateProvider);
    final hasAnyDirty = globalState.values.any((d) => d);

    _menuStateNotifier.value = _MenuState(
      isDirty: isDirty,
      hasAnyDirtyWindow: hasAnyDirty,
    );
  }

  /// Handles Save All broadcast from any window.
  ///
  /// Only saves if this document has unsaved changes.
  void _handleSaveAllBroadcast() {
    final isDirty = ref.read(documentDirtyProvider);
    if (isDirty) {
      _handleSave();
    }
  }

  /// Triggers Save All across all PDF windows.
  Future<void> _handleSaveAll() async {
    await WindowBroadcast.broadcastSaveAll();
  }

  /// Handles Close All broadcast from another window.
  ///
  /// Closes this window WITHOUT showing save dialog
  /// (the dialog was already shown by the initiating window).
  void _handleCloseAllBroadcast() {
    _destroyWindow();
  }

  /// Handles Close All menu action.
  ///
  /// Shows CloseAllDialog if any PDF windows have unsaved changes,
  /// then broadcasts close to all PDF windows.
  Future<void> _handleCloseAll() async {
    final navigatorContext = _navigatorKey.currentContext;
    if (navigatorContext == null) return;

    final globalState = ref.read(globalDirtyStateProvider);
    final dirtyCount = globalState.values.where((d) => d).length;

    if (dirtyCount == 0) {
      // No dirty windows, close all without dialog
      await WindowBroadcast.broadcastCloseAll();
      return;
    }

    // Show close all dialog
    final result = await CloseAllDialog.show(navigatorContext, dirtyCount);

    switch (result) {
      case CloseAllResult.saveAll:
        // Save all dirty windows first
        await WindowBroadcast.broadcastSaveAll();
        // Wait for saves to complete (5 seconds timeout)
        await Future.delayed(const Duration(seconds: 5));

        // Check if any windows still have unsaved changes (save failed)
        final stillDirty = ref.read(globalDirtyStateProvider);
        final failedCount = stillDirty.values.where((d) => d).length;

        if (failedCount > 0) {
          // Some saves failed, ask user what to do
          final l10n = AppLocalizations.of(navigatorContext);
          if (l10n != null) {
            final closeAnyway = await _showSaveFailedDialog(
              navigatorContext,
              l10n,
              failedCount,
            );
            if (!closeAnyway) return; // User cancelled
          }
        }

        await WindowBroadcast.broadcastCloseAll();
        break;
      case CloseAllResult.discard:
        // Close all without saving
        await WindowBroadcast.broadcastCloseAll();
        break;
      case CloseAllResult.cancel:
      case null:
        // User cancelled, do nothing
        break;
    }
  }

  /// Shows dialog when save failed for some documents.
  /// Returns true if user wants to close anyway, false to cancel.
  Future<bool> _showSaveFailedDialog(
    BuildContext context,
    AppLocalizations l10n,
    int failedCount,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(l10n.saveFailedDialogTitle),
        content: Text(l10n.saveFailedDialogMessage(failedCount)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.closeAllDialogCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.saveFailedDialogClose),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Handles Quit command (Cmd+Q).
  ///
  /// Shows CloseAllDialog if any PDF windows have unsaved changes,
  /// then quits the application.
  Future<void> _handleQuit() async {
    final navigatorContext = _navigatorKey.currentContext;
    if (navigatorContext == null) {
      // No context, just exit
      exit(0);
    }

    final globalState = ref.read(globalDirtyStateProvider);
    final dirtyCount = globalState.values.where((d) => d).length;

    if (dirtyCount == 0) {
      // No dirty windows, quit immediately
      exit(0);
    }

    // Show close all dialog
    final result = await CloseAllDialog.show(navigatorContext, dirtyCount);

    switch (result) {
      case CloseAllResult.saveAll:
        // Save all dirty windows first
        await WindowBroadcast.broadcastSaveAll();
        // Wait for saves to complete (5 seconds timeout)
        await Future.delayed(const Duration(seconds: 5));

        // Check if any windows still have unsaved changes (save failed)
        final stillDirty = ref.read(globalDirtyStateProvider);
        final failedCount = stillDirty.values.where((d) => d).length;

        if (failedCount > 0) {
          // Some saves failed, ask user what to do
          final l10n = AppLocalizations.of(navigatorContext);
          if (l10n != null) {
            final closeAnyway = await _showSaveFailedDialog(
              navigatorContext,
              l10n,
              failedCount,
            );
            if (!closeAnyway) return; // User cancelled
          }
        }

        exit(0);
      case CloseAllResult.discard:
        // Quit without saving
        exit(0);
      case CloseAllResult.cancel:
      case null:
        // User cancelled, do nothing
        break;
    }
  }

  Future<void> _handleShare() async {
    if (widget.filePath.isEmpty) return;

    final placedImages = ref.read(placedImagesProvider);

    if (placedImages.isEmpty) {
      // No changes, share original file
      final file = XFile(widget.filePath);
      await Share.shareXFiles([file]);
      return;
    }

    // Get original bytes from storage
    final storage = ref.read(originalPdfStorageProvider);
    if (!storage.hasData) {
      // Fallback: share original file
      final file = XFile(widget.filePath);
      await Share.shareXFiles([file]);
      return;
    }

    final originalBytes = await storage.getBytes();

    // Create temp PDF with placed images
    final saveService = PdfSaveService();
    final result = await saveService.createTempPdfWithImagesFromBytes(
      originalBytes: originalBytes,
      placedImages: placedImages,
    );

    await result.fold(
      (failure) async {
        // Show error and share original
        final file = XFile(widget.filePath);
        await Share.shareXFiles([file]);
      },
      (tempPath) async {
        // Share temp file
        final file = XFile(tempPath);
        await Share.shareXFiles([file]);

        // Clean up temp file after a short delay (allow share to complete)
        Future.delayed(const Duration(seconds: 5), () {
          try {
            File(tempPath).deleteSync();
          } catch (_) {
            // Ignore cleanup errors
          }
        });
      },
    );
  }

  Future<void> _handleSave() async {
    final placedImages = ref.read(placedImagesProvider);
    final isDirty = ref.read(documentDirtyProvider);

    // Nothing to save if no changes were made
    if (placedImages.isEmpty && !isDirty) return;

    // Get original bytes from storage
    final storage = ref.read(originalPdfStorageProvider);
    if (!storage.hasData) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Save failed: no original PDF stored')),
        );
      }
      return;
    }

    final originalBytes = await storage.getBytes();

    final saveService = PdfSaveService();
    final result = await saveService.savePdfFromBytes(
      originalBytes: originalBytes,
      placedImages: placedImages,
      outputPath: widget.filePath,
    );

    result.fold(
      (failure) {
        // Show error snackbar
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Save failed: ${failure.message}')),
          );
        }
      },
      (_) {
        // Mark as clean but DO NOT clear objects or reload document
        // Objects remain editable for further modifications
        ref.read(documentDirtyProvider.notifier).markClean();
      },
    );
  }

  Future<void> _handleSaveAs() async {
    final outputPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save PDF As',
      fileName: widget.fileName,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (outputPath == null) return;

    final placedImages = ref.read(placedImagesProvider);
    final storage = ref.read(originalPdfStorageProvider);

    // Get original bytes (from storage or fallback to disk)
    final originalBytes = storage.hasData
        ? await storage.getBytes()
        : await File(widget.filePath).readAsBytes();

    final saveService = PdfSaveService();
    final result = await saveService.savePdfFromBytes(
      originalBytes: originalBytes,
      placedImages: placedImages,
      outputPath: outputPath,
    );

    result.fold(
      (failure) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Save failed: ${failure.message}')),
          );
        }
      },
      (savedPath) {
        // Mark as clean but DO NOT clear objects
        // Objects remain editable for further modifications
        ref.read(documentDirtyProvider.notifier).markClean();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Saved to: $savedPath')),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen to dirty state changes to update window title, broadcast, and menu.
    // Uses _updateMenuState() to read fresh values and avoid race conditions
    // when _broadcastDirtyState triggers globalDirtyStateProvider listener.
    ref.listen<bool>(documentDirtyProvider, (previous, current) {
      _updateWindowTitle(current);
      _broadcastDirtyState(current);
      _updateMenuState();
    });

    // Listen to global dirty state changes for Save All (from other windows)
    ref.listen<Map<String, bool>>(globalDirtyStateProvider, (previous, current) {
      _updateMenuState();
    });

    // Watch locale preference for live updates
    ref.watch(localePreferenceProvider);
    final locale = ref.watch(localePreferenceProvider.notifier).getLocale();

    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: widget.fileName,
      theme: createAppTheme(),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: allSupportedLocales,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Only render PlatformMenuBar when this window has focus.
        // This prevents multiple windows from fighting over the native menu.
        if (!_isWindowFocused) {
          return child!;
        }

        final l10n = AppLocalizations.of(context)!;
        // Use ValueListenableBuilder to reactively update menu state.
        // This bypasses MaterialApp.builder caching issues that prevent
        // Consumer from rebuilding when providers change.
        return ValueListenableBuilder<_MenuState>(
          valueListenable: _menuStateNotifier,
          builder: (context, menuState, _) {
            return AppMenuBar(
              localizations: l10n,
              navigatorKey: _navigatorKey,
              onSave: _handleSave,
              onSaveAs: _handleSaveAs,
              onSaveAll: _handleSaveAll,
              // Save enabled only when this window has unsaved changes
              isSaveEnabled: menuState.isDirty,
              // Save As always enabled for PDF windows
              isSaveAsEnabled: true,
              // Save All enabled when any PDF window has unsaved changes
              isSaveAllEnabled: menuState.hasAnyDirtyWindow,
              includeShare: true,
              onShare: _handleShare,
              // Close All - always enabled since there's at least one PDF
              includeCloseAll: true,
              onCloseAll: _handleCloseAll,
              isCloseAllEnabled: true,
              // Use SubWindowChannel.close() to trigger save confirmation dialog
              onCloseWindow: SubWindowChannel.close,
              // Quit (Cmd+Q) - same as Close All but exits app
              onQuit: _handleQuit,
              child: child!,
            );
          },
        );
      },
      home: EditorScreen(filePath: widget.filePath),
    );
  }
}

/// Immutable state for menu enabled/disabled flags.
///
/// Used with ValueNotifier to trigger menu rebuilds when state changes,
/// bypassing MaterialApp.builder caching issues.
class _MenuState {
  const _MenuState({
    required this.isDirty,
    required this.hasAnyDirtyWindow,
  });

  final bool isDirty;
  final bool hasAnyDirtyWindow;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _MenuState &&
          isDirty == other.isDirty &&
          hasAnyDirtyWindow == other.hasAnyDirtyWindow;

  @override
  int get hashCode => Object.hash(isDirty, hasAnyDirtyWindow);
}
