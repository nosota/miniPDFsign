import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfsign/core/utils/platform_utils.dart';
import 'package:pdfsign/presentation/screens/welcome/widgets/desktop_welcome_view.dart';
import 'package:pdfsign/presentation/screens/welcome/widgets/mobile_welcome_view.dart';

/// Main welcome screen with platform-adaptive layout.
///
/// Shows different layouts for desktop and mobile:
/// - Desktop: Welcome screen with Open PDF button + recent files list
/// - Mobile: Splash-style screen with Select PDF button
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: PlatformUtils.isDesktop
          ? const DesktopWelcomeView()
          : const MobileWelcomeView(),
    );
  }
}
