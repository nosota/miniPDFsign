import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/core/platform/window_list_channel.dart';
import 'package:pdfsign/core/window/window_manager_service.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';
import 'package:pdfsign/domain/entities/window_info.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/providers/file_picker_provider.dart';
import 'package:pdfsign/presentation/providers/recent_files_provider.dart';

/// Base menu bar builder with common File menu items.
///
/// Provides Open, Open Recent, Save, Save As, Share, and Close Window functionality.
/// All menu labels are localized via AppLocalizations.
///
/// Uses ConsumerStatefulWidget to safely handle async operations that may
/// outlive the widget lifecycle (e.g., file picker dialogs).
class AppMenuBar extends ConsumerStatefulWidget {
  const AppMenuBar({
    required this.child,
    required this.localizations,
    this.navigatorKey,
    this.onSave,
    this.onSaveAs,
    this.onSaveAll,
    this.isSaveEnabled = false,
    this.isSaveAsEnabled = false,
    this.isSaveAllEnabled = false,
    this.includeSave = true,
    this.includeSaveAs = true,
    this.includeSaveAll = true,
    this.includeShare = false,
    this.onShare,
    this.onFileOpened,
    this.onCloseWindow,
    this.includeCloseAll = false,
    this.onCloseAll,
    this.isCloseAllEnabled = false,
    this.onQuit,
    super.key,
  });

  /// The child widget to wrap with the menu bar.
  final Widget child;

  /// Localization strings.
  final AppLocalizations localizations;

  /// Navigator key for showing dialogs from menu callbacks.
  final GlobalKey<NavigatorState>? navigatorKey;

  /// Callback when Save is selected.
  final VoidCallback? onSave;

  /// Callback when Save As is selected.
  final VoidCallback? onSaveAs;

  /// Callback when Save All is selected.
  final VoidCallback? onSaveAll;

  /// Whether Save menu item is enabled.
  final bool isSaveEnabled;

  /// Whether Save As menu item is enabled.
  final bool isSaveAsEnabled;

  /// Whether Save All menu item is enabled.
  final bool isSaveAllEnabled;

  /// Whether to include Save menu item.
  final bool includeSave;

  /// Whether to include Save As menu item.
  final bool includeSaveAs;

  /// Whether to include Save All menu item.
  final bool includeSaveAll;

  /// Whether to include the Share menu item.
  final bool includeShare;

  /// Callback when Share is selected.
  final VoidCallback? onShare;

  /// Callback when a file is successfully opened.
  final VoidCallback? onFileOpened;

  /// Callback when Close Window is selected.
  /// If provided, this is called instead of default close behavior.
  /// Use this to implement save confirmation dialogs.
  final VoidCallback? onCloseWindow;

  /// Whether to include Close All menu item.
  final bool includeCloseAll;

  /// Callback when Close All is selected.
  final VoidCallback? onCloseAll;

  /// Whether Close All menu item is enabled.
  final bool isCloseAllEnabled;

  /// Callback when Quit is selected (Cmd+Q).
  /// Should check for unsaved changes and show CloseAllDialog if needed.
  final VoidCallback? onQuit;

  @override
  ConsumerState<AppMenuBar> createState() => _AppMenuBarState();
}

class _AppMenuBarState extends ConsumerState<AppMenuBar> {
  /// Cached list of open windows for the Window menu.
  List<WindowInfo> _windowList = [];

  @override
  void initState() {
    super.initState();
    _refreshWindowList();
  }

  @override
  void didUpdateWidget(covariant AppMenuBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Refresh window list when widget updates (e.g., focus changed)
    _refreshWindowList();
  }

