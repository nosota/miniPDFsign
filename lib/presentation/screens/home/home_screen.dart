import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../settings/settings_screen.dart';
import 'widgets/mobile_home_view.dart';

/// Main home screen for mobile.
///
/// Displays centered app logo with Open PDF button and recent files list.
/// On Android, includes a menu for accessing Settings.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // On Android, show AppBar with settings menu
    // On iOS, settings are in the system Settings app
    if (Platform.isAndroid) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('miniPDFSign'),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'settings') {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                }
              },
              itemBuilder: (context) {
                final l10n = AppLocalizations.of(context)!;
                return [
                  PopupMenuItem<String>(
                    value: 'settings',
                    child: Row(
                      children: [
                        const Icon(Icons.settings, size: 20),
                        const SizedBox(width: 12),
                        Text(l10n.settingsTitle),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: const MobileHomeView(),
      );
    }

    // On iOS, no AppBar - settings are in system Settings app
    return const Scaffold(
      body: MobileHomeView(),
    );
  }
}
