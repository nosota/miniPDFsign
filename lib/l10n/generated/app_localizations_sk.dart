// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get openPdf => 'Otvoriť PDF';

  @override
  String get selectPdf => 'Vybrať PDF';

  @override
  String get recentFiles => 'Nedávne súbory';

  @override
  String get removeFromList => 'Odstrániť zo zoznamu';

  @override
  String get openedNow => 'Práve otvorené';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minútami',
      few: 'minútami',
      one: 'minútou',
    );
    return 'Otvorené pred $count $_temp0';
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
    return 'Otvorené pred $count $_temp0';
  }

  @override
  String get openedYesterday => 'Otvorené včera';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dňami',
      few: 'dňami',
      one: 'dňom',
    );
    return 'Otvorené pred $count $_temp0';
  }

  @override
  String get fileNotFound => 'Súbor sa nenašiel';

  @override
  String get fileAccessDenied => 'Prístup zamietnutý';

  @override
  String get clearRecentFiles => 'Vymazať nedávne súbory';

  @override
  String get cancel => 'Zrušiť';

  @override
  String get confirm => 'Potvrdiť';

  @override
  String get error => 'Chyba';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Súbor';

  @override
  String get menuOpen => 'Otvoriť...';

  @override
  String get menuOpenRecent => 'Otvoriť nedávne';

  @override
  String get menuNoRecentFiles => 'Žiadne nedávne súbory';

  @override
  String get menuClearMenu => 'Vymazať ponuku';

  @override
  String get menuSave => 'Uložiť';

  @override
  String get menuSaveAs => 'Uložiť ako...';

  @override
  String get menuSaveAll => 'Uložiť všetko';

  @override
  String get menuShare => 'Zdieľať...';

  @override
  String get menuCloseWindow => 'Zavrieť okno';

  @override
  String get menuCloseAll => 'Zavrieť všetko';

  @override
  String get menuQuit => 'Ukončiť PDFSign';

  @override
  String get closeAllDialogTitle => 'Uložiť zmeny?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Chcete uložiť zmeny v $count dokumentoch pred zatvorením?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Chcete uložiť zmeny v 1 dokumente pred zatvorením?';

  @override
  String get closeAllDialogSaveAll => 'Uložiť všetko';

  @override
  String get closeAllDialogDontSave => 'Neuložiť';

  @override
  String get closeAllDialogCancel => 'Zrušiť';

  @override
  String get saveFailedDialogTitle => 'Uloženie zlyhalo';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Nepodarilo sa uložiť $count dokument(ov). Napriek tomu zavrieť?';
  }

  @override
  String get saveFailedDialogClose => 'Napriek tomu zavrieť';

  @override
  String get saveChangesTitle => 'Uložiť zmeny?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Chcete uložiť zmeny v \"$fileName\" pred zatvorením?';
  }

  @override
  String get saveButton => 'Uložiť';

  @override
  String get discardButton => 'Neuložiť';

  @override
  String get documentEdited => 'Upravené';

  @override
  String get documentSaved => 'Uložené';

  @override
  String get menuSettings => 'Nastavenia...';

  @override
  String get menuWindow => 'Okno';

  @override
  String get menuMinimize => 'Minimalizovať';

  @override
  String get menuZoom => 'Zväčšiť';

  @override
  String get menuBringAllToFront => 'Preniesť všetko dopredu';

  @override
  String get settingsTitle => 'Nastavenia';

  @override
  String get settingsLanguage => 'Jazyk';

  @override
  String get settingsLanguageSystem => 'Predvolený systémový';

  @override
  String get settingsUnits => 'Jednotky';

  @override
  String get settingsUnitsCentimeters => 'Centimetre';

  @override
  String get settingsUnitsInches => 'Palce';

  @override
  String get settingsSearchLanguages => 'Hľadať jazyky...';

  @override
  String get settingsGeneral => 'Všeobecné';

  @override
  String get addImage => 'Pridať obrázok';

  @override
  String get selectImages => 'Vybrať obrázky';

  @override
  String get zoomFitWidth => 'Prispôsobiť šírke';

  @override
  String get zoomIn => 'Priblížiť';

  @override
  String get zoomOut => 'Oddialiť';

  @override
  String get selectZoomLevel => 'Vybrať úroveň priblíženia';

  @override
  String get goToPage => 'Prejsť na stranu';

  @override
  String get go => 'Prejsť';

  @override
  String get savePdfAs => 'Uložiť PDF ako';

  @override
  String get incorrectPassword => 'Nesprávne heslo';

  @override
  String get saveFailed => 'Uloženie zlyhalo';

  @override
  String savedTo(String path) {
    return 'Uložené do: $path';
  }

  @override
  String get noOriginalPdfStored => 'Žiadne pôvodné PDF nie je uložené';

  @override
  String get waitingForFolderPermission =>
      'Čakanie na povolenie prístupu k priečinku...';
}
