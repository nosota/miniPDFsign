import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../providers/editor/size_unit_preference_provider.dart';
import '../../providers/locale_preference_provider.dart';
import '../../providers/native_settings_provider.dart';

/// Settings screen for Android.
///
/// Provides language and units configuration.
/// On iOS, these settings are available in the system Settings app.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localePreferenceProvider);
    final currentUnit = ref.watch(sizeUnitPreferenceProvider);
    final nativeSettings = ref.watch(nativeSettingsProvider);
    final isUnitExplicitlySet = nativeSettings.sizeUnitPreference != null &&
        nativeSettings.sizeUnitPreference!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
      ),
      body: ListView(
        children: [
          // General Section
          _SectionHeader(title: l10n.settingsGeneral),

          // Language
          ListTile(
            title: Text(l10n.settingsLanguage),
            subtitle: Text(_getLanguageDisplayName(currentLocale, l10n)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLanguagePicker(context, ref, currentLocale),
          ),

          const Divider(height: 1),

          // Units
          ListTile(
            title: Text(l10n.settingsUnits),
            subtitle: Text(_getUnitDisplayName(currentUnit, isUnitExplicitlySet, l10n)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showUnitPicker(context, ref, currentUnit, isUnitExplicitlySet),
          ),
        ],
      ),
    );
  }

  String _getLanguageDisplayName(String? localeCode, AppLocalizations l10n) {
    if (localeCode == null) {
      return l10n.settingsLanguageSystem;
    }
    for (final locale in supportedLocales) {
      if (locale.code == localeCode) {
        return locale.displayName;
      }
    }
    return l10n.settingsLanguageSystem;
  }

  String _getUnitDisplayName(SizeUnit? unit, bool isExplicitlySet, AppLocalizations l10n) {
    if (!isExplicitlySet) {
      return l10n.settingsUnitsDefault;
    }
    switch (unit) {
      case SizeUnit.cm:
        return l10n.settingsUnitsCentimeters;
      case SizeUnit.inch:
        return l10n.settingsUnitsInches;
      case null:
        return l10n.settingsUnitsDefault;
    }
  }

  void _showLanguagePicker(
    BuildContext context,
    WidgetRef ref,
    String? currentLocale,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => _LanguagePickerScreen(currentLocale: currentLocale),
      ),
    );
  }

  void _showUnitPicker(
    BuildContext context,
    WidgetRef ref,
    SizeUnit currentUnit,
    bool isExplicitlySet,
  ) {
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Default (by region) option
            ListTile(
              title: Text(l10n.settingsUnitsDefault),
              trailing: !isExplicitlySet
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                ref.read(sizeUnitPreferenceNotifierProvider).clear();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(l10n.settingsUnitsCentimeters),
              trailing: isExplicitlySet && currentUnit == SizeUnit.cm
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                ref.read(sizeUnitPreferenceNotifierProvider).setUnit(SizeUnit.cm);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(l10n.settingsUnitsInches),
              trailing: isExplicitlySet && currentUnit == SizeUnit.inch
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                ref.read(sizeUnitPreferenceNotifierProvider).setUnit(SizeUnit.inch);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.grey[600],
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

/// Language picker screen with search functionality.
class _LanguagePickerScreen extends ConsumerStatefulWidget {
  const _LanguagePickerScreen({required this.currentLocale});

  final String? currentLocale;

  @override
  ConsumerState<_LanguagePickerScreen> createState() =>
      _LanguagePickerScreenState();
}

class _LanguagePickerScreenState extends ConsumerState<_LanguagePickerScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<SupportedLocale> get _filteredLocales {
    if (_searchQuery.isEmpty) {
      return supportedLocales;
    }
    final query = _searchQuery.toLowerCase();
    return supportedLocales.where((locale) {
      return locale.nativeName.toLowerCase().contains(query) ||
          locale.englishName.toLowerCase().contains(query) ||
          locale.code.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filteredLocales = _filteredLocales;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsLanguage),
      ),
      body: Column(
        children: [
          // Search field
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.settingsSearchLanguages,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Language list
          Expanded(
            child: ListView.builder(
              itemCount: filteredLocales.length + 1, // +1 for System Default
              itemBuilder: (context, index) {
                if (index == 0) {
                  // System Default option
                  final isSelected = widget.currentLocale == null;
                  return ListTile(
                    title: Text(l10n.settingsLanguageSystem),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: Colors.blue)
                        : null,
                    onTap: () {
                      ref.read(localePreferenceNotifierProvider).setLocale(null);
                      Navigator.pop(context);
                    },
                  );
                }

                final locale = filteredLocales[index - 1];
                final isSelected = locale.code == widget.currentLocale;

                return ListTile(
                  title: Text(locale.nativeName),
                  subtitle: locale.nativeName != locale.englishName
                      ? Text(locale.englishName)
                      : null,
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    ref.read(localePreferenceNotifierProvider).setLocale(locale.code);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
