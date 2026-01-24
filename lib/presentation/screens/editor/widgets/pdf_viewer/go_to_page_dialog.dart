import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pdfsign/core/theme/app_colors.dart';

/// Dialog for navigating to a specific page.
class GoToPageDialog extends StatefulWidget {
  const GoToPageDialog({
    required this.currentPage,
    required this.totalPages,
    super.key,
  });

  final int currentPage;
  final int totalPages;

  /// Shows the dialog and returns the selected page number, or null if cancelled.
  static Future<int?> show(
    BuildContext context, {
    required int currentPage,
    required int totalPages,
  }) {
    return showDialog<int>(
      context: context,
      builder: (context) => GoToPageDialog(
        currentPage: currentPage,
        totalPages: totalPages,
      ),
    );
  }

  @override
  State<GoToPageDialog> createState() => _GoToPageDialogState();
}

class _GoToPageDialogState extends State<GoToPageDialog> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentPage.toString());
    _focusNode = FocusNode();

    // Select all text when dialog opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _controller.text.length,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final pageNumber = int.tryParse(_controller.text);
    if (pageNumber == null) {
      setState(() {
        _errorText = 'Please enter a valid number';
      });
      return;
    }

    if (pageNumber < 1 || pageNumber > widget.totalPages) {
      setState(() {
        _errorText = 'Page must be between 1 and ${widget.totalPages}';
      });
      return;
    }

    Navigator.of(context).pop(pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Go to Page'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter page number (1-${widget.totalPages}):',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              errorText: _errorText,
              hintText: 'Page number',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
            onSubmitted: (_) => _submit(),
            onChanged: (_) {
              if (_errorText != null) {
                setState(() {
                  _errorText = null;
                });
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Go'),
        ),
      ],
    );
  }
}
