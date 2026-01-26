// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get openPdf => 'Odpri PDF';

  @override
  String get selectPdf => 'Izberi PDF';

  @override
  String get recentFiles => 'Nedavne datoteke';

  @override
  String get removeFromList => 'Odstrani s seznama';

  @override
  String get openedNow => 'Pravkar odprto';

  @override
  String openedMinutesAgo(int count) {
    return 'Odprto pred $count minutami';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Odprto pred $count urami';
  }

  @override
  String get openedYesterday => 'Odprto vceraj';

  @override
  String openedDaysAgo(int count) {
    return 'Odprto pred $count dnevi';
  }

  @override
  String get fileNotFound => 'Datoteka ni najdena';

  @override
  String get fileAccessDenied => 'Dostop zavrnjen';

  @override
  String get clearRecentFiles => 'Pocisti nedavne datoteke';

  @override
  String get cancel => 'Preklic';

  @override
  String get confirm => 'Potrdi';

  @override
  String get error => 'Napaka';

  @override
  String get ok => 'V redu';

  @override
  String get menuFile => 'Datoteka';

  @override
  String get menuOpen => 'Odpri...';

  @override
  String get menuOpenRecent => 'Odpri nedavne';

  @override
  String get menuNoRecentFiles => 'Ni nedavnih datotek';

  @override
  String get menuClearMenu => 'Pocisti meni';

  @override
  String get menuSave => 'Shrani';

  @override
  String get menuSaveAs => 'Shrani kot...';

  @override
  String get menuSaveAll => 'Shrani vse';

  @override
  String get menuShare => 'Deli...';

  @override
  String get menuCloseWindow => 'Zapri okno';

  @override
  String get menuCloseAll => 'Zapri vse';

  @override
  String get menuQuit => 'Zapusti PDFSign';

  @override
  String get closeAllDialogTitle => 'Shrani spremembe?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Ali želite shraniti spremembe v $count dokumentih pred zaprtjem?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Ali želite shraniti spremembe v 1 dokumentu pred zaprtjem?';

  @override
  String get closeAllDialogSaveAll => 'Shrani vse';

  @override
  String get closeAllDialogDontSave => 'Ne shrani';

  @override
  String get closeAllDialogCancel => 'Preklic';

  @override
  String get saveFailedDialogTitle => 'Shranjevanje ni uspelo';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Shranjevanje $count dokumenta(ov) ni uspelo. Vseeno zaprem?';
  }

  @override
  String get saveFailedDialogClose => 'Vseeno zapri';

  @override
  String get saveChangesTitle => 'Shrani spremembe?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Ali zelite shraniti spremembe v \"$fileName\" pred zaprtjem?';
  }

  @override
  String get saveButton => 'Shrani';

  @override
  String get discardButton => 'Ne shrani';

  @override
  String get documentEdited => 'Urejeno';

  @override
  String get documentSaved => 'Shranjeno';

  @override
  String get menuSettings => 'Nastavitve...';

  @override
  String get menuWindow => 'Okno';

  @override
  String get menuMinimize => 'Minimiraj';

  @override
  String get menuZoom => 'Povečaj';

  @override
  String get menuBringAllToFront => 'Prinesi vse v ospredje';

  @override
  String get settingsTitle => 'Nastavitve';

  @override
  String get settingsLanguage => 'Jezik';

  @override
  String get settingsLanguageSystem => 'Sistemska privzeta';

  @override
  String get settingsUnits => 'Enote';

  @override
  String get settingsUnitsCentimeters => 'Centimetri';

  @override
  String get settingsUnitsInches => 'Palci';

  @override
  String get settingsSearchLanguages => 'Iskanje jezikov...';

  @override
  String get settingsGeneral => 'Splošno';

  @override
  String get addImage => 'Dodaj sliko';

  @override
  String get selectImages => 'Izberi slike';

  @override
  String get zoomFitWidth => 'Prilagodi širini';

  @override
  String get zoomIn => 'Povečaj';

  @override
  String get zoomOut => 'Pomanjšaj';

  @override
  String get selectZoomLevel => 'Izberi stopnjo povečave';

  @override
  String get goToPage => 'Pojdi na stran';

  @override
  String get go => 'Pojdi';

  @override
  String get savePdfAs => 'Shrani PDF kot';

  @override
  String get incorrectPassword => 'Napačno geslo';

  @override
  String get saveFailed => 'Shranjevanje ni uspelo';

  @override
  String savedTo(String path) {
    return 'Shranjeno v: $path';
  }

  @override
  String get noOriginalPdfStored => 'Izvirni PDF ni shranjen';

  @override
  String get waitingForFolderPermission =>
      'Čakanje na dovoljenje za dostop do mape...';

  @override
  String get emptyRecentFiles => 'Odprite PDF za začetek';
}
