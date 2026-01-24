import 'package:flutter/material.dart';

import 'package:pdfsign/l10n/generated/app_localizations.dart';

/// Result of the save changes dialog.
enum SaveChangesResult {
  /// User chose to save changes.
  save,

  /// User chose to discard changes.
  discard,
}

/// Dialog shown when closing a window with unsaved changes.
///
/// Offers two options: Save or Discard.
class SaveChangesDialog extends StatelessWidget {
  const SaveChangesDialog({
    required this.fileName,
    super.key,
  });

  /// Name of the file with unsaved changes.
  final String fileName;

  /// Shows the dialog and returns the user's choice.
  ///
  /// Returns null if the dialog is dismissed without a choice.
  static Future<SaveChangesResult?> show(
    BuildContext context,
    String fileName,
  ) {
    return showDialog<SaveChangesResult>(
      context: context,
      barrierDismissible: false,
      builder: (_) => SaveChangesDialog(fileName: fileName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.saveChangesTitle),
      content: Text(l10n.saveChangesMessage(fileName)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, SaveChangesResult.discard),
          child: Text(l10n.discardButton),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, SaveChangesResult.save),
          child: Text(l10n.saveButton),
        ),
      ],
    );
  }
}
