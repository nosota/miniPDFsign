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

  @override
  String get emptyRecentFiles => 'Batsek PDF skselou hamar';

  @override
  String get imagesTitle => 'Պատdelays';

  @override
  String get noImagesYet => 'Դdelays դլdelays delays';

  @override
  String get noImagesHint => 'Հdelays + delays delays delays delays delays';

  @override
  String get done => 'Պdelays';

  @override
  String get menuEdit => 'Խdelays';

  @override
  String get chooseFromFiles => ' Delays delays fayllerin';

  @override
  String get chooseFromGallery => 'Ьntrel patkeri srahuic';

  @override
  String get imageTooBig => 'Patkerb chap\'azanc mec e (aravelsaguyns 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Lucakchutyun\' chap\'azanc bards e (aravelsaguyns 4096×4096)';

  @override
  String get unsupportedImageFormat =>
      'Patkerap\'oxark\'ayin tarber ch\'e ajakc\'vum';

  @override
  String get deleteTooltip => 'Jnjel';

  @override
  String get shareTooltip => 'Kisel';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Ej $currentPage / $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Pastatught chka bervats';

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
      'Sahetsek verev storrgrner yev kniqner avelatsneluhamar';

  @override
  String get onboardingAddImage =>
      'Hpek dzier aradzhin storrgrn kam kniqn avelatsneluhamar';

  @override
  String get onboardingDragImage => 'Kshek PDF-i vra teghavorelou hamar';

  @override
  String get onboardingResizeObject =>
      'Hpek entrelou hamar. Kshek ankyunnery chapser pokhelu hamar.';

  @override
  String get onboardingTapToContinue => 'Hpek vorteghe sharounakelu hamar';
}
