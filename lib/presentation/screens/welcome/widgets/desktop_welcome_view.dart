import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'package:pdfsign/core/constants/spacing.dart';
import 'package:pdfsign/core/theme/app_colors.dart';
import 'package:pdfsign/core/theme/app_typography.dart';
import 'package:pdfsign/core/window/window_manager_service.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/providers/file_picker_provider.dart';
import 'package:pdfsign/presentation/providers/recent_files_provider.dart';
import 'package:pdfsign/presentation/screens/welcome/widgets/app_logo.dart';
import 'package:pdfsign/presentation/screens/welcome/widgets/open_pdf_button.dart';
import 'package:pdfsign/presentation/screens/welcome/widgets/recent_files_list.dart';

/// Desktop layout: centered content with Open PDF button + recent files list.
class DesktopWelcomeView extends ConsumerStatefulWidget {
  const DesktopWelcomeView({super.key});

  @override
  ConsumerState<DesktopWelcomeView> createState() => _DesktopWelcomeViewState();
}

class _DesktopWelcomeViewState extends ConsumerState<DesktopWelcomeView> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final recentFilesAsync = ref.watch(recentFilesProvider);

    return Padding(
      padding: const EdgeInsets.all(Spacing.spacing32),
      child: Column(
        children: [
          // Flexible top space - provides vertical centering effect
          const Spacer(),

          // Fixed header section: logo + button (doesn't scroll)
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppLogo(),
                const SizedBox(height: Spacing.spacing48),
                OpenPdfButton(
                  label: l10n.openPdf,
                  isLoading: _isLoading,
                  onPressed: () => _handleOpenPdf(context),
                ),
              ],
            ),
          ),

          // Recent files section (header fixed, list scrolls)
          recentFilesAsync.when(
            data: (files) => files.isEmpty
                ? const SizedBox(height: Spacing.spacing48)
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: Spacing.spacing48),
                      // Fixed header: "Recent Files" (doesn't scroll)
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            l10n.recentFiles,
                            style: AppTypography.labelLarge.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: Spacing.spacing12),
                    ],
                  ),
            loading: () => const SizedBox(height: Spacing.spacing48),
            error: (_, __) => const SizedBox(height: Spacing.spacing48),
          ),

          // Scrollable list section - only the file list scrolls
          Expanded(
            flex: 2,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: recentFilesAsync.when(
                  data: (files) => files.isEmpty
                      ? const SizedBox.shrink()
                      : SingleChildScrollView(
                          child: RecentFilesList(
                            files: files,
                            showHeader: false,
                            onFileTap: (file) => _handleOpenRecentFile(file),
                            onFileRemove: (file) => _handleRemoveRecentFile(file),
                          ),
                        ),
                  loading: () => const SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ),
            ),
          ),

          // Flexible bottom space
          const Spacer(),
        ],
      ),
    );
  }

  Future<void> _handleOpenPdf(BuildContext context) async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final filePicker = ref.read(pdfFilePickerProvider.notifier);
      final path = await filePicker.pickPdf();

      if (path != null && mounted) {
        // Extract file name from path
        final fileName = path.split('/').last;

        // Add to recent files
        await ref.read(recentFilesProvider.notifier).addFile(
              RecentFile(
                path: path,
                fileName: fileName,
                lastOpened: DateTime.now(),
                pageCount: 0, // Will be updated when PDF is loaded
                isPasswordProtected: false,
              ),
            );

        // Open in new window and hide Welcome screen
        final windowId = await WindowManagerService.instance.createPdfWindow(path);
        if (windowId != null) {
          await windowManager.hide();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleOpenRecentFile(RecentFile file) async {
    // Check if file still exists
    final filePicker = ref.read(pdfFilePickerProvider.notifier);
    final exists = await filePicker.fileExists(file.path);

    if (!exists) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.fileNotFound)),
        );
        // Remove from recent files
        await ref.read(recentFilesProvider.notifier).removeFile(file.path);
      }
      return;
    }

    // Update last opened time
    await ref.read(recentFilesProvider.notifier).addFile(
          file.copyWith(lastOpened: DateTime.now()),
        );

    // Open in new window and hide Welcome screen
    final windowId = await WindowManagerService.instance.createPdfWindow(file.path);
    if (windowId != null) {
      await windowManager.hide();
    }
  }

  Future<void> _handleRemoveRecentFile(RecentFile file) async {
    await ref.read(recentFilesProvider.notifier).removeFile(file.path);
  }
}
