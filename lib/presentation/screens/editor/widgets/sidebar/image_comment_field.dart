import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Inline editable comment field for sidebar images.
///
/// Display mode: shows comment text (or empty clickable area).
/// Edit mode: inline TextField with Enter to save, Escape to cancel.
class ImageCommentField extends StatefulWidget {
  const ImageCommentField({
    required this.comment,
    required this.onCommentChanged,
    this.onEditingStarted,
    super.key,
  });

  /// Current comment text (null if no comment).
  final String? comment;

  /// Called when the comment changes.
  final void Function(String?) onCommentChanged;

  /// Called when editing starts (user taps to edit).
  /// Use this to clear other selections or prepare UI.
  final VoidCallback? onEditingStarted;

  @override
  State<ImageCommentField> createState() => _ImageCommentFieldState();
}

class _ImageCommentFieldState extends State<ImageCommentField> {
  bool _isEditing = false;
  bool _isHovered = false;
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.comment ?? '');
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ImageCommentField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update text when comment changes externally (not during editing)
    if (!_isEditing && widget.comment != oldWidget.comment) {
      _controller.text = widget.comment ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isEditing ? _buildTextField() : _buildDisplayMode();
  }

  Widget _buildDisplayMode() {
    final theme = Theme.of(context);
    final hasComment = widget.comment != null && widget.comment!.isNotEmpty;

    return MouseRegion(
      cursor: SystemMouseCursors.text,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _startEditing,
        child: Container(
          height: 20,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            border: _isHovered
                ? Border(
                    bottom: BorderSide(
                      color: theme.colorScheme.outline.withOpacity(0.5),
                      width: 1,
                    ),
                  )
                : null,
          ),
          child: hasComment
              ? Tooltip(
                  message: widget.comment!,
                  waitDuration: const Duration(milliseconds: 500),
                  child: Text(
                    widget.comment!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              : const SizedBox.expand(),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    final theme = Theme.of(context);

    return Focus(
      onKeyEvent: _handleKeyEvent,
      child: SizedBox(
        height: 20,
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          autofocus: true,
          style: TextStyle(
            fontSize: 12,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 4),
            border: InputBorder.none,
            hintText: 'Comment',
          ),
          onSubmitted: _saveAndClose,
          onTapOutside: (_) => _saveAndClose(_controller.text),
        ),
      ),
    );
  }

  void _startEditing() {
    widget.onEditingStarted?.call();
    _controller.text = widget.comment ?? '';
    _controller.selection = TextSelection.collapsed(
      offset: _controller.text.length,
    );
    setState(() => _isEditing = true);
    // Request focus after TextField appears in the widget tree
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void _saveAndClose(String value) {
    final trimmed = value.trim();
    widget.onCommentChanged(trimmed.isEmpty ? null : trimmed);
    setState(() => _isEditing = false);
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.escape) {
      // Cancel editing without saving
      setState(() => _isEditing = false);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}
