// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Esperanto (`eo`).
class AppLocalizationsEo extends AppLocalizations {
  AppLocalizationsEo([String locale = 'eo']) : super(locale);

  @override
  String get openPdf => 'Malfermi PDF';

  @override
  String get selectPdf => 'Malfermi dosieron';

  @override
  String get untitledDocument => 'Sentitola.pdf';

  @override
  String get recentFiles => 'Lastaj dosieroj';

  @override
  String get removeFromList => 'Forigi el listo';

  @override
  String get openedNow => 'Jxus malfermita';

  @override
  String openedMinutesAgo(int count) {
    return 'Malfermita antaux $count minutoj';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Malfermita antaux $count horoj';
  }

  @override
  String get openedYesterday => 'Malfermita hieraux';

  @override
  String openedDaysAgo(int count) {
    return 'Malfermita antaux $count tagoj';
  }

  @override
  String get fileNotFound => 'Dosiero ne trovita';

  @override
  String get fileAccessDenied => 'Aliro rifuzita';

  @override
  String get clearRecentFiles => 'Forviŝi lastajn dosierojn';

  @override
  String get cancel => 'Nuligi';

  @override
  String get confirm => 'Konfirmi';

  @override
  String get error => 'Eraro';

  @override
  String get ok => 'Bone';

  @override
  String get menuFile => 'Dosiero';

  @override
  String get menuOpen => 'Malfermi...';

  @override
  String get menuOpenRecent => 'Malfermi lastajn';

  @override
  String get menuNoRecentFiles => 'Neniuj lastaj dosieroj';

  @override
  String get menuClearMenu => 'Forviŝi menuon';

  @override
  String get menuSave => 'Konservi';

  @override
  String get menuSaveAs => 'Konservi kiel...';

  @override
  String get menuSaveAll => 'Konservi ĉiujn';

  @override
  String get menuShare => 'Kunhavigi...';

  @override
  String get menuCloseWindow => 'Fermi fenestron';

  @override
  String get menuCloseAll => 'Fermi ĉiujn';

  @override
  String get menuQuit => 'Eliri PDFSign';

  @override
  String get closeAllDialogTitle => 'Konservi ŝanĝojn?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Ĉu vi volas konservi ŝanĝojn en $count dokumentoj antaŭ fermi?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Ĉu vi volas konservi ŝanĝojn en 1 dokumento antaŭ fermi?';

  @override
  String get closeAllDialogSaveAll => 'Konservi ĉiujn';

  @override
  String get closeAllDialogDontSave => 'Ne konservi';

  @override
  String get closeAllDialogCancel => 'Nuligi';

