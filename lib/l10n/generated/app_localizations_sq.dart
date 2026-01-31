// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Albanian (`sq`).
class AppLocalizationsSq extends AppLocalizations {
  AppLocalizationsSq([String locale = 'sq']) : super(locale);

  @override
  String get openPdf => 'Hap PDF';

  @override
  String get selectPdf => 'Hap skedar';

  @override
  String get untitledDocument => 'Pa titull.pdf';

  @override
  String get recentFiles => 'Skedaret e fundit';

  @override
  String get removeFromList => 'Hiq nga lista';

  @override
  String get openedNow => 'Sapo u hap';

  @override
  String openedMinutesAgo(int count) {
    return 'U hap $count minuta me pare';
  }

  @override
  String openedHoursAgo(int count) {
    return 'U hap $count ore me pare';
  }

  @override
  String get openedYesterday => 'U hap dje';

  @override
  String openedDaysAgo(int count) {
    return 'U hap $count dite me pare';
  }

  @override
  String get fileNotFound => 'Skedari nuk u gjet';

  @override
  String get fileAccessDenied => 'Qasja e refuzuar';

  @override
  String get clearRecentFiles => 'Pastro skedaret e fundit';

  @override
  String get cancel => 'Anullo';

  @override
  String get confirm => 'Konfirmo';

  @override
  String get error => 'Gabim';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Skedar';

  @override
  String get menuOpen => 'Hap...';

  @override
  String get menuOpenRecent => 'Hap te fundit';

  @override
  String get menuNoRecentFiles => 'Nuk ka skedare te fundit';

  @override
  String get menuClearMenu => 'Pastro menune';

  @override
  String get menuSave => 'Ruaj';

  @override
  String get menuSaveAs => 'Ruaj si...';

  @override
  String get menuSaveAll => 'Ruaj të gjitha';

  @override
  String get menuShare => 'Ndaj...';

  @override
  String get menuCloseWindow => 'Mbyll dritaren';

  @override
  String get menuCloseAll => 'Mbyll të gjitha';

  @override
  String get menuQuit => 'Dil nga PDFSign';

  @override
  String get closeAllDialogTitle => 'Ruaj ndryshimet?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Dëshironi të ruani ndryshimet në $count dokumente para se të mbyllni?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Dëshironi të ruani ndryshimet në 1 dokument para se të mbyllni?';

  @override
  String get closeAllDialogSaveAll => 'Ruaj të gjitha';

  @override
  String get closeAllDialogDontSave => 'Mos ruaj';

  @override
  String get closeAllDialogCancel => 'Anulo';

