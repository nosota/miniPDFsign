import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minipdfsign/presentation/screens/home/widgets/mobile_home_view.dart';

/// Main home screen for mobile.
///
/// Displays centered app logo with Open PDF button and recent files list.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: MobileHomeView(),
    );
  }
}