  /// Fetches the current window list from native.
  Future<void> _refreshWindowList() async {
    final windows = await WindowListChannel.getWindowList();
    if (mounted) {
      setState(() {
        _windowList = windows;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final recentFilesAsync = ref.watch(recentFilesProvider);

    return PlatformMenuBar(
      menus: [
        // macOS App menu (first menu is always the app menu)
        PlatformMenu(
          label: 'PDFSign',
          menus: [
            const PlatformProvidedMenuItem(
              type: PlatformProvidedMenuItemType.about,
            ),
            PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: widget.localizations.menuSettings,
                  shortcut: const SingleActivator(
                    LogicalKeyboardKey.comma,
                    meta: true,
                  ),
                  onSelected: () => _showSettings(),
                ),
              ],
            ),
            PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: widget.localizations.menuQuit,
                  shortcut: const SingleActivator(
                    LogicalKeyboardKey.keyQ,
                    meta: true,
                  ),
                  onSelected: widget.onQuit,
                ),
              ],
            ),
          ],
        ),
        // File menu
        PlatformMenu(
          label: widget.localizations.menuFile,
          menus: _buildFileMenuItems(context, recentFilesAsync),
        ),
        // Window menu
        PlatformMenu(
          label: widget.localizations.menuWindow,
          menus: _buildWindowMenuItems(),
        ),
      ],
      child: widget.child,
    );
  }

  List<PlatformMenuItem> _buildFileMenuItems(
    BuildContext context,
    AsyncValue<List<RecentFile>> recentFilesAsync,
  ) {
    final items = <PlatformMenuItem>[
      // Group 1: Open
      PlatformMenuItemGroup(
        members: [
          PlatformMenuItem(
            label: widget.localizations.menuOpen,
            shortcut: const SingleActivator(
              LogicalKeyboardKey.keyO,
              meta: true,
            ),
            onSelected: () => _handleOpen(widget.onFileOpened),
          ),
        ],
      ),
      // Group 2: Open Recent submenu
      PlatformMenuItemGroup(
        members: [
          _buildOpenRecentMenu(recentFilesAsync, widget.onFileOpened),
        ],
      ),
    ];

    // Group 3: Save, Save As, Save All (conditionally shown via include* flags)
    final saveMembers = <PlatformMenuItem>[];
    if (widget.includeSave) {
      saveMembers.add(
        PlatformMenuItem(
          label: widget.localizations.menuSave,
          shortcut: const SingleActivator(
            LogicalKeyboardKey.keyS,
            meta: true,
          ),
          onSelected: widget.isSaveEnabled ? widget.onSave : null,
        ),
      );
    }
    if (widget.includeSaveAs) {
      saveMembers.add(
        PlatformMenuItem(
          label: widget.localizations.menuSaveAs,
          shortcut: const SingleActivator(
            LogicalKeyboardKey.keyS,
            meta: true,
            shift: true,
          ),
          onSelected: widget.isSaveAsEnabled ? widget.onSaveAs : null,
        ),
      );
    }
    if (widget.includeSaveAll) {
      saveMembers.add(
        PlatformMenuItem(
          label: widget.localizations.menuSaveAll,
          shortcut: const SingleActivator(
            LogicalKeyboardKey.keyS,
            meta: true,
            alt: true,
          ),
          onSelected: widget.isSaveAllEnabled ? widget.onSaveAll : null,
        ),
      );
    }
    if (saveMembers.isNotEmpty) {
      items.add(PlatformMenuItemGroup(members: saveMembers));
    }

    // Group 4: Share (optional)
    if (widget.includeShare) {
      items.add(
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(
              label: widget.localizations.menuShare,
              onSelected: widget.onShare,
            ),
          ],
        ),
      );
    }

    // Group 5: Close All (optional) and Close Window
    final closeItems = <PlatformMenuItem>[];

    if (widget.includeCloseAll) {
      closeItems.add(
        PlatformMenuItem(
          label: widget.localizations.menuCloseAll,
          shortcut: const SingleActivator(
            LogicalKeyboardKey.keyW,
            meta: true,
            alt: true,
          ),
          onSelected: widget.isCloseAllEnabled ? widget.onCloseAll : null,
        ),
      );
    }

    closeItems.add(
      PlatformMenuItem(
        label: widget.localizations.menuCloseWindow,
        shortcut: const SingleActivator(
          LogicalKeyboardKey.keyW,
          meta: true,
        ),
        onSelected: widget.onCloseWindow ?? () => _handleCloseWindow(),
      ),
    );

    items.add(
      PlatformMenuItemGroup(members: closeItems),
    );

    return items;
  }

  PlatformMenu _buildOpenRecentMenu(
    AsyncValue<List<RecentFile>> recentFilesAsync,
    VoidCallback? onFileOpened,
  ) {
    final recentFiles = recentFilesAsync.valueOrNull ?? [];

    final menuItems = <PlatformMenuItem>[];

    if (recentFiles.isNotEmpty) {
      // Group 1: Recent files (up to 10)
      final recentFileItems = <PlatformMenuItem>[];
      for (final file in recentFiles.take(10)) {
        recentFileItems.add(
          PlatformMenuItem(
            label: file.fileName,
            onSelected: () => _handleOpenRecent(file.path, onFileOpened),
          ),
        );
      }
      menuItems.add(
        PlatformMenuItemGroup(members: recentFileItems),
      );

      // Group 2: Clear Menu
      menuItems.add(
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(
              label: widget.localizations.menuClearMenu,
              onSelected: () => _handleClearRecentFiles(),
            ),
          ],
        ),
      );
    } else {
      // No recent files - single disabled item
      menuItems.add(
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(
              label: widget.localizations.menuNoRecentFiles,
              onSelected: null,
            ),
          ],
        ),
      );
    }

    return PlatformMenu(
      label: widget.localizations.menuOpenRecent,
      menus: menuItems,
    );
  }

  /// Builds the Window menu items.
  ///
  /// Includes Minimize, Zoom, Bring All to Front, and list of open windows.
  /// The currently focused window is marked with a checkmark.
  List<PlatformMenuItem> _buildWindowMenuItems() {
    return [
      // Group 1: Minimize and Zoom
      PlatformMenuItemGroup(
        members: [
          PlatformMenuItem(
            label: widget.localizations.menuMinimize,
            shortcut: const SingleActivator(
              LogicalKeyboardKey.keyM,
              meta: true,
            ),
            onSelected: () => WindowListChannel.minimizeWindow(),
          ),
          PlatformMenuItem(
            label: widget.localizations.menuZoom,
            onSelected: () => WindowListChannel.zoomWindow(),
          ),
        ],
      ),
      // Group 2: Bring All to Front
      PlatformMenuItemGroup(
        members: [
          PlatformMenuItem(
            label: widget.localizations.menuBringAllToFront,
            onSelected: () => WindowListChannel.bringAllToFront(),
          ),
        ],
      ),
      // Group 3: Window list
      if (_windowList.isNotEmpty)
        PlatformMenuItemGroup(
          members: [
            for (final window in _windowList)
              PlatformMenuItem(
                // Use checkmark prefix for key (focused) window
                label: window.isKey
                    ? '\u2713 ${window.title}'
                    : '    ${window.title}',
                onSelected: () => WindowListChannel.focusWindow(window.windowId),
              ),
          ],
        ),
    ];
  }

  /// Handles Open menu action.
  ///
  /// IMPORTANT: Captures provider notifiers BEFORE any await to avoid
  /// "ref after dispose" errors when widget is disposed during file picker.
  Future<void> _handleOpen(VoidCallback? onFileOpened) async {
    // Capture notifiers synchronously BEFORE any await.
    // These references remain valid even if widget is disposed.
    final filePicker = ref.read(pdfFilePickerProvider.notifier);
    final recentFilesNotifier = ref.read(recentFilesProvider.notifier);

    // Show file picker - widget may be disposed while this is open
    final path = await filePicker.pickPdf();

    // After await: use captured notifiers (valid), check mounted for UI callbacks
    if (path != null) {
      final fileName = path.split('/').last;

      // Add to recent files using captured notifier (doesn't need mounted check)
      await recentFilesNotifier.addFile(
        RecentFile(
          path: path,
          fileName: fileName,
          lastOpened: DateTime.now(),
          pageCount: 0,
          isPasswordProtected: false,
        ),
      );

      // Open in new window (WindowManagerService is singleton, no ref needed)
      final windowId =
          await WindowManagerService.instance.createPdfWindow(path);

      // Only call UI callback if widget is still mounted
      if (windowId != null && mounted) {
        onFileOpened?.call();
      }
    }
  }

  /// Handles Open Recent menu action.
  ///
  /// IMPORTANT: Captures provider notifiers BEFORE any await.
  Future<void> _handleOpenRecent(
    String path,
    VoidCallback? onFileOpened,
  ) async {
    // Capture notifier synchronously BEFORE any await
    final recentFilesNotifier = ref.read(recentFilesProvider.notifier);

    // Check if file still exists
    final file = File(path);
    if (!await file.exists()) {
      // Remove from recent files
      await recentFilesNotifier.removeFile(path);

      // Show alert dialog
      final navigatorContext = widget.navigatorKey?.currentContext;
      if (navigatorContext != null && mounted) {
        final l10n = AppLocalizations.of(navigatorContext);
        if (l10n != null) {
          await showDialog<void>(
            context: navigatorContext,
            builder: (context) => AlertDialog(
              title: Text(l10n.fileNotFound),
              content: Text(path.split('/').last),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      }
      return;
    }

    // Update last opened time
    final fileName = path.split('/').last;
    await recentFilesNotifier.addFile(
      RecentFile(
        path: path,
        fileName: fileName,
        lastOpened: DateTime.now(),
        pageCount: 0,
        isPasswordProtected: false,
      ),
    );

    // Open in new window
    final windowId = await WindowManagerService.instance.createPdfWindow(path);

    // Only call UI callback if widget is still mounted
    if (windowId != null && mounted) {
      onFileOpened?.call();
    }
  }

  /// Handles Clear Menu action for recent files.
  void _handleClearRecentFiles() {
    ref.read(recentFilesProvider.notifier).clearAll();
  }

  Future<void> _handleCloseWindow() async {
    await WindowManagerService.instance.closeCurrentWindow();
  }

  Future<void> _showSettings() async {
    await WindowManagerService.instance.createSettingsWindow();
  }
}