  @override
  String get saveFailedDialogTitle => 'Ruajtja dështoi';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Dështoi ruajtja e $count dokumenteve. Mbyll gjithsesi?';
  }

  @override
  String get saveFailedDialogClose => 'Mbyll Gjithsesi';

  @override
  String get saveChangesTitle => 'Ruaj ndryshimet?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Deshironi te ruani ndryshimet ne \"$fileName\" para se te mbyllni?';
  }

  @override
  String get saveButton => 'Ruaj';

  @override
  String get discardButton => 'Mos ruaj';

  @override
  String get documentEdited => 'I redaktuar';

  @override
  String get documentSaved => 'U ruajt';

  @override
  String get menuSettings => 'Cilesimet...';

  @override
  String get menuWindow => 'Dritare';

  @override
  String get menuMinimize => 'Minimizo';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Sill Të Gjitha Para';

  @override
  String get settingsTitle => 'Cilesimet';

  @override
  String get settingsLanguage => 'Gjuha';

  @override
  String get settingsLanguageSystem => 'Parazgjedhja e sistemit';

  @override
  String get settingsUnits => 'Njesite';

  @override
  String get settingsUnitsCentimeters => 'Centimetra';

  @override
  String get settingsUnitsInches => 'Inca';

  @override
  String get settingsSearchLanguages => 'Kërko gjuhët...';

  @override
  String get settingsGeneral => 'Të përgjithshme';

  @override
  String get addImage => 'Shto imazh';

  @override
  String get selectImages => 'Zgjidh imazhe';

  @override
  String get zoomFitWidth => 'Përshtat gjerësinë';

  @override
  String get zoomIn => 'Zmadho';

  @override
  String get zoomOut => 'Zvogëlo';

  @override
  String get selectZoomLevel => 'Zgjidh nivelin e zmadhimit';

  @override
  String get goToPage => 'Shko te faqja';

  @override
  String get go => 'Shko';

  @override
  String get savePdfAs => 'Ruaj PDF si';

  @override
  String get incorrectPassword => 'Fjalëkalim i gabuar';

  @override
  String get saveFailed => 'Ruajtja dështoi';

  @override
  String savedTo(String path) {
    return 'U ruajt në: $path';
  }

  @override
  String get noOriginalPdfStored => 'Asnjë PDF origjinal i ruajtur';

  @override
  String get waitingForFolderPermission =>
      'Duke pritur lejen e qasjes në dosje...';

  @override
  String get emptyRecentFiles => 'Hap një skedar për të filluar';

  @override
  String get imagesTitle => 'Imazhet';

  @override
  String get noImagesYet => 'Ende nuk ka imazhe';

  @override
  String get noImagesHint =>
      'Prek + për të shtuar vulën ose nënshkrimin tuaj të parë';

  @override
  String get done => 'U krye';

  @override
  String get menuEdit => 'Ndrysho';

  @override
  String get chooseFromFiles => 'Zgjidh nga skedarët';

  @override
  String get chooseFromGallery => 'Zgjidh nga galeria';

  @override
  String get imageTooBig => 'Imazhi është shumë i madh (maks. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Rezolucioni është shumë i lartë (maks. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Format imazhi i pambështetur';

  @override
  String get deleteTooltip => 'Fshi';

  @override
  String get shareTooltip => 'Ndaj';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Faqja $currentPage nga $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Asnjë dokument i ngarkuar';

  @override
  String get failedToLoadPdf => 'Dështoi ngarkimi i PDF';

  @override
  String get passwordRequired => 'Kërkohet fjalëkalim';

  @override
  String get pdfPasswordProtected => 'Ky PDF është i mbrojtur me fjalëkalim.';

  @override
  String errorWithMessage(String message) {
    return 'Gabim: $message';
  }

  @override
  String get unsavedChangesTitle => 'Ndryshime të paruajtura';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Dëshironi të ruani ndryshimet në \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Prek për të hapur një dokument PDF';

  @override
  String get onboardingSwipeUp =>
      'Rrëshqit lart për të shtuar nënshkrime dhe vula';

  @override
  String get onboardingAddImage =>
      'Prek për të shtuar nënshkrimin ose vulën tuaj të parë';

  @override
  String get onboardingDragImage => 'Tërhiq mbi PDF për ta vendosur';

  @override
  String get onboardingResizeObject =>
      'Prek për të zgjedhur. Tërhiq qoshet për të ndryshuar madhësinë.';

  @override
  String get onboardingDeleteImage => 'Prekni për të fshirë imazhin e zgjedhur';

  @override
  String get onboardingTapToContinue => 'Prek kudo për të vazhduar';

  @override
  String get imageConversionFailed => 'Dështoi konvertimi i imazhit në PDF';

  @override
  String get saveDocumentTitle => 'Ruaj dokumentin';

  @override
  String get fileNameLabel => 'Emri i skedarit';

  @override
  String get defaultFileName => 'Dokument';

  @override
  String get onlyOnePdfAllowed => 'Vetëm një PDF mund të hapet njëkohësisht';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'Skedarët PDF u injoruan. Vetëm imazhet konvertohen.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imazhe',
      one: 'imazh',
    );
    return 'Duke konvertuar $count $_temp0...';
  }
}
