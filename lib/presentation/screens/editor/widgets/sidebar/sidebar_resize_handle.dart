import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/core/constants/sidebar_constants.dart';
import 'package:pdfsign/presentation/providers/sidebar/sidebar_width_provider.dart';

/// Draggable resize handle for the sidebar panel.
///
/// Shows resize cursor on hover and allows horizontal dragging
/// to resize the sidebar width.
class SidebarResizeHandle extends ConsumerStatefulWidget {
  const SidebarResizeHandle({super.key});

  @override
  ConsumerState<SidebarResizeHandle> createState() =>
      _SidebarResizeHandleState();
}

class _SidebarResizeHandleState extends ConsumerState<SidebarResizeHandle> {
  bool _isHovered = false;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final isActive = _isHovered || _isDragging;

    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onHorizontalDragStart: (_) => setState(() => _isDragging = true),
        onHorizontalDragUpdate: (details) {
          // Invert delta for right-side sidebar (drag left = increase width)
          ref.read(sidebarWidthProvider.notifier).adjustWidth(-details.delta.dx);
        },
        onHorizontalDragEnd: (_) => setState(() => _isDragging = false),
        child: Container(
          width: SidebarConstants.resizeHandleWidth,
          color: isActive
              ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
              : Theme.of(context).dividerColor,
        ),
      ),
    );
  }
}
