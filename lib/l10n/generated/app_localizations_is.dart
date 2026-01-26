// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Icelandic (`is`).
class AppLocalizationsIs extends AppLocalizations {
  AppLocalizationsIs([String locale = 'is']) : super(locale);

  @override
  String get openPdf => 'Opna PDF';

  @override
  String get selectPdf => 'Velja PDF';

  @override
  String get recentFiles => 'Nyjar skrar';

  @override
  String get removeFromList => 'Fjarlægja af lista';

  @override
  String get openedNow => 'Nyopnað';

  @override
  String openedMinutesAgo(int count) {
    return 'Opnað fyrir $count min';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Opnað fyrir $count klst';
  }

  @override
  String get openedYesterday => 'Opnað i gær';

  @override
  String openedDaysAgo(int count) {
    return 'Opnað fyrir $count dogum';
  }

  @override
  String get fileNotFound => 'Skra fannst ekki';

  @override
  String get fileAccessDenied => 'Adgangur synjadur';

  @override
  String get clearRecentFiles => 'Hreinsa nyjar skrar';

  @override
  String get cancel => 'Hætta vid';

  @override
  String get confirm => 'Stadsfesta';

  @override
  String get error => 'Villa';

  @override
  String get ok => 'I lagi';

  @override
  String get menuFile => 'Skra';

  @override
  String get menuOpen => 'Opna...';

  @override
  String get menuOpenRecent => 'Opna nyjar';

  @override
  String get menuNoRecentFiles => 'Engar nyjar skrar';

  @override
  String get menuClearMenu => 'Hreinsa valmynd';

  @override
  String get menuSave => 'Vista';

  @override
  String get menuSaveAs => 'Vista sem...';

  @override
  String get menuSaveAll => 'Vista allt';

  @override
  String get menuShare => 'Deila...';

  @override
  String get menuCloseWindow => 'Loka glugga';

  @override
  String get menuCloseAll => 'Loka öllu';

  @override
  String get menuQuit => 'Hætta í PDFSign';

  @override
  String get closeAllDialogTitle => 'Vista breytingar?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Viltu vista breytingar í $count skjölum áður en lokað er?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Viltu vista breytingar í 1 skjali áður en lokað er?';

  @override
  String get closeAllDialogSaveAll => 'Vista allt';

  @override
  String get closeAllDialogDontSave => 'Ekki vista';

  @override
  String get closeAllDialogCancel => 'Hætta við';

  @override
  String get saveFailedDialogTitle => 'Vista mistókst';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Mistókst að vista $count skjal. Loka samt?';
  }

  @override
  String get saveFailedDialogClose => 'Loka samt';

  @override
  String get saveChangesTitle => 'Vista breytingar?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Viltu vista breytingar a \"$fileName\" adur en lokad er?';
  }

  @override
  String get saveButton => 'Vista';

  @override
  String get discardButton => 'Fleygja';

  @override
  String get documentEdited => 'Breytt';

  @override
  String get documentSaved => 'Vistað';

  @override
  String get menuSettings => 'Stillingar...';

  @override
  String get menuWindow => 'Gluggi';

  @override
  String get menuMinimize => 'Lágmarka';

  @override
  String get menuZoom => 'Stækka';

  @override
  String get menuBringAllToFront => 'Færa allt fremst';

  @override
  String get settingsTitle => 'Stillingar';

  @override
  String get settingsLanguage => 'Tungumál';

  @override
  String get settingsLanguageSystem => 'Sjálfgildi kerfis';

  @override
  String get settingsUnits => 'Einingar';

  @override
  String get settingsUnitsCentimeters => 'Sentimetrar';

  @override
  String get settingsUnitsInches => 'Tommur';

  @override
  String get settingsSearchLanguages => 'Leita að tungumálum...';

  @override
  String get settingsGeneral => 'Almennt';

  @override
  String get addImage => 'Bæta við mynd';

  @override
  String get selectImages => 'Velja myndir';

  @override
  String get zoomFitWidth => 'Passa við breidd';

  @override
  String get zoomIn => 'Stækka';

  @override
  String get zoomOut => 'Minnka';

  @override
  String get selectZoomLevel => 'Velja stækkunarstig';

  @override
  String get goToPage => 'Fara á síðu';

  @override
  String get go => 'Fara';

  @override
  String get savePdfAs => 'Vista PDF sem';

  @override
  String get incorrectPassword => 'Rangt lykilorð';

  @override
  String get saveFailed => 'Vistun mistókst';

  @override
  String savedTo(String path) {
    return 'Vistað í: $path';
  }

  @override
  String get noOriginalPdfStored => 'Ekkert upprunalegt PDF vistað';

  @override
  String get waitingForFolderPermission =>
      'Bíð eftir aðgangsheimild fyrir möppu...';

  @override
  String get emptyRecentFiles => 'Opnaðu PDF til að byrja';

  @override
  String get imagesTitle => 'Myndir';

  @override
  String get noImagesYet => 'Engar myndir ennþá';

  @override
  String get noImagesHint =>
      'Ýttu á + til að bæta við fyrsta stimpli eða undirskrift';

  @override
  String get done => 'Lokið';

  @override
  String get menuEdit => 'Breyta';
}
