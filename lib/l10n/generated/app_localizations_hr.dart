// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get openPdf => 'Otvori PDF';

  @override
  String get selectPdf => 'Otvori datoteku';

  @override
  String get untitledDocument => 'Bez naslova.pdf';

  @override
  String get recentFiles => 'Nedavne datoteke';

  @override
  String get removeFromList => 'Ukloni s popisa';

  @override
  String get openedNow => 'Upravo otvoreno';

  @override
  String openedMinutesAgo(int count) {
    return 'Otvoreno prije $count minuta';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Otvoreno prije $count sati';
  }

  @override
  String get openedYesterday => 'Otvoreno jucer';

  @override
  String openedDaysAgo(int count) {
    return 'Otvoreno prije $count dana';
  }

  @override
  String get fileNotFound => 'Datoteka nije pronadena';

  @override
  String get fileAccessDenied => 'Pristup odbijen';

  @override
  String get clearRecentFiles => 'Ocisti nedavne datoteke';

  @override
  String get cancel => 'Odustani';

  @override
  String get confirm => 'Potvrdi';

  @override
  String get error => 'Greska';

  @override
  String get ok => 'U redu';

  @override
  String get menuFile => 'Datoteka';

  @override
  String get menuOpen => 'Otvori...';

  @override
  String get menuOpenRecent => 'Otvori nedavne';

  @override
  String get menuNoRecentFiles => 'Nema nedavnih datoteka';

  @override
  String get menuClearMenu => 'Ocisti izbornik';

  @override
  String get menuSave => 'Spremi';

  @override
  String get menuSaveAs => 'Spremi kao...';

  @override
  String get menuSaveAll => 'Spremi sve';

  @override
  String get menuShare => 'Podijeli...';

  @override
  String get menuCloseWindow => 'Zatvori prozor';

  @override
  String get menuCloseAll => 'Zatvori sve';

  @override
  String get menuQuit => 'Zatvori PDFSign';

  @override
  String get closeAllDialogTitle => 'Spremi promjene?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Želite li spremiti promjene u $count dokumenata prije zatvaranja?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Želite li spremiti promjene u 1 dokumentu prije zatvaranja?';

  @override
  String get closeAllDialogSaveAll => 'Spremi sve';

  @override
  String get closeAllDialogDontSave => 'Ne spremi';

  @override
  String get closeAllDialogCancel => 'Odustani';

  @override
  String get saveFailedDialogTitle => 'Spremanje nije uspjelo';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Spremanje $count dokumenta nije uspjelo. Svejedno zatvoriti?';
  }

  @override
  String get saveFailedDialogClose => 'Svejedno zatvori';

  @override
  String get saveChangesTitle => 'Spremi promjene?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Zelite li spremiti promjene u \"$fileName\" prije zatvaranja?';
  }

  @override
  String get saveButton => 'Spremi';

  @override
  String get discardButton => 'Ne spremi';

  @override
  String get documentEdited => 'Uredeno';

  @override
  String get documentSaved => 'Spremljeno';

  @override
  String get menuSettings => 'Postavke...';

  @override
  String get menuWindow => 'Prozor';

  @override
  String get menuMinimize => 'Minimiziraj';

  @override
  String get menuZoom => 'Zumiraj';

  @override
  String get menuBringAllToFront => 'Dovedi sve naprijed';

  @override
  String get settingsTitle => 'Postavke';

  @override
  String get settingsLanguage => 'Jezik';

  @override
  String get settingsLanguageSystem => 'Zadano sustava';

  @override
  String get settingsUnits => 'Jedinice';

  @override
  String get settingsUnitsCentimeters => 'Centimetri';

  @override
  String get settingsUnitsInches => 'Inci';

  @override
  String get settingsSearchLanguages => 'Pretraži jezike...';

  @override
  String get settingsGeneral => 'Opće';

  @override
  String get addImage => 'Dodaj sliku';

  @override
  String get selectImages => 'Odaberi slike';

  @override
  String get zoomFitWidth => 'Prilagodi širini';

  @override
  String get zoomIn => 'Povećaj';

  @override
  String get zoomOut => 'Smanji';

  @override
  String get selectZoomLevel => 'Odaberi razinu zumiranja';

  @override
  String get goToPage => 'Idi na stranicu';

  @override
  String get go => 'Idi';

  @override
  String get savePdfAs => 'Spremi PDF kao';

  @override
  String get incorrectPassword => 'Pogrešna lozinka';

  @override
  String get saveFailed => 'Spremanje nije uspjelo';

  @override
  String savedTo(String path) {
    return 'Spremljeno u: $path';
  }

  @override
  String get noOriginalPdfStored => 'Nema pohranjenog izvornog PDF-a';

  @override
  String get waitingForFolderPermission => 'Čekanje dozvole za pristup mapi...';

  @override
  String get emptyRecentFiles => 'Otvorite datoteku za početak';

  @override
  String get imagesTitle => 'Slike';

  @override
  String get noImagesYet => 'Još nema slika';

  @override
  String get noImagesHint =>
      'Dodirnite + za dodavanje prvog pečata ili potpisa';

  @override
  String get done => 'Gotovo';

  @override
  String get menuEdit => 'Uredi';

  @override
  String get chooseFromFiles => 'Odaberi iz datoteka';

  @override
  String get chooseFromGallery => 'Odaberi iz galerije';

  @override
  String get imageTooBig => 'Slika je prevelika (maks. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Rezolucija je previsoka (maks. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Nepodržani format slike';

  @override
  String get deleteTooltip => 'Obriši';

  @override
  String get shareTooltip => 'Podijeli';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Stranica $currentPage od $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Dokument nije učitan';

  @override
  String get failedToLoadPdf => 'Učitavanje PDF-a nije uspjelo';

  @override
  String get passwordRequired => 'Potrebna je lozinka';

  @override
  String get pdfPasswordProtected => 'Ovaj PDF je zaštićen lozinkom.';

  @override
  String errorWithMessage(String message) {
    return 'Greška: $message';
  }

  @override
  String get unsavedChangesTitle => 'Nespremljene promjene';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Želite li spremiti promjene u \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Dodirnite za otvaranje PDF dokumenta';

  @override
  String get onboardingSwipeUp =>
      'Povucite prema gore za dodavanje potpisa i pečata';

  @override
  String get onboardingAddImage =>
      'Dodirnite za dodavanje prvog potpisa ili pečata';

  @override
  String get onboardingDragImage => 'Povucite na PDF za postavljanje';

  @override
  String get onboardingResizeObject =>
      'Dodirnite za odabir. Povucite kutove za promjenu veličine.';

  @override
  String get onboardingDeleteImage => 'Dodirnite za brisanje odabrane slike';

  @override
  String get onboardingTapToContinue => 'Dodirnite bilo gdje za nastavak';

  @override
  String get imageConversionFailed => 'Nije uspjelo pretvaranje slike u PDF';

  @override
  String get saveDocumentTitle => 'Spremi dokument';

  @override
  String get fileNameLabel => 'Naziv datoteke';

  @override
  String get defaultFileName => 'Dokument';

  @override
  String get onlyOnePdfAllowed => 'Može se otvoriti samo jedan PDF istovremeno';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF datoteke su ignorirane. Pretvaraju se samo slike.';
}
