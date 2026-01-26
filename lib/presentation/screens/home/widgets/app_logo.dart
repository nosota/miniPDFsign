import 'package:flutter/material.dart';
import 'package:minipdfsign/core/constants/spacing.dart';
import 'package:minipdfsign/core/theme/app_typography.dart';

/// Application logo widget displayed on home screen.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/app_icon.png',
          width: 80,
          height: 80,
        ),
        const SizedBox(height: Spacing.spacing16),
        const Text(
          'miniPDFSign',
          style: AppTypography.displayLarge,
        ),
      ],
    );
  }
}
