import 'package:flutter/material.dart';

import 'package:minipdfsign/l10n/generated/app_localizations.dart';
import 'package:minipdfsign/presentation/screens/pdf_viewer/widgets/bottom_sheet/bottom_sheet_constants.dart';

/// Empty state shown when the image library has no images.
class EmptyLibraryState extends StatelessWidget {
  const EmptyLibraryState({
    required this.onAddTap,
    this.addButtonKey,
    super.key,
  });

  final VoidCallback onAddTap;

  /// Optional key for the add button (used for onboarding coach mark).
  final GlobalKey? addButtonKey;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.image_outlined,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noImagesYet,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.noImagesHint,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
            ),
            const SizedBox(height: 24),
            _AddButton(key: addButtonKey, onTap: onAddTap),
          ],
        ),
      ),
    );
  }
}

/// Add image button used in empty state and grid.
class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: BottomSheetConstants.thumbnailSizeCollapsed,
        height: BottomSheetConstants.thumbnailSizeCollapsed,
        decoration: BoxDecoration(
          color: BottomSheetConstants.thumbnailBackgroundColor,
          borderRadius: BorderRadius.circular(
            BottomSheetConstants.thumbnailBorderRadius,
          ),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.primary,
          size: 28,
        ),
      ),
    );
  }
}
