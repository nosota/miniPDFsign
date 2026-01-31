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
  String get selectPdf => 'Batsvel fayl';

  @override
  String get untitledDocument => 'Anvanats.pdf';

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
  String get fileNotFound => 'Fayly chi gtanyel';

  @override
  String get fileAccessDenied => 'Mtky merjvatso e';

  @override
  String get clearRecentFiles => 'Maqrel verdjin faylery';

  @override
  String get cancel => 'Chegarkvel';

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
  String get menuSaveAll => 'Pakhpanel bolory';

  @override
  String get menuShare => 'Kisel...';

  @override
  String get menuCloseWindow => 'Pakeres patuhany';

  @override
  String get menuCloseAll => 'Pakeres bolory';

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
  String get closeAllDialogCancel => 'Chegarkvel';

  @override
  String get saveFailedDialogTitle => 'Pakhpanman skhalk';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Chi karatsvel pakhpanel $count pastatught. Ays depm pakhe?';
  }

  @override
  String get saveFailedDialogClose => 'Ays depm pakel';

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
  String get documentEdited => 'Khmbagrvats';

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
  String get zoomFitWidth => 'Hamarjetsnel laynkutyan';

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
      'Spassum enk tghpaki hnaravorutyun...';

  @override
  String get emptyRecentFiles => 'Batsek fayl skselou hamar';

  @override
  String get imagesTitle => 'Patkerner';

  @override
  String get noImagesYet => 'Patkerner derevs chkan';

  @override
  String get noImagesHint =>
      'Hpek + dzier aradzhin kniqi kam storagrutyan hamar';

  @override
  String get done => 'Patrastats e';

  @override
  String get menuEdit => 'Khmbagrel';

  @override
  String get chooseFromFiles => 'Yntrel faylneratits';

  @override
  String get chooseFromGallery => 'Yntrel patkerasrahits';

  @override
  String get imageTooBig => 'Patkery chap\'azants mets e (aravelsaguyns 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Lucakchutyuny chap\'azants bards e (aravelsaguyns 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Chajaktsvats patkeri dzevachap';

  @override
  String get deleteTooltip => 'Jnjel';

  @override
  String get shareTooltip => 'Kisel';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Ej $currentPage / $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Pastatught bervats che';

  @override
  String get failedToLoadPdf => 'PDF-y bernel hnaravor che';

  @override
  String get passwordRequired => 'Gaghtnabar pahanjvum e';

  @override
  String get pdfPasswordProtected => 'Ays PDF-y gaghtnabarov pashpanvats e.';

  @override
  String errorWithMessage(String message) {
    return 'Skhalk: $message';
  }

  @override
  String get unsavedChangesTitle => 'Chpakhpanvats pokhutyyunner';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Uzum eq pakhpanel pokhutyyunnery \"$fileName\"-um?';
  }

  @override
  String get onboardingOpenPdf => 'Hpek PDF pastatught batselou hamar';

  @override
  String get onboardingSwipeUp =>
      'Sahetsek verev storagrutyunner yev kniqner avelatsneluhamar';

  @override
  String get onboardingAddImage =>
      'Hpek dzier aradzhin storagrutyn kam kniqn avelatsneluhamar';

  @override
  String get onboardingDragImage => 'Kshek PDF-i vra teghavorelou hamar';

  @override
  String get onboardingResizeObject =>
      'Hpek entrelou hamar. Kshek ankyunnery chapser pokhelu hamar.';

  @override
  String get onboardingDeleteImage => 'Hpek entrvatso patkery jnjelou hamar';

  @override
  String get onboardingTapToContinue => 'Hpek vorteghe sharounakelu hamar';

  @override
  String get imageConversionFailed => 'Patkery PDF dardzel hnaravor che';

  @override
  String get saveDocumentTitle => 'Pakhpanel pastatughty';

  @override
  String get fileNameLabel => 'Fayli anun';

  @override
  String get defaultFileName => 'Pastatught';
}
