// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get openPdf => 'Otevřít PDF';

  @override
  String get selectPdf => 'Vybrat PDF';

  @override
  String get recentFiles => 'Nedávné soubory';

  @override
  String get removeFromList => 'Odebrat ze seznamu';

  @override
  String get openedNow => 'Právě otevřeno';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutami',
      few: 'minutami',
      one: 'minutou',
    );
    return 'Otevřeno před $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hodinami',
      few: 'hodinami',
      one: 'hodinou',
    );
    return 'Otevřeno před $count $_temp0';
  }

  @override
  String get openedYesterday => 'Otevřeno včera';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dny',
      few: 'dny',
      one: 'dnem',
    );
    return 'Otevřeno před $count $_temp0';
  }

  @override
  String get fileNotFound => 'Soubor nenalezen';

  @override
  String get fileAccessDenied => 'Přístup odepřen';

  @override
  String get clearRecentFiles => 'Vymazat nedávné soubory';

  @override
  String get cancel => 'Zrušit';

  @override
  String get confirm => 'Potvrdit';

  @override
  String get error => 'Chyba';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Soubor';

  @override
  String get menuOpen => 'Otevřít...';

  @override
  String get menuOpenRecent => 'Otevřít nedávné';

  @override
  String get menuNoRecentFiles => 'Žádné nedávné soubory';

  @override
  String get menuClearMenu => 'Vymazat nabídku';

  @override
  String get menuSave => 'Uložit';

  @override
  String get menuSaveAs => 'Uložit jako...';

  @override
  String get menuSaveAll => 'Uložit vše';

  @override
  String get menuShare => 'Sdílet...';

  @override
  String get menuCloseWindow => 'Zavřít okno';

  @override
  String get menuCloseAll => 'Zavřít vše';

  @override
  String get menuQuit => 'Ukončit PDFSign';

  @override
  String get closeAllDialogTitle => 'Uložit změny?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Chcete uložit změny v $count dokumentech před zavřením?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Chcete uložit změny v 1 dokumentu před zavřením?';

  @override
  String get closeAllDialogSaveAll => 'Uložit vše';

  @override
  String get closeAllDialogDontSave => 'Neukládat';

  @override
  String get closeAllDialogCancel => 'Zrušit';

  @override
  String get saveFailedDialogTitle => 'Uložení se nezdařilo';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Nepodařilo se uložit $count dokument(ů). Přesto zavřít?';
  }

  @override
  String get saveFailedDialogClose => 'Přesto zavřít';

  @override
  String get saveChangesTitle => 'Uložit změny?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Chcete uložit změny v \"$fileName\" před zavřením?';
  }

  @override
  String get saveButton => 'Uložit';

  @override
  String get discardButton => 'Neukládat';

  @override
  String get documentEdited => 'Upraveno';

  @override
  String get documentSaved => 'Uloženo';

  @override
  String get menuSettings => 'Nastavení...';

  @override
  String get menuWindow => 'Okno';

  @override
  String get menuMinimize => 'Minimalizovat';

  @override
  String get menuZoom => 'Zvětšit';

  @override
  String get menuBringAllToFront => 'Přenést vše dopředu';

  @override
  String get settingsTitle => 'Nastavení';

  @override
  String get settingsLanguage => 'Jazyk';

  @override
  String get settingsLanguageSystem => 'Výchozí systémový';

  @override
  String get settingsUnits => 'Jednotky';

  @override
  String get settingsUnitsCentimeters => 'Centimetry';

  @override
  String get settingsUnitsInches => 'Palce';

  @override
  String get settingsSearchLanguages => 'Hledat jazyky...';

  @override
  String get settingsGeneral => 'Obecné';

  @override
  String get addImage => 'Přidat obrázek';

  @override
  String get selectImages => 'Vybrat obrázky';

  @override
  String get zoomFitWidth => 'Přizpůsobit šířce';

  @override
  String get zoomIn => 'Přiblížit';

  @override
  String get zoomOut => 'Oddálit';

  @override
  String get selectZoomLevel => 'Vybrat úroveň přiblížení';

  @override
  String get goToPage => 'Přejít na stránku';

  @override
  String get go => 'Přejít';

  @override
  String get savePdfAs => 'Uložit PDF jako';

  @override
  String get incorrectPassword => 'Nesprávné heslo';

  @override
  String get saveFailed => 'Uložení selhalo';

  @override
  String savedTo(String path) {
    return 'Uloženo do: $path';
  }

  @override
  String get noOriginalPdfStored => 'Žádné původní PDF není uloženo';

  @override
  String get waitingForFolderPermission =>
      'Čekání na povolení přístupu ke složce...';
}
