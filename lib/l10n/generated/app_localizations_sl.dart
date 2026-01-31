// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get openPdf => 'Odpri PDF';

  @override
  String get selectPdf => 'Odpri datoteko';

  @override
  String get untitledDocument => 'Brez naslova.pdf';

  @override
  String get recentFiles => 'Nedavne datoteke';

  @override
  String get removeFromList => 'Odstrani s seznama';

  @override
  String get openedNow => 'Pravkar odprto';

  @override
  String openedMinutesAgo(int count) {
    return 'Odprto pred $count minutami';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Odprto pred $count urami';
  }

  @override
  String get openedYesterday => 'Odprto vceraj';

  @override
  String openedDaysAgo(int count) {
    return 'Odprto pred $count dnevi';
  }

  @override
  String get fileNotFound => 'Datoteka ni najdena';

  @override
  String get fileAccessDenied => 'Dostop zavrnjen';

  @override
  String get clearRecentFiles => 'Pocisti nedavne datoteke';

  @override
  String get cancel => 'Preklic';

  @override
  String get confirm => 'Potrdi';

  @override
  String get error => 'Napaka';

  @override
  String get ok => 'V redu';

  @override
  String get menuFile => 'Datoteka';

  @override
  String get menuOpen => 'Odpri...';

  @override
  String get menuOpenRecent => 'Odpri nedavne';

  @override
  String get menuNoRecentFiles => 'Ni nedavnih datotek';

  @override
  String get menuClearMenu => 'Pocisti meni';

  @override
  String get menuSave => 'Shrani';

  @override
  String get menuSaveAs => 'Shrani kot...';

  @override
  String get menuSaveAll => 'Shrani vse';

  @override
  String get menuShare => 'Deli...';

  @override
  String get menuCloseWindow => 'Zapri okno';

  @override
  String get menuCloseAll => 'Zapri vse';

  @override
  String get menuQuit => 'Zapusti PDFSign';

  @override
  String get closeAllDialogTitle => 'Shrani spremembe?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Ali želite shraniti spremembe v $count dokumentih pred zaprtjem?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Ali želite shraniti spremembe v 1 dokumentu pred zaprtjem?';

  @override
  String get closeAllDialogSaveAll => 'Shrani vse';

  @override
  String get closeAllDialogDontSave => 'Ne shrani';

  @override
  String get closeAllDialogCancel => 'Preklic';

  @override
  String get saveFailedDialogTitle => 'Shranjevanje ni uspelo';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Shranjevanje $count dokumenta(ov) ni uspelo. Vseeno zaprem?';
  }

  @override
  String get saveFailedDialogClose => 'Vseeno zapri';

  @override
  String get saveChangesTitle => 'Shrani spremembe?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Ali zelite shraniti spremembe v \"$fileName\" pred zaprtjem?';
  }

  @override
  String get saveButton => 'Shrani';

  @override
  String get discardButton => 'Ne shrani';

  @override
  String get documentEdited => 'Urejeno';

  @override
  String get documentSaved => 'Shranjeno';

  @override
  String get menuSettings => 'Nastavitve...';

  @override
  String get menuWindow => 'Okno';

  @override
  String get menuMinimize => 'Minimiraj';

  @override
  String get menuZoom => 'Povečaj';

  @override
  String get menuBringAllToFront => 'Prinesi vse v ospredje';

  @override
  String get settingsTitle => 'Nastavitve';

  @override
  String get settingsLanguage => 'Jezik';

  @override
  String get settingsLanguageSystem => 'Sistemska privzeta';

  @override
  String get settingsUnits => 'Enote';

  @override
  String get settingsUnitsCentimeters => 'Centimetri';

  @override
  String get settingsUnitsInches => 'Palci';

  @override
  String get settingsSearchLanguages => 'Iskanje jezikov...';

  @override
  String get settingsGeneral => 'Splošno';

  @override
  String get addImage => 'Dodaj sliko';

  @override
  String get selectImages => 'Izberi slike';

  @override
  String get zoomFitWidth => 'Prilagodi širini';

  @override
  String get zoomIn => 'Povečaj';

  @override
  String get zoomOut => 'Pomanjšaj';

  @override
  String get selectZoomLevel => 'Izberi stopnjo povečave';

  @override
  String get goToPage => 'Pojdi na stran';

  @override
  String get go => 'Pojdi';

  @override
  String get savePdfAs => 'Shrani PDF kot';

  @override
  String get incorrectPassword => 'Napačno geslo';

  @override
  String get saveFailed => 'Shranjevanje ni uspelo';

  @override
  String savedTo(String path) {
    return 'Shranjeno v: $path';
  }

  @override
  String get noOriginalPdfStored => 'Izvirni PDF ni shranjen';

  @override
  String get waitingForFolderPermission =>
      'Čakanje na dovoljenje za dostop do mape...';

  @override
  String get emptyRecentFiles => 'Odprite datoteko za začetek';

  @override
  String get imagesTitle => 'Slike';

  @override
  String get noImagesYet => 'Še ni slik';

  @override
  String get noImagesHint => 'Tapnite + za dodajanje prvega žiga ali podpisa';

  @override
  String get done => 'Končano';

  @override
  String get menuEdit => 'Uredi';

  @override
  String get chooseFromFiles => 'Izberi iz datotek';

  @override
  String get chooseFromGallery => 'Izberi iz galerije';

  @override
  String get imageTooBig => 'Slika je prevelika (maks. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Ločljivost je previsoka (maks. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Nepodprta oblika slike';

  @override
  String get deleteTooltip => 'Izbriši';

  @override
  String get shareTooltip => 'Deli';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Stran $currentPage od $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Noben dokument ni naložen';

  @override
  String get failedToLoadPdf => 'Nalaganje PDF ni uspelo';

  @override
  String get passwordRequired => 'Zahtevano je geslo';

  @override
  String get pdfPasswordProtected => 'Ta PDF je zaščiten z geslom.';

  @override
  String errorWithMessage(String message) {
    return 'Napaka: $message';
  }

  @override
  String get unsavedChangesTitle => 'Neshranjene spremembe';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Ali želite shraniti spremembe v \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Tapnite za odpiranje PDF dokumenta';

  @override
  String get onboardingSwipeUp =>
      'Povlecite navzgor za dodajanje podpisov in žigov';

  @override
  String get onboardingAddImage =>
      'Tapnite za dodajanje prvega podpisa ali žiga';

  @override
  String get onboardingDragImage => 'Povlecite na PDF za postavitev';

  @override
  String get onboardingResizeObject =>
      'Tapnite za izbiro. Povlecite vogale za spreminjanje velikosti.';

  @override
  String get onboardingDeleteImage => 'Tapnite za brisanje izbrane slike';

  @override
  String get onboardingTapToContinue => 'Tapnite kjerkoli za nadaljevanje';

  @override
  String get imageConversionFailed => 'Slike ni bilo mogoče pretvoriti v PDF';

  @override
  String get saveDocumentTitle => 'Shrani dokument';

  @override
  String get fileNameLabel => 'Ime datoteke';

  @override
  String get defaultFileName => 'Dokument';

  @override
  String get onlyOnePdfAllowed =>
      'Naenkrat je mogoče odpreti samo eno datoteko PDF';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'Datoteke PDF so bile prezrte. Pretvarjajo se samo slike.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'slik',
      few: 'slik',
      two: 'slik',
      one: 'slike',
    );
    return 'Pretvarjanje $count $_temp0...';
  }
}
