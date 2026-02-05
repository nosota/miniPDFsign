// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get openPdf => 'Atidaryti PDF';

  @override
  String get selectPdf => 'Atidaryti failą';

  @override
  String get untitledDocument => 'Be pavadinimo.pdf';

  @override
  String get recentFiles => 'Naujausi failai';

  @override
  String get removeFromList => 'Pasalinti is saraso';

  @override
  String get openedNow => 'Ka tik atidarytas';

  @override
  String openedMinutesAgo(int count) {
    return 'Atidarytas pries $count min.';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Atidarytas pries $count val.';
  }

  @override
  String get openedYesterday => 'Atidarytas vakar';

  @override
  String openedDaysAgo(int count) {
    return 'Atidarytas pries $count d.';
  }

  @override
  String get fileNotFound => 'Failas nerastas';

  @override
  String get fileAccessDenied => 'Prieiga uzdrausta';

  @override
  String get clearRecentFiles => 'Isvalyti naujausius';

  @override
  String get cancel => 'Atsaukti';

  @override
  String get confirm => 'Patvirtinti';

  @override
  String get error => 'Klaida';

  @override
  String get ok => 'Gerai';

  @override
  String get menuFile => 'Failas';

  @override
  String get menuOpen => 'Atidaryti...';

  @override
  String get menuOpenRecent => 'Atidaryti naujausius';

  @override
  String get menuNoRecentFiles => 'Nera naujausiu failu';

  @override
  String get menuClearMenu => 'Isvalyti meniu';

  @override
  String get menuSave => 'Issaugoti';

  @override
  String get menuSaveAs => 'Issaugoti kaip...';

  @override
  String get menuSaveAll => 'Išsaugoti viską';

  @override
  String get menuShare => 'Bendrinti...';

  @override
  String get menuCloseWindow => 'Uzdaryti langa';

  @override
  String get menuCloseAll => 'Uždaryti visus';

  @override
  String get menuQuit => 'Išeiti iš PDFSign';

  @override
  String get closeAllDialogTitle => 'Išsaugoti pakeitimus?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Ar norite išsaugoti pakeitimus $count dokumentuose prieš uždarant?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Ar norite išsaugoti pakeitimus 1 dokumente prieš uždarant?';

  @override
  String get closeAllDialogSaveAll => 'Išsaugoti visus';

  @override
  String get closeAllDialogDontSave => 'Neišsaugoti';

  @override
  String get closeAllDialogCancel => 'Atšaukti';

  @override
  String get saveFailedDialogTitle => 'Išsaugoti nepavyko';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Nepavyko išsaugoti $count dokumentų. Vis tiek uždaryti?';
  }

  @override
  String get saveFailedDialogClose => 'Vis tiek uždaryti';

  @override
  String get saveChangesTitle => 'Issaugoti pakeitimus?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Ar norite issaugoti pakeitimus faile \"$fileName\" pries uzdarant?';
  }

  @override
  String get saveButton => 'Issaugoti';

  @override
  String get discardButton => 'Atmesti';

  @override
  String get documentEdited => 'Redaguota';

  @override
  String get documentSaved => 'Issaugota';

  @override
  String get menuSettings => 'Nustatymai...';

  @override
  String get menuWindow => 'Langas';

  @override
  String get menuMinimize => 'Sumažinti';

  @override
  String get menuZoom => 'Mastelis';

  @override
  String get menuBringAllToFront => 'Visus į priekį';

  @override
  String get settingsTitle => 'Nustatymai';

  @override
  String get settingsLanguage => 'Kalba';

  @override
  String get settingsLanguageSystem => 'Sistemos numatytoji';

  @override
  String get settingsUnits => 'Matavimo vienetai';

  @override
  String get settingsUnitsCentimeters => 'Centimetrai';

  @override
  String get settingsUnitsInches => 'Coliai';

  @override
  String get settingsUnitsDefault => 'Numatytasis (pagal regioną)';

  @override
  String get settingsSearchLanguages => 'Ieškoti kalbų...';

  @override
  String get settingsGeneral => 'Bendra';

  @override
  String get addImage => 'Pridėti vaizdą';

  @override
  String get selectImages => 'Pasirinkti vaizdus';

  @override
  String get zoomFitWidth => 'Pritaikyti pločiui';

  @override
  String get zoomIn => 'Priartinti';

  @override
  String get zoomOut => 'Atitolinti';

  @override
  String get selectZoomLevel => 'Pasirinkti mastelio lygį';

  @override
  String get goToPage => 'Eiti į puslapį';

  @override
  String get go => 'Eiti';

  @override
  String get savePdfAs => 'Išsaugoti PDF kaip';

  @override
  String get incorrectPassword => 'Neteisingas slaptažodis';

  @override
  String get saveFailed => 'Išsaugoti nepavyko';

  @override
  String savedTo(String path) {
    return 'Išsaugota: $path';
  }

  @override
  String get noOriginalPdfStored => 'Originalus PDF neišsaugotas';

  @override
  String get waitingForFolderPermission =>
      'Laukiama aplanko prieigos leidimo...';

  @override
  String get emptyRecentFiles => 'Atidarykite failą, kad pradėtumėte';

  @override
  String get imagesTitle => 'Vaizdai';

  @override
  String get noImagesYet => 'Kol kas nėra vaizdų';

  @override
  String get noImagesHint =>
      'Bakstelėkite +, kad pridėtumėte pirmą antspaudą ar parašą';

  @override
  String get done => 'Atlikta';

  @override
  String get menuEdit => 'Redaguoti';

  @override
  String get chooseFromFiles => 'Pasirinkti iš failų';

  @override
  String get chooseFromGallery => 'Pasirinkti iš galerijos';

  @override
  String get imageTooBig => 'Vaizdas per didelis (maks. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Rezoliucija per didelė (maks. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Nepalaikomas vaizdo formatas';

  @override
  String get deleteTooltip => 'Ištrinti';

  @override
  String get shareTooltip => 'Bendrinti';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Puslapis $currentPage iš $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Dokumentas neįkeltas';

  @override
  String get failedToLoadPdf => 'Nepavyko įkelti PDF';

  @override
  String get passwordRequired => 'Reikalingas slaptažodis';

  @override
  String get pdfPasswordProtected => 'Šis PDF apsaugotas slaptažodžiu.';

  @override
  String errorWithMessage(String message) {
    return 'Klaida: $message';
  }

  @override
  String get unsavedChangesTitle => 'Neišsaugoti pakeitimai';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Ar norite išsaugoti pakeitimus faile \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf =>
      'Bakstelėkite, kad atidarytumėte PDF dokumentą';

  @override
  String get onboardingSwipeUp =>
      'Braukite aukštyn, kad pridėtumėte parašus ir antspaudus';

  @override
  String get onboardingAddImage =>
      'Bakstelėkite, kad pridėtumėte pirmą parašą ar antspaudą';

  @override
  String get onboardingDragImage => 'Vilkite ant PDF, kad padėtumėte';

  @override
  String get onboardingResizeObject =>
      'Bakstelėkite, kad pasirinktumėte. Vilkite kampus, kad pakeistumėte dydį.';

  @override
  String get onboardingDeleteImage =>
      'Palieskite, kad ištrintumėte pasirinktą vaizdą';

  @override
  String get onboardingTapToContinue => 'Bakstelėkite bet kur, kad tęstumėte';

  @override
  String get imageConversionFailed => 'Nepavyko konvertuoti vaizdo į PDF';

  @override
  String get saveDocumentTitle => 'Išsaugoti dokumentą';

  @override
  String get fileNameLabel => 'Failo pavadinimas';

  @override
  String get defaultFileName => 'Dokumentas';

  @override
  String get onlyOnePdfAllowed =>
      'Vienu metu galima atidaryti tik vieną PDF failą';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF failai buvo ignoruoti. Konvertuojami tik vaizdai.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'vaizdų',
      many: 'vaizdų',
      few: 'vaizdai',
      one: 'vaizdas',
    );
    return 'Konvertuojama $count $_temp0...';
  }

  @override
  String get takePhoto => 'Fotografuoti';

  @override
  String get removeBackgroundTitle => 'Pašalinti foną?';

  @override
  String get removeBackgroundMessage =>
      'Aptiktas vienalytis fonas. Ar norite jį padaryti skaidrų?';

  @override
  String get removeBackground => 'Pašalinti';

  @override
  String get keepOriginal => 'Palikti';

  @override
  String get processingImage => 'Apdorojamas vaizdas...';

  @override
  String get backgroundRemovalFailed => 'Nepavyko pašalinti fono';
}
