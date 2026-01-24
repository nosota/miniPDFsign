import 'package:flutter/material.dart';

/// Application color palette.
///
/// Per REQUIREMENTS.md UI-1.1 (Light Theme).
abstract final class AppColors {
  // Background
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F5F7);
  static const Color border = Color(0xFFE5E5E7);

  // Text
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textDisabled = Color(0xFFB0B0B0);

  // Accent / Primary
  static const Color primary = Color(0xFF0066FF);
  static const Color primaryHover = Color(0xFF0052CC);
  static const Color primaryPressed = Color(0xFF003D99);

  // Semantic
  static const Color error = Color(0xFFDC3545);
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFFC107);

  // Selection (for object handles)
  static const Color selection = Color(0xFF0066FF);
  static const Color selectionHandle = Color(0xFFFFFFFF);
  static const Color selectionHandleBorder = Color(0xFF0066FF);

  // Hover state (4% opacity of primary)
  static const Color hover = Color(0x0A0066FF);
}
