// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Armenian (`hy`).
class AppLocalizationsHy extends AppLocalizations {
  AppLocalizationsHy([String locale = 'hy']) : super(locale);

  @override
  String get openPdf => 'Batsvel PDF';

  @override
  String get selectPdf => 'Yntrel PDF';

  @override
  String get recentFiles => 'Verdjin faylery';

  @override
  String get removeFromList => 'Heratsel tsankits';

  @override
  String get openedNow => 'Nor batsvetso';

  @override
  String openedMinutesAgo(int count) {
    return 'Batsvetso $count rope araj';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Batsvetso $count zham araj';
  }

  @override
  String get openedYesterday => 'Batsvetso yerek';

  @override
  String openedDaysAgo(int count) {
    return 'Batsvetso $count or araj';
  }

  @override
  String get fileNotFound => 'Fayli chi gtanyel';

  @override
  String get fileAccessDenied => 'Mtky merjvatso e';

  @override
  String get clearRecentFiles => 'Maqrel verdjin faylery';

  @override
  String get cancel => 'Chygarkvel';

  @override
  String get confirm => 'Hastatel';

  @override
  String get error => 'Skhalk';

  @override
  String get ok => 'Lav';

  @override
  String get menuFile => 'Fayl';

  @override
  String get menuOpen => 'Batsvel...';

  @override
  String get menuOpenRecent => 'Batsvel verdjiny';

  @override
  String get menuNoRecentFiles => 'Verdjin faylyr chkan';

  @override
  String get menuClearMenu => 'Maqrel tsanky';

  @override
  String get menuSave => 'Pakhpanel';

  @override
  String get menuSaveAs => 'Pakhpanel orpes...';

  @override
  String get menuSaveAll => 'Save All';

  @override
  String get menuShare => 'Kisel...';

  @override
  String get menuCloseWindow => 'Pakers patuhan';

  @override
  String get menuCloseAll => 'Pakers bolory';

  @override
  String get menuQuit => 'Yelk PDFSign-its';

  @override
  String get closeAllDialogTitle => 'Pakhpanel pokhutyyunnery?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Uzum eq pakhpanel pokhutyyunnery $count pastatghterum pokheluts araj?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Uzum eq pakhpanel pokhutyyunnery 1 pastatghterum pokheluts araj?';

  @override
  String get closeAllDialogSaveAll => 'Pakhpanel bolory';

  @override
  String get closeAllDialogDontSave => 'Chpakhpanel';

  @override
  String get closeAllDialogCancel => 'Chygarkvel';

  @override
  String get saveFailedDialogTitle => 'Save Failed';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Failed to save $count document(s). Close anyway?';
  }

  @override
  String get saveFailedDialogClose => 'Close Anyway';

  @override
  String get saveChangesTitle => 'Pakhpanel pokhutyyunnery?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Uzum eq pakhpanel \"$fileName\" faylum katrvatso pokhutyyunnery pokhelu araj?';
  }

  @override
  String get saveButton => 'Pakhpanel';

  @override
  String get discardButton => 'Chpakhpanel';

  @override
  String get documentEdited => 'Khmbagrets';

  @override
  String get documentSaved => 'Pakhpanvatso e';

  @override
  String get menuSettings => 'Kargavorumner...';

  @override
  String get menuWindow => 'Patuhan';

  @override
  String get menuMinimize => 'Pokratsnel';

  @override
  String get menuZoom => 'Masshtab';

  @override
  String get menuBringAllToFront => 'Bolory araj berel';

  @override
  String get settingsTitle => 'Kargavorumner';

  @override
  String get settingsLanguage => 'Lezu';

  @override
  String get settingsLanguageSystem => 'Hamakargayin lrutso';

  @override
  String get settingsUnits => 'Chapaqi miavorner';

  @override
  String get settingsUnitsCentimeters => 'Santimetrer';

  @override
  String get settingsUnitsInches => 'Duymer';

  @override
  String get settingsSearchLanguages => 'Lezuneri porokhum...';

  @override
  String get settingsGeneral => 'Yndhanur';

  @override
  String get addImage => 'Avelatsnel patker';

  @override
  String get selectImages => 'Yntrel patkerner';

  @override
  String get zoomFitWidth => 'Hamarjetsnel laynutyamb';

  @override
  String get zoomIn => 'Metatsnel';

  @override
  String get zoomOut => 'Pokratsnel';

  @override
  String get selectZoomLevel => 'Yntrel masshtabi makardaky';

  @override
  String get goToPage => 'Anjnel ej';

  @override
  String get go => 'Anjnel';

  @override
  String get savePdfAs => 'Pakhpanel PDF orpes';

  @override
  String get incorrectPassword => 'Sphal gaghtnabar';

  @override
  String get saveFailed => 'Pakhpanman skhalkutyun';

  @override
  String savedTo(String path) {
    return 'Pakhpanvatso e: $path';
  }

  @override
  String get noOriginalPdfStored => 'Bnatipi PDF-y pakhpanvatso che';

  @override
  String get waitingForFolderPermission =>
      'Waiting for folder access permission...';
}
