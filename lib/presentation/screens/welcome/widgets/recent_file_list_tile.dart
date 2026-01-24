import 'package:flutter/material.dart';
import 'package:pdfsign/core/constants/radii.dart';
import 'package:pdfsign/core/theme/app_colors.dart';
import 'package:pdfsign/core/theme/app_typography.dart';
import 'package:pdfsign/core/utils/date_formatter.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';

/// Individual recent file entry tile.
class RecentFileListTile extends StatelessWidget {
  const RecentFileListTile({
    required this.file,
    required this.onTap,
    required this.onRemove,
    super.key,
  });

  final RecentFile file;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: Radii.mediumRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                file.isPasswordProtected
                    ? Icons.lock_outline
                    : Icons.picture_as_pdf,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.fileName,
                      style: AppTypography.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      formatRelativeTime(file.lastOpened, context),
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                onPressed: onRemove,
                splashRadius: 20,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
