// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String get openPdf => 'Buksan ang PDF';

  @override
  String get selectPdf => 'Pumili ng PDF';

  @override
  String get recentFiles => 'Kamakailang mga file';

  @override
  String get removeFromList => 'Alisin sa listahan';

  @override
  String get openedNow => 'Kabukas lang';

  @override
  String openedMinutesAgo(int count) {
    return 'Binuksan $count minuto na ang nakalipas';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Binuksan $count oras na ang nakalipas';
  }

  @override
  String get openedYesterday => 'Binuksan kahapon';

  @override
  String openedDaysAgo(int count) {
    return 'Binuksan $count araw na ang nakalipas';
  }

  @override
  String get fileNotFound => 'Hindi nahanap ang file';

  @override
  String get fileAccessDenied => 'Tinanggihan ang access';

  @override
  String get clearRecentFiles => 'I-clear ang mga kamakailang file';

  @override
  String get cancel => 'Kanselahin';

  @override
  String get confirm => 'Kumpirmahin';

  @override
  String get error => 'Error';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Buksan...';

  @override
  String get menuOpenRecent => 'Buksan ang Kamakailang';

  @override
  String get menuNoRecentFiles => 'Walang kamakailang mga file';

  @override
  String get menuClearMenu => 'I-clear ang Menu';

  @override
  String get menuSave => 'I-save';

  @override
  String get menuSaveAs => 'I-save Bilang...';

  @override
  String get menuSaveAll => 'I-save Lahat';

  @override
  String get menuShare => 'Ibahagi...';

  @override
  String get menuCloseWindow => 'Isara ang Window';

  @override
  String get menuCloseAll => 'Isara lahat';

  @override
  String get menuQuit => 'Lumabas sa PDFSign';

  @override
  String get closeAllDialogTitle => 'I-save ang mga pagbabago?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Gusto mo bang i-save ang mga pagbabago sa $count dokumento bago isara?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Gusto mo bang i-save ang mga pagbabago sa 1 dokumento bago isara?';

  @override
  String get closeAllDialogSaveAll => 'I-save lahat';

  @override
  String get closeAllDialogDontSave => 'Huwag i-save';

  @override
  String get closeAllDialogCancel => 'Kanselahin';

  @override
  String get saveFailedDialogTitle => 'Nabigo ang Pag-save';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Nabigong i-save ang $count dokumento. Isara pa rin?';
  }

  @override
  String get saveFailedDialogClose => 'Isara Pa Rin';

  @override
  String get saveChangesTitle => 'I-save ang mga pagbabago?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Gusto mo bang i-save ang mga pagbabago sa \"$fileName\" bago isara?';
  }

  @override
  String get saveButton => 'I-save';

  @override
  String get discardButton => 'Huwag i-save';

  @override
  String get documentEdited => 'Na-edit';

  @override
  String get documentSaved => 'Na-save';

  @override
  String get menuSettings => 'Mga Setting...';

  @override
  String get menuWindow => 'Window';

  @override
  String get menuMinimize => 'I-minimize';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Dalhin Lahat sa Harap';

  @override
  String get settingsTitle => 'Mga Setting';

  @override
  String get settingsLanguage => 'Wika';

  @override
  String get settingsLanguageSystem => 'Default ng System';

  @override
  String get settingsUnits => 'Mga Unit';

  @override
  String get settingsUnitsCentimeters => 'Sentimetro';

  @override
  String get settingsUnitsInches => 'Pulgada';

  @override
  String get settingsSearchLanguages => 'Maghanap ng wika...';

  @override
  String get settingsGeneral => 'Pangkalahatan';

  @override
  String get addImage => 'Magdagdag ng larawan';

  @override
  String get selectImages => 'Pumili ng mga larawan';

  @override
  String get zoomFitWidth => 'Iayon sa lapad';

  @override
  String get zoomIn => 'Palakihin';

  @override
  String get zoomOut => 'Paliitin';

  @override
  String get selectZoomLevel => 'Pumili ng antas ng zoom';

  @override
  String get goToPage => 'Pumunta sa pahina';

  @override
  String get go => 'Pumunta';

  @override
  String get savePdfAs => 'I-save ang PDF bilang';

  @override
  String get incorrectPassword => 'Maling password';

  @override
  String get saveFailed => 'Hindi ma-save';

  @override
  String savedTo(String path) {
    return 'Na-save sa: $path';
  }

  @override
  String get noOriginalPdfStored => 'Walang nakaimbak na orihinal na PDF';

  @override
  String get waitingForFolderPermission =>
      'Naghihintay ng pahintulot sa pag-access sa folder...';

  @override
  String get emptyRecentFiles => 'Magbukas ng PDF para makapagsimula';
}
