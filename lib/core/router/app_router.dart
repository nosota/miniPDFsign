import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:minipdfsign/presentation/screens/welcome/welcome_screen.dart';
import 'package:minipdfsign/presentation/screens/editor/editor_screen.dart';

part 'app_router.g.dart';

/// Application router configuration.
///
/// Routes:
/// - `/` - Welcome screen (file picker)
/// - `/editor` - PDF editor screen
@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/editor',
        name: 'editor',
        builder: (context, state) {
          final filePath = state.extra as String?;
          return EditorScreen(filePath: filePath);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
}
