import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pdfsign/core/constants/sidebar_constants.dart';

part 'sidebar_width_provider.g.dart';

/// Provider for the sidebar panel width.
///
/// Width is local to each window (not synced) and clamped to min/max bounds.
@riverpod
class SidebarWidth extends _$SidebarWidth {
  @override
  double build() => SidebarConstants.defaultWidth;

  /// Sets the sidebar width, clamped to allowed bounds.
  void setWidth(double width) {
    state = width.clamp(
      SidebarConstants.minWidth,
      SidebarConstants.maxWidth,
    );
  }

  /// Adjusts the width by a delta amount.
  void adjustWidth(double delta) {
    setWidth(state + delta);
  }

  /// Resets to default width.
  void reset() {
    state = SidebarConstants.defaultWidth;
  }
}
