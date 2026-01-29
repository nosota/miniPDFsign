import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:minipdfsign/presentation/providers/shared_preferences_provider.dart';

part 'onboarding_provider.g.dart';

/// Steps in the contextual onboarding flow.
///
/// Each step is shown once and persisted in SharedPreferences.
enum OnboardingStep {
  /// First launch: "Tap to open a PDF document"
  openPdf('onboarding_shown_open_pdf'),

  /// First PDF opened: "Swipe up to add signatures and stamps"
  swipeUp('onboarding_shown_swipe_up'),

  /// First time opening empty library: "Tap to add your first signature"
  addImage('onboarding_shown_add_image'),

  /// After adding first image: "Drag onto PDF to place it"
  dragImage('onboarding_shown_drag_image'),

  /// After placing first object: "Tap to select. Drag corners to resize."
  resizeObject('onboarding_shown_resize'),

  /// After first selection: "Tap to delete the selected image"
  deleteImage('onboarding_shown_delete');

  const OnboardingStep(this.key);

  /// SharedPreferences key for this step.
  final String key;
}

/// Provider for managing onboarding state.
///
/// Tracks which onboarding steps have been shown to the user.
/// State is persisted in SharedPreferences.
@Riverpod(keepAlive: true)
class Onboarding extends _$Onboarding {
  late SharedPreferences _prefs;

  @override
  Set<OnboardingStep> build() {
    _prefs = ref.watch(sharedPreferencesProvider);

    // Load all shown steps from SharedPreferences
    final shownSteps = <OnboardingStep>{};
    for (final step in OnboardingStep.values) {
      if (_prefs.getBool(step.key) ?? false) {
        shownSteps.add(step);
      }
    }
    return shownSteps;
  }

  /// Checks if the given step has been shown.
  bool isShown(OnboardingStep step) {
    return state.contains(step);
  }

  /// Checks if the given step should be shown (not yet shown).
  bool shouldShow(OnboardingStep step) {
    return !state.contains(step);
  }

  /// Marks the given step as shown.
  ///
  /// Persists to SharedPreferences and updates state.
  Future<void> markShown(OnboardingStep step) async {
    if (state.contains(step)) return;

    await _prefs.setBool(step.key, true);
    state = {...state, step};
  }

  /// Resets all onboarding steps (for testing/debugging).
  ///
  /// Clears all steps from SharedPreferences and state.
  Future<void> resetAll() async {
    for (final step in OnboardingStep.values) {
      await _prefs.remove(step.key);
    }
    state = {};
  }
}
