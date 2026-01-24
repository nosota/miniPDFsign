import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfsign/core/constants/spacing.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';
import 'package:pdfsign/presentation/providers/file_picker_provider.dart';
import 'package:pdfsign/presentation/providers/recent_files_provider.dart';
import 'package:pdfsign/presentation/screens/welcome/widgets/app_logo.dart';
import 'package:pdfsign/presentation/screens/welcome/widgets/open_pdf_button.dart';

/// Mobile layout: splash-style with centered Select PDF button.
class MobileWelcomeView extends ConsumerStatefulWidget {
  const MobileWelcomeView({super.key});

  @override
  ConsumerState<MobileWelcomeView> createState() => _MobileWelcomeViewState();
}

class _MobileWelcomeViewState extends ConsumerState<MobileWelcomeView> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.spacing24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            const AppLogo(),
            const Spacer(flex: 3),
            OpenPdfButton(
              label: l10n.selectPdf,
              isLoading: _isLoading,
              onPressed: () => _handleSelectPdf(context),
            ),
            const SizedBox(height: Spacing.spacing48),
          ],
        ),
      ),
    );
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
          context.goNamed('editor', extra: path);
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
