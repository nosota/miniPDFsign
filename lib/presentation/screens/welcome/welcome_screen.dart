import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minipdfsign/presentation/screens/welcome/widgets/mobile_welcome_view.dart';

/// Main welcome screen for mobile.
///
/// Displays centered app logo with Open PDF button and recent files list.
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: MobileWelcomeView(),
    );
  }
}
