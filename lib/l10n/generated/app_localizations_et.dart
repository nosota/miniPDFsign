// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get openPdf => 'Ava PDF';

  @override
  String get selectPdf => 'Ava fail';

  @override
  String get untitledDocument => 'Nimetu.pdf';

  @override
  String get recentFiles => 'Hiljutised failid';

  @override
  String get removeFromList => 'Eemalda loendist';

  @override
  String get openedNow => 'Asja avatud';

  @override
  String openedMinutesAgo(int count) {
    return 'Avatud $count minutit tagasi';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Avatud $count tundi tagasi';
  }

  @override
  String get openedYesterday => 'Avatud eile';

  @override
  String openedDaysAgo(int count) {
    return 'Avatud $count paeva tagasi';
  }

  @override
  String get fileNotFound => 'Faili ei leitud';

  @override
  String get fileAccessDenied => 'Juurdepaaas keelatud';

  @override
  String get clearRecentFiles => 'Tuehjenda hiljutised failid';

  @override
  String get cancel => 'Tuehista';

  @override
  String get confirm => 'Kinnita';

  @override
  String get error => 'Viga';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fail';

  @override
  String get menuOpen => 'Ava...';

  @override
  String get menuOpenRecent => 'Ava hiljutised';

  @override
  String get menuNoRecentFiles => 'Hiljutisi faile pole';

  @override
  String get menuClearMenu => 'Tuehjenda menyy';

  @override
  String get menuSave => 'Salvesta';

  @override
  String get menuSaveAs => 'Salvesta kui...';

  @override
  String get menuSaveAll => 'Salvesta kõik';

  @override
  String get menuShare => 'Jaga...';

  @override
  String get menuCloseWindow => 'Sulge aken';

  @override
  String get menuCloseAll => 'Sulge kõik';

  @override
  String get menuQuit => 'Välju PDFSign';

  @override
  String get closeAllDialogTitle => 'Salvesta muudatused?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Kas soovite salvestada muudatused $count dokumendis enne sulgemist?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Kas soovite salvestada muudatused 1 dokumendis enne sulgemist?';

  @override
  String get closeAllDialogSaveAll => 'Salvesta kõik';

  @override
  String get closeAllDialogDontSave => 'Ära salvesta';

  @override
  String get closeAllDialogCancel => 'Tühista';

  @override
  String get saveFailedDialogTitle => 'Salvestamine ebaõnnestus';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count dokumendi salvestamine ebaõnnestus. Kas sulgeda siiski?';
  }

  @override
  String get saveFailedDialogClose => 'Sulge siiski';

  @override
  String get saveChangesTitle => 'Salvesta muudatused?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Kas soovite salvestada muudatused failis \"$fileName\" enne sulgemist?';
  }

  @override
  String get saveButton => 'Salvesta';

  @override
  String get discardButton => 'Ara salvesta';

  @override
  String get documentEdited => 'Muudetud';

  @override
  String get documentSaved => 'Salvestatud';

  @override
  String get menuSettings => 'Seaded...';

  @override
  String get menuWindow => 'Aken';

  @override
  String get menuMinimize => 'Minimeeri';

  @override
  String get menuZoom => 'Suumi';

  @override
  String get menuBringAllToFront => 'Too kõik ette';

  @override
  String get settingsTitle => 'Seaded';

  @override
  String get settingsLanguage => 'Keel';

  @override
  String get settingsLanguageSystem => 'Systeemi vaikevaartus';

  @override
  String get settingsUnits => 'Uhikud';

  @override
  String get settingsUnitsCentimeters => 'Sentimeetrid';

  @override
  String get settingsUnitsInches => 'Tollid';

  @override
  String get settingsSearchLanguages => 'Otsi keeli...';

  @override
  String get settingsGeneral => 'Üldine';

  @override
  String get addImage => 'Lisa pilt';

  @override
  String get selectImages => 'Vali pildid';

  @override
  String get zoomFitWidth => 'Sobita laiusega';

  @override
  String get zoomIn => 'Suurenda';

  @override
  String get zoomOut => 'Vähenda';

  @override
  String get selectZoomLevel => 'Vali suurenduse tase';

  @override
  String get goToPage => 'Mine leheküljele';

  @override
  String get go => 'Mine';

  @override
  String get savePdfAs => 'Salvesta PDF kui';

  @override
  String get incorrectPassword => 'Vale parool';

  @override
  String get saveFailed => 'Salvestamine ebaõnnestus';

  @override
  String savedTo(String path) {
    return 'Salvestatud: $path';
  }

  @override
  String get noOriginalPdfStored => 'Algset PDF-i pole salvestatud';

  @override
  String get waitingForFolderPermission => 'Kausta juurdepääsu loa ootamine...';

  @override
  String get emptyRecentFiles => 'Alustamiseks avage fail';

  @override
  String get imagesTitle => 'Pildid';

  @override
  String get noImagesYet => 'Pilte pole veel';

  @override
  String get noImagesHint =>
      'Puudutage +, et lisada esimene tempel või allkiri';

  @override
  String get done => 'Valmis';

  @override
  String get menuEdit => 'Muuda';

  @override
  String get chooseFromFiles => 'Vali failidest';

  @override
  String get chooseFromGallery => 'Vali galeriist';

  @override
  String get imageTooBig => 'Pilt on liiga suur (maks. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Eraldusvõime on liiga kõrge (maks. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Toetamata pildivorming';

  @override
  String get deleteTooltip => 'Kustuta';

  @override
  String get shareTooltip => 'Jaga';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Lehekülg $currentPage / $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Dokumenti pole laaditud';

  @override
  String get failedToLoadPdf => 'PDF-i laadimine ebaõnnestus';

  @override
  String get passwordRequired => 'Parool nõutud';

  @override
  String get pdfPasswordProtected => 'See PDF on parooliga kaitstud.';

  @override
  String errorWithMessage(String message) {
    return 'Viga: $message';
  }

  @override
  String get unsavedChangesTitle => 'Salvestamata muudatused';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Kas soovite salvestada muudatused failis \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Puudutage PDF-dokumendi avamiseks';

  @override
  String get onboardingSwipeUp =>
      'Pühkige üles allkirjade ja templite lisamiseks';

  @override
  String get onboardingAddImage =>
      'Puudutage oma esimese allkirja või templi lisamiseks';

  @override
  String get onboardingDragImage => 'Lohistage PDF-ile paigutamiseks';

  @override
  String get onboardingResizeObject =>
      'Puudutage valimiseks. Lohistage nurki suuruse muutmiseks.';

  @override
  String get onboardingDeleteImage => 'Puudutage valitud pildi kustutamiseks';

  @override
  String get onboardingTapToContinue => 'Puudutage kuskil jätkamiseks';

  @override
  String get imageConversionFailed => 'Pildi teisendamine PDF-iks ebaõnnestus';

  @override
  String get saveDocumentTitle => 'Salvesta dokument';

  @override
  String get fileNameLabel => 'Faili nimi';

  @override
  String get defaultFileName => 'Dokument';
}
