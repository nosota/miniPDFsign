#!/usr/bin/env python3
"""
Generate iOS Settings.bundle Root.strings files from Flutter ARB files.

This script reads the ARB translation files and generates corresponding
.lproj/Root.strings files for the Settings.bundle.
"""

import json
import os
import re
from pathlib import Path

# Mapping from ARB file names to iOS locale codes
LOCALE_MAPPING = {
    'app_ar.arb': 'ar',
    'app_az.arb': 'az',
    'app_be.arb': 'be',
    'app_bg.arb': 'bg',
    'app_bn.arb': 'bn',
    'app_ca.arb': 'ca',
    'app_cs.arb': 'cs',
    'app_da.arb': 'da',
    'app_de.arb': 'de',
    'app_el.arb': 'el',
    'app_en.arb': 'en',
    'app_en_AU.arb': 'en-AU',
    'app_en_GB.arb': 'en-GB',
    'app_en_NZ.arb': 'en-NZ',
    'app_en_US.arb': 'en-US',
    'app_eo.arb': 'eo',
    'app_es.arb': 'es',
    'app_es_AR.arb': 'es-AR',
    'app_es_ES.arb': 'es-ES',
    'app_es_MX.arb': 'es-MX',
    'app_et.arb': 'et',
    'app_eu.arb': 'eu',
    'app_fa.arb': 'fa',
    'app_fi.arb': 'fi',
    'app_fil.arb': 'fil',
    'app_fr.arb': 'fr',
    'app_he.arb': 'he',
    'app_hi.arb': 'hi',
    'app_hr.arb': 'hr',
    'app_hu.arb': 'hu',
    'app_hy.arb': 'hy',
    'app_id.arb': 'id',
    'app_is.arb': 'is',
    'app_it.arb': 'it',
    'app_ja.arb': 'ja',
    'app_ka.arb': 'ka',
    'app_kk.arb': 'kk',
    'app_km.arb': 'km',
    'app_ko.arb': 'ko',
    'app_lt.arb': 'lt',
    'app_lv.arb': 'lv',
    'app_mn.arb': 'mn',
    'app_ms.arb': 'ms',
    'app_my.arb': 'my',
    'app_nb.arb': 'nb',
    'app_nl.arb': 'nl',
    'app_pl.arb': 'pl',
    'app_pt_BR.arb': 'pt-BR',
    'app_pt_PT.arb': 'pt-PT',
    'app_ro.arb': 'ro',
    'app_ru.arb': 'ru',
    'app_sk.arb': 'sk',
    'app_sl.arb': 'sl',
    'app_sq.arb': 'sq',
    'app_sr.arb': 'sr',
    'app_sv.arb': 'sv',
    'app_ta.arb': 'ta',
    'app_th.arb': 'th',
    'app_tr.arb': 'tr',
    'app_uk.arb': 'uk',
    'app_uz.arb': 'uz',
    'app_vi.arb': 'vi',
    'app_zh_Hans.arb': 'zh-Hans',
    'app_zh_Hant.arb': 'zh-Hant',
}

# Keys to extract from ARB files
ARB_KEYS = {
    'settingsGeneral': 'General',
    'settingsLanguage': 'Language',
    'settingsLanguageSystem': 'System Default',
    'settingsUnits': 'Units',
    'settingsUnitsCentimeters': 'Centimeters',
    'settingsUnitsInches': 'Inches',
}

# Additional key for "Default (by region)" - need to add to ARB files
DEFAULT_BY_REGION_KEY = 'settingsUnitsDefault'


def escape_strings_value(value: str) -> str:
    """Escape special characters for .strings file format."""
    value = value.replace('\\', '\\\\')
    value = value.replace('"', '\\"')
    value = value.replace('\n', '\\n')
    return value


def generate_strings_content(translations: dict, locale: str) -> str:
    """Generate Root.strings file content."""
    lines = [f'/* Settings.bundle localization - {locale} */\n']

    # Section title
    general = translations.get('settingsGeneral', 'General')
    lines.append(f'\n/* Section title */')
    lines.append(f'"General" = "{escape_strings_value(general)}";')

    # Language setting
    language = translations.get('settingsLanguage', 'Language')
    system_default = translations.get('settingsLanguageSystem', 'System Default')
    lines.append(f'\n/* Language setting */')
    lines.append(f'"Language" = "{escape_strings_value(language)}";')
    lines.append(f'"System Default" = "{escape_strings_value(system_default)}";')

    # Units setting
    units = translations.get('settingsUnits', 'Units')
    default_by_region = translations.get('settingsUnitsDefault', 'Default (by region)')
    centimeters = translations.get('settingsUnitsCentimeters', 'Centimeters')
    inches = translations.get('settingsUnitsInches', 'Inches')
    lines.append(f'\n/* Units setting */')
    lines.append(f'"Units" = "{escape_strings_value(units)}";')
    lines.append(f'"Default (by region)" = "{escape_strings_value(default_by_region)}";')
    lines.append(f'"Centimeters" = "{escape_strings_value(centimeters)}";')
    lines.append(f'"Inches" = "{escape_strings_value(inches)}";')

    return '\n'.join(lines) + '\n'


def main():
    # Paths
    script_dir = Path(__file__).parent
    project_root = script_dir.parent
    l10n_dir = project_root / 'lib' / 'l10n'
    settings_bundle = project_root / 'ios' / 'Runner' / 'Settings.bundle'

    print(f"Reading ARB files from: {l10n_dir}")
    print(f"Writing to: {settings_bundle}")

    # Process each ARB file
    for arb_file, ios_locale in LOCALE_MAPPING.items():
        arb_path = l10n_dir / arb_file

        if not arb_path.exists():
            print(f"  Skipping {arb_file} (not found)")
            continue

        # Read ARB file
        with open(arb_path, 'r', encoding='utf-8') as f:
            try:
                arb_data = json.load(f)
            except json.JSONDecodeError as e:
                print(f"  Error parsing {arb_file}: {e}")
                continue

        # Extract translations
        translations = {}
        for arb_key in list(ARB_KEYS.keys()) + [DEFAULT_BY_REGION_KEY]:
            if arb_key in arb_data:
                translations[arb_key] = arb_data[arb_key]

        # Create lproj directory
        lproj_dir = settings_bundle / f'{ios_locale}.lproj'
        lproj_dir.mkdir(parents=True, exist_ok=True)

        # Generate and write Root.strings
        content = generate_strings_content(translations, ios_locale)
        strings_path = lproj_dir / 'Root.strings'

        with open(strings_path, 'w', encoding='utf-8') as f:
            f.write(content)

        print(f"  Created {ios_locale}.lproj/Root.strings")

    print("\nDone!")


if __name__ == '__main__':
    main()
