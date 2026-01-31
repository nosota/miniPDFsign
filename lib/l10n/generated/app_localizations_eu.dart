// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Basque (`eu`).
class AppLocalizationsEu extends AppLocalizations {
  AppLocalizationsEu([String locale = 'eu']) : super(locale);

  @override
  String get openPdf => 'Ireki PDF';

  @override
  String get selectPdf => 'Ireki fitxategia';

  @override
  String get untitledDocument => 'Izengabea.pdf';

  @override
  String get recentFiles => 'Azken fitxategiak';

  @override
  String get removeFromList => 'Kendu zerrendatik';

  @override
  String get openedNow => 'Orain irekita';

  @override
  String openedMinutesAgo(int count) {
    return 'Duela $count minutu irekita';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Duela $count ordu irekita';
  }

  @override
  String get openedYesterday => 'Atzo irekita';

  @override
  String openedDaysAgo(int count) {
    return 'Duela $count egun irekita';
  }

  @override
  String get fileNotFound => 'Ez da fitxategia aurkitu';

  @override
  String get fileAccessDenied => 'Sarbidea ukatua';

  @override
  String get clearRecentFiles => 'Garbitu azken fitxategiak';

  @override
  String get cancel => 'Utzi';

  @override
  String get confirm => 'Berretsi';

  @override
  String get error => 'Errorea';

  @override
  String get ok => 'Ados';

  @override
  String get menuFile => 'Fitxategia';

  @override
  String get menuOpen => 'Ireki...';

  @override
  String get menuOpenRecent => 'Ireki azkenak';

  @override
  String get menuNoRecentFiles => 'Ez dago azken fitxategirik';

  @override
  String get menuClearMenu => 'Garbitu menua';

  @override
  String get menuSave => 'Gorde';

  @override
  String get menuSaveAs => 'Gorde honela...';

  @override
  String get menuSaveAll => 'Gorde dena';

  @override
  String get menuShare => 'Partekatu...';

  @override
  String get menuCloseWindow => 'Itxi leihoa';

  @override
  String get menuCloseAll => 'Itxi dena';

  @override
  String get menuQuit => 'Irten PDFSign-etik';

  @override
  String get closeAllDialogTitle => 'Aldaketak gorde?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Itxi baino lehen $count dokumentuetako aldaketak gorde nahi dituzu?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Itxi baino lehen dokumentu bateko aldaketak gorde nahi dituzu?';

  @override
  String get closeAllDialogSaveAll => 'Gorde dena';

  @override
  String get closeAllDialogDontSave => 'Ez gorde';

  @override
  String get closeAllDialogCancel => 'Utzi';

  @override
  String get saveFailedDialogTitle => 'Gordetzeak huts egin du';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Ezin izan dira $count dokumentu gorde. Itxi hala ere?';
  }

  @override
  String get saveFailedDialogClose => 'Itxi hala ere';

  @override
  String get saveChangesTitle => 'Aldaketak gorde?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Itxi baino lehen \"$fileName\" fitxategiko aldaketak gorde nahi dituzu?';
  }

  @override
  String get saveButton => 'Gorde';

  @override
  String get discardButton => 'Ez gorde';

  @override
  String get documentEdited => 'Editatua';

  @override
  String get documentSaved => 'Gordeta';

  @override
  String get menuSettings => 'Ezarpenak...';

  @override
  String get menuWindow => 'Leihoa';

  @override
  String get menuMinimize => 'Minimizatu';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Ekarri dena aurrera';

  @override
  String get settingsTitle => 'Ezarpenak';

  @override
  String get settingsLanguage => 'Hizkuntza';

  @override
  String get settingsLanguageSystem => 'Sistemaren lehenetsia';

  @override
  String get settingsUnits => 'Unitateak';

  @override
  String get settingsUnitsCentimeters => 'Zentimetroak';

  @override
  String get settingsUnitsInches => 'Hazbeteak';

  @override
  String get settingsSearchLanguages => 'Bilatu hizkuntzak...';

  @override
  String get settingsGeneral => 'Orokorra';

  @override
  String get addImage => 'Gehitu irudia';

  @override
  String get selectImages => 'Hautatu irudiak';

  @override
  String get zoomFitWidth => 'Egokitu zabaleran';

  @override
  String get zoomIn => 'Handitu';

  @override
  String get zoomOut => 'Txikitu';

  @override
  String get selectZoomLevel => 'Hautatu zoom maila';

  @override
  String get goToPage => 'Joan orrialdera';

  @override
  String get go => 'Joan';

  @override
  String get savePdfAs => 'Gorde PDF honela';

  @override
  String get incorrectPassword => 'Pasahitz okerra';

  @override
  String get saveFailed => 'Gordetzeak huts egin du';

  @override
  String savedTo(String path) {
    return 'Gordeta: $path';
  }

  @override
  String get noOriginalPdfStored => 'Ez dago jatorrizko PDF-ik gordetuta';

  @override
  String get waitingForFolderPermission =>
      'Karpeta sarbide baimena itxaroten...';

  @override
  String get emptyRecentFiles => 'Ireki fitxategi bat hasteko';

  @override
  String get imagesTitle => 'Irudiak';

  @override
  String get noImagesYet => 'Oraindik ez dago irudirik';

  @override
  String get noImagesHint =>
      'Sakatu + zure lehen zigilua edo sinadura gehitzeko';

  @override
  String get done => 'Egina';

  @override
  String get menuEdit => 'Editatu';

  @override
  String get chooseFromFiles => 'Aukeratu fitxategietatik';

  @override
  String get chooseFromGallery => 'Aukeratu galeriatik';

  @override
  String get imageTooBig => 'Irudia handiegia da (gehienez 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Bereizmena altuegia da (gehienez 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Irudi-formatu ez onartua';

  @override
  String get deleteTooltip => 'Ezabatu';

  @override
  String get shareTooltip => 'Partekatu';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return '$currentPage. orrialdea $totalPages(e)tik';
  }

  @override
  String get noDocumentLoaded => 'Ez da dokumenturik kargatu';

  @override
  String get failedToLoadPdf => 'Ezin izan da PDFa kargatu';

  @override
  String get passwordRequired => 'Pasahitza beharrezkoa';

  @override
  String get pdfPasswordProtected => 'PDF hau pasahitzaz babestuta dago.';

  @override
  String errorWithMessage(String message) {
    return 'Errorea: $message';
  }

  @override
  String get unsavedChangesTitle => 'Gorde gabeko aldaketak';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Aldaketak gorde nahi dituzu \"$fileName\" fitxategian?';
  }

  @override
  String get onboardingOpenPdf => 'Sakatu PDF dokumentu bat irekitzeko';

  @override
  String get onboardingSwipeUp =>
      'Irristatu gora sinadurak eta zigiluak gehitzeko';

  @override
  String get onboardingAddImage =>
      'Sakatu zure lehen sinadura edo zigilua gehitzeko';

  @override
  String get onboardingDragImage => 'Arrastatu PDFra kokatzeko';

  @override
  String get onboardingResizeObject =>
      'Sakatu hautatzeko. Arrastatu ertzak tamaina aldatzeko.';

  @override
  String get onboardingDeleteImage => 'Tap to delete the selected image';

  @override
  String get onboardingTapToContinue => 'Sakatu edonon jarraitzeko';

  @override
  String get imageConversionFailed => 'Ezin izan da irudia PDF bihurtu';
}