  @override
  String get saveFailedDialogTitle => 'Konservo malsukcesis';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Malsukcesis konservi $count dokumenton(jn). Ĉu fermi tamen?';
  }

  @override
  String get saveFailedDialogClose => 'Fermi tamen';

  @override
  String get saveChangesTitle => 'Konservi sxangxojn?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Cxu vi volas konservi sxangxojn en \"$fileName\" antaux fermi?';
  }

  @override
  String get saveButton => 'Konservi';

  @override
  String get discardButton => 'Ne konservi';

  @override
  String get documentEdited => 'Redaktita';

  @override
  String get documentSaved => 'Konservita';

  @override
  String get menuSettings => 'Agordoj...';

  @override
  String get menuWindow => 'Fenestro';

  @override
  String get menuMinimize => 'Minimumigi';

  @override
  String get menuZoom => 'Zomi';

  @override
  String get menuBringAllToFront => 'Ĉiujn antaŭen';

  @override
  String get settingsTitle => 'Agordoj';

  @override
  String get settingsLanguage => 'Lingvo';

  @override
  String get settingsLanguageSystem => 'Sistema defauxlto';

  @override
  String get settingsUnits => 'Unuoj';

  @override
  String get settingsUnitsCentimeters => 'Centimetroj';

  @override
  String get settingsUnitsInches => 'Coloj';

  @override
  String get settingsUnitsDefault => 'Defaŭlta (laŭ regiono)';

  @override
  String get settingsSearchLanguages => 'Serĉi lingvojn...';

  @override
  String get settingsGeneral => 'Ĝenerale';

  @override
  String get addImage => 'Aldoni bildon';

  @override
  String get selectImages => 'Elekti bildojn';

  @override
  String get zoomFitWidth => 'Adapti larĝon';

  @override
  String get zoomIn => 'Pligrandigi';

  @override
  String get zoomOut => 'Malpligrandigi';

  @override
  String get selectZoomLevel => 'Elekti zoomnivelon';

  @override
  String get goToPage => 'Iri al paĝo';

  @override
  String get go => 'Iri';

  @override
  String get savePdfAs => 'Konservi PDF kiel';

  @override
  String get incorrectPassword => 'Malĝusta pasvorto';

  @override
  String get saveFailed => 'Konservado fiaskis';

  @override
  String savedTo(String path) {
    return 'Konservita al: $path';
  }

  @override
  String get noOriginalPdfStored => 'Neniu originala PDF konservita';

  @override
  String get waitingForFolderPermission =>
      'Atendante dosierujan alirpermeson...';

  @override
  String get emptyRecentFiles => 'Malfermu dosieron por komenci';

  @override
  String get imagesTitle => 'Bildoj';

  @override
  String get noImagesYet => 'Ankoraŭ neniuj bildoj';

  @override
  String get noImagesHint =>
      'Alklaku + por aldoni vian unuan stampilon aŭ subskribon';

  @override
  String get done => 'Finita';

  @override
  String get menuEdit => 'Redakti';

  @override
  String get chooseFromFiles => 'Elekti el dosieroj';

  @override
  String get chooseFromGallery => 'Elekti el galerio';

  @override
  String get imageTooBig => 'Bildo estas tro granda (maks. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Distingivo estas tro alta (maks. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Nesubtenata bildformato';

  @override
  String get deleteTooltip => 'Forigi';

  @override
  String get shareTooltip => 'Kunhavigi';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Paĝo $currentPage el $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Neniu dokumento ŝargita';

  @override
  String get failedToLoadPdf => 'Malsukcesis ŝargi PDF';

  @override
  String get passwordRequired => 'Pasvorto bezonata';

  @override
  String get pdfPasswordProtected =>
      'Ĉi tiu PDF estas protektita per pasvorto.';

  @override
  String errorWithMessage(String message) {
    return 'Eraro: $message';
  }

  @override
  String get unsavedChangesTitle => 'Nekonservitaj ŝanĝoj';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Ĉu vi volas konservi ŝanĝojn en \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Alklaku por malfermi PDF-dokumenton';

  @override
  String get onboardingSwipeUp =>
      'Glitu supren por aldoni subskribojn kaj stampilojn';

  @override
  String get onboardingAddImage =>
      'Alklaku por aldoni vian unuan subskribon aŭ stampilon';

  @override
  String get onboardingDragImage => 'Trenu sur la PDF por meti ĝin';

  @override
  String get onboardingResizeObject =>
      'Alklaku por elekti. Trenu angulojn por ŝanĝi grandecon.';

  @override
  String get onboardingDeleteImage => 'Alklaku por forigi la elektitan bildon';

  @override
  String get onboardingTapToContinue => 'Alklaku ie ajn por daŭrigi';

  @override
  String get imageConversionFailed => 'Malsukcesis konverti bildon al PDF';

  @override
  String get saveDocumentTitle => 'Konservi dokumenton';

  @override
  String get fileNameLabel => 'Dosiernomo';

  @override
  String get defaultFileName => 'Dokumento';

  @override
  String get onlyOnePdfAllowed => 'Nur unu PDF povas esti malfermita samtempe';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF-dosieroj estis ignoritaj. Nur bildoj estas konvertitaj.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'bildojn',
      one: 'bildon',
    );
    return 'Konvertante $count $_temp0...';
  }

  @override
  String get takePhoto => 'Preni foton';

  @override
  String get removeBackgroundTitle => 'Forigi fonon?';

  @override
  String get removeBackgroundMessage =>
      'Ĉu vi volas forigi la fonon kaj igi ĝin travidebla?';

  @override
  String get removeBackground => 'Forigi';

  @override
  String get keepOriginal => 'Konservi';

  @override
  String get processingImage => 'Prilaborante bildon...';

  @override
  String get backgroundRemovalFailed => 'Malsukcesis forigi fonon';

  @override
  String get passwordLabel => 'Pasvorto';

  @override
  String get unlockButton => 'Malŝlosi';
}
