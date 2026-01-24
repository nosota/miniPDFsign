import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for pre-loaded SharedPreferences instance.
///
/// This provider MUST be overridden in main() with the pre-loaded
/// SharedPreferences instance. It will throw if accessed without override.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden with a pre-loaded instance',
  );
});
