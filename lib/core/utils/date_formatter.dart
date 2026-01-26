import 'package:flutter/material.dart';
import 'package:minipdfsign/l10n/generated/app_localizations.dart';

/// Formats a DateTime as a relative time string.
///
/// Returns localized strings like "just now", "5 minutes ago",
/// "2 hours ago", "yesterday", "3 days ago".
String formatRelativeTime(DateTime dateTime, BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 1) {
    return l10n.openedNow;
  } else if (difference.inMinutes < 60) {
    return l10n.openedMinutesAgo(difference.inMinutes);
  } else if (difference.inHours < 24) {
    return l10n.openedHoursAgo(difference.inHours);
  } else if (difference.inDays == 1) {
    return l10n.openedYesterday;
  } else if (difference.inDays < 30) {
    return l10n.openedDaysAgo(difference.inDays);
  } else {
    // For older dates, show the actual date
    return l10n.openedDaysAgo(difference.inDays);
  }
}
