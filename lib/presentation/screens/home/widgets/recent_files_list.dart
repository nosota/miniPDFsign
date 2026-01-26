import 'package:flutter/material.dart';
import 'package:minipdfsign/l10n/generated/app_localizations.dart';
import 'package:minipdfsign/core/constants/radii.dart';
import 'package:minipdfsign/core/constants/spacing.dart';
import 'package:minipdfsign/core/theme/app_colors.dart';
import 'package:minipdfsign/core/theme/app_typography.dart';
import 'package:minipdfsign/domain/entities/recent_file.dart';
import 'package:minipdfsign/presentation/screens/home/widgets/recent_file_list_tile.dart';

/// List of recent files for home screen.
class RecentFilesList extends StatelessWidget {
  const RecentFilesList({
    required this.files,
    required this.onFileTap,
    required this.onFileRemove,
    this.showHeader = true,
    super.key,
  });

  final List<RecentFile> files;
  final void Function(RecentFile) onFileTap;
  final void Function(RecentFile) onFileRemove;

  /// Whether to show the "Recent Files" header.
  /// Set to false when header is shown externally (e.g., in fixed area).
  final bool showHeader;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showHeader) ...[
          Text(
            l10n.recentFiles,
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: Spacing.spacing12),
        ],
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: Radii.largeRadius,
            border: Border.all(color: AppColors.border),
          ),
          child: ClipRRect(
            borderRadius: Radii.largeRadius,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < files.length; i++) ...[
                  RecentFileListTile(
                    file: files[i],
                    onTap: () => onFileTap(files[i]),
                    onRemove: () => onFileRemove(files[i]),
                  ),
                  if (i < files.length - 1)
                    const Divider(
                      height: 1,
                      indent: 52,
                    ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
