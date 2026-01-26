import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minipdfsign/l10n/generated/app_localizations.dart';
import 'package:minipdfsign/core/constants/spacing.dart';
import 'package:minipdfsign/core/theme/app_colors.dart';
import 'package:minipdfsign/core/theme/app_typography.dart';
import 'package:minipdfsign/domain/entities/recent_file.dart';
import 'package:minipdfsign/presentation/providers/file_picker_provider.dart';
import 'package:minipdfsign/presentation/providers/recent_files_provider.dart';
import 'package:minipdfsign/presentation/screens/home/widgets/app_logo.dart';
import 'package:minipdfsign/presentation/screens/home/widgets/open_pdf_button.dart';
import 'package:minipdfsign/presentation/screens/home/widgets/recent_files_list.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/pdf_viewer_screen.dart';

/// Mobile layout: Home screen with Open PDF button and Recent Files list.
class MobileHomeView extends ConsumerStatefulWidget {
  const MobileHomeView({super.key});

  @override
  ConsumerState<MobileHomeView> createState() => _MobileHomeViewState();
}

class _MobileHomeViewState extends ConsumerState<MobileHomeView> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final recentFilesAsync = ref.watch(recentFilesProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.spacing24),
        child: Column(
          children: [
            const Spacer(flex: 1),
            const AppLogo(),
            const SizedBox(height: Spacing.spacing24),
            OpenPdfButton(
              label: l10n.selectPdf,
              isLoading: _isLoading,
              onPressed: () => _handleSelectPdf(context),
            ),
            const SizedBox(height: Spacing.spacing32),
            Expanded(
              flex: 3,
              child: recentFilesAsync.when(
                data: (files) => files.isEmpty
                    ? _buildEmptyState(l10n)
                    : _buildRecentFilesList(files),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (_, __) => _buildEmptyState(l10n),
              ),
            ),
            const SizedBox(height: Spacing.spacing24),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Text(
        l10n.emptyRecentFiles,
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildRecentFilesList(List<RecentFile> files) {
    return SingleChildScrollView(
      child: RecentFilesList(
        files: files,
        onFileTap: _handleRecentFileTap,
        onFileRemove: _handleRecentFileRemove,
      ),
    );
  }

  Future<void> _handleRecentFileTap(RecentFile file) async {
    // Update lastOpened and navigate
    await ref.read(recentFilesProvider.notifier).addFile(
          file.copyWith(lastOpened: DateTime.now()),
        );

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewerScreen(filePath: file.path),
        ),
      );
    }
  }

  void _handleRecentFileRemove(RecentFile file) {
    ref.read(recentFilesProvider.notifier).removeFile(file.path);
  }

  Future<void> _handleSelectPdf(BuildContext context) async {
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
                pageCount: 0,
                isPasswordProtected: false,
              ),
            );

        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewerScreen(filePath: path),
            ),
          );
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
}
