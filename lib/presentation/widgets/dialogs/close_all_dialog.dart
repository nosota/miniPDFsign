import 'package:flutter/material.dart';

import 'package:pdfsign/l10n/generated/app_localizations.dart';

/// Result of the close all dialog.
enum CloseAllResult {
  /// User chose to save all changes before closing.
  saveAll,

  /// User chose to discard all changes and close.
  discard,

  /// User chose to cancel the close operation.
  cancel,
}

/// Dialog shown when closing all windows with unsaved changes.
///
/// Offers three options: Don't Save, Cancel, Save All.
class CloseAllDialog extends StatelessWidget {
  const CloseAllDialog({
    required this.dirtyCount,
    super.key,
  });

  /// Number of documents with unsaved changes.
  final int dirtyCount;

  /// Shows the dialog and returns the user's choice.
  ///
  /// Returns null if the dialog is dismissed without a choice.
  static Future<CloseAllResult?> show(
    BuildContext context,
    int dirtyCount,
  ) {
    return showDialog<CloseAllResult>(
      context: context,
      barrierDismissible: false,
      builder: (_) => CloseAllDialog(dirtyCount: dirtyCount),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Use singular or plural message based on count
    final message = dirtyCount == 1
        ? l10n.closeAllDialogMessageOne
        : l10n.closeAllDialogMessage(dirtyCount);

    return AlertDialog(
      title: Text(l10n.closeAllDialogTitle),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, CloseAllResult.discard),
          child: Text(l10n.closeAllDialogDontSave),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, CloseAllResult.cancel),
          child: Text(l10n.closeAllDialogCancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, CloseAllResult.saveAll),
          child: Text(l10n.closeAllDialogSaveAll),
        ),
      ],
    );
  }
}
