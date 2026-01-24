import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/core/constants/sidebar_constants.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/providers/sidebar/sidebar_images_provider.dart';

/// Button at the bottom of the sidebar for adding images.
///
/// Opens a file picker dialog to select image files.
class AddImageButton extends ConsumerWidget {
  const AddImageButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      height: SidebarConstants.addButtonHeight,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: TextButton.icon(
          onPressed: () => _pickImages(context, ref),
          icon: const Icon(Icons.add, size: 18),
          label: Text(l10n.addImage),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Future<void> _pickImages(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      dialogTitle: l10n.selectImages,
    );

    if (result != null && result.files.isNotEmpty) {
      final paths = result.files
          .where((f) => f.path != null)
          .map((f) => f.path!)
          .toList();

      if (paths.isNotEmpty) {
        await ref.read(sidebarImagesProvider.notifier).addImages(paths);
      }
    }
  }
}
