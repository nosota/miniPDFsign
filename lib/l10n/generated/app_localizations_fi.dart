// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get openPdf => 'Avaa PDF';

  @override
  String get selectPdf => 'Valitse PDF';

  @override
  String get recentFiles => 'Viimeisimmät tiedostot';

  @override
  String get removeFromList => 'Poista luettelosta';

  @override
  String get openedNow => 'Juuri avattu';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minuuttia',
      one: 'minuutti',
    );
    return 'Avattu $count $_temp0 sitten';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'tuntia',
      one: 'tunti',
    );
    return 'Avattu $count $_temp0 sitten';
  }

  @override
  String get openedYesterday => 'Avattu eilen';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'päivää',
      one: 'päivä',
    );
    return 'Avattu $count $_temp0 sitten';
  }

  @override
  String get fileNotFound => 'Tiedostoa ei löytynyt';

  @override
  String get fileAccessDenied => 'Pääsy estetty';

  @override
  String get clearRecentFiles => 'Tyhjennä viimeisimmät tiedostot';

  @override
  String get cancel => 'Kumoa';

  @override
  String get confirm => 'Vahvista';

  @override
  String get error => 'Virhe';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Arkisto';

  @override
  String get menuOpen => 'Avaa...';

  @override
  String get menuOpenRecent => 'Avaa viimeisimmät';

  @override
  String get menuNoRecentFiles => 'Ei viimeisimpiä tiedostoja';

  @override
  String get menuClearMenu => 'Tyhjennä valikko';

  @override
  String get menuSave => 'Tallenna';

  @override
  String get menuSaveAs => 'Tallenna nimellä...';

  @override
  String get menuSaveAll => 'Tallenna kaikki';

  @override
  String get menuShare => 'Jaa...';

  @override
  String get menuCloseWindow => 'Sulje ikkuna';

  @override
  String get menuCloseAll => 'Sulje kaikki';

  @override
  String get menuQuit => 'Lopeta PDFSign';

  @override
  String get closeAllDialogTitle => 'Tallenna muutokset?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Haluatko tallentaa muutokset $count asiakirjaan ennen sulkemista?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Haluatko tallentaa muutokset 1 asiakirjaan ennen sulkemista?';

  @override
  String get closeAllDialogSaveAll => 'Tallenna kaikki';

  @override
  String get closeAllDialogDontSave => 'Älä tallenna';

  @override
  String get closeAllDialogCancel => 'Kumoa';

  @override
  String get saveFailedDialogTitle => 'Tallennus epäonnistui';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count asiakirjan tallennus epäonnistui. Suljetaanko silti?';
  }

  @override
  String get saveFailedDialogClose => 'Sulje silti';

  @override
  String get saveChangesTitle => 'Tallenna muutokset?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Haluatko tallentaa muutokset tiedostoon \"$fileName\" ennen sulkemista?';
  }

  @override
  String get saveButton => 'Tallenna';

  @override
  String get discardButton => 'Älä tallenna';

  @override
  String get documentEdited => 'Muokattu';

  @override
  String get documentSaved => 'Tallennettu';

  @override
  String get menuSettings => 'Asetukset...';

  @override
  String get menuWindow => 'Ikkuna';

  @override
  String get menuMinimize => 'Pienennä';

  @override
  String get menuZoom => 'Zoomaa';

  @override
  String get menuBringAllToFront => 'Tuo kaikki eteen';

  @override
  String get settingsTitle => 'Asetukset';

  @override
  String get settingsLanguage => 'Kieli';

  @override
  String get settingsLanguageSystem => 'Järjestelmän oletus';

  @override
  String get settingsUnits => 'Yksiköt';

  @override
  String get settingsUnitsCentimeters => 'Senttimetrit';

  @override
  String get settingsUnitsInches => 'Tuumat';

  @override
  String get settingsSearchLanguages => 'Etsi kieliä...';

  @override
  String get settingsGeneral => 'Yleistä';

  @override
  String get addImage => 'Lisää kuva';

  @override
  String get selectImages => 'Valitse kuvat';

  @override
  String get zoomFitWidth => 'Sovita leveyteen';

  @override
  String get zoomIn => 'Lähennä';

  @override
  String get zoomOut => 'Loitonna';

  @override
  String get selectZoomLevel => 'Valitse zoomaustaso';

  @override
  String get goToPage => 'Siirry sivulle';

  @override
  String get go => 'Siirry';

  @override
  String get savePdfAs => 'Tallenna PDF nimellä';

  @override
  String get incorrectPassword => 'Väärä salasana';

  @override
  String get saveFailed => 'Tallennus epäonnistui';

  @override
  String savedTo(String path) {
    return 'Tallennettu: $path';
  }

  @override
  String get noOriginalPdfStored => 'Alkuperäistä PDF:ää ei tallennettu';

  @override
  String get waitingForFolderPermission =>
      'Odotetaan kansion käyttöoikeutta...';

  @override
  String get emptyRecentFiles => 'Avaa PDF aloittaaksesi';

  @override
  String get imagesTitle => 'Kuvat';

  @override
  String get noImagesYet => 'Ei kuvia vielä';

  @override
  String get noImagesHint =>
      'Napauta + lisätäksesi ensimmäisen leiman tai allekirjoituksen';

  @override
  String get done => 'Valmis';

  @override
  String get menuEdit => 'Muokkaa';

  @override
  String get chooseFromFiles => 'Valitse tiedostoista';

  @override
  String get chooseFromGallery => 'Valitse galleriasta';

  @override
  String get imageTooBig => 'Kuva on liian suuri (enint. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Resoluutio on liian korkea (enint. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Kuvamuotoa ei tueta';

  @override
  String get deleteTooltip => 'Poista';

  @override
  String get shareTooltip => 'Jaa';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Sivu $currentPage / $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Dokumenttia ei ole ladattu';

  @override
  String get failedToLoadPdf => 'PDF:n lataaminen epäonnistui';

  @override
  String get passwordRequired => 'Salasana vaaditaan';

  @override
  String get pdfPasswordProtected => 'Tämä PDF on salasanasuojattu.';

  @override
  String errorWithMessage(String message) {
    return 'Virhe: $message';
  }

  @override
  String get unsavedChangesTitle => 'Tallentamattomat muutokset';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Haluatko tallentaa muutokset tiedostoon \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Napauta avataksesi PDF-asiakirjan';

  @override
  String get onboardingSwipeUp =>
      'Pyyhkäise ylös lisätäksesi allekirjoituksia ja leimoja';

  @override
  String get onboardingAddImage =>
      'Napauta lisätäksesi ensimmäisen allekirjoituksen tai leiman';

  @override
  String get onboardingDragImage => 'Vedä PDF:ään sijoittaaksesi sen';

  @override
  String get onboardingResizeObject =>
      'Napauta valitaksesi. Vedä kulmista muuttaaksesi kokoa.';

  @override
  String get onboardingDeleteImage => 'Tap to delete the selected image';

  @override
  String get onboardingTapToContinue => 'Napauta minne tahansa jatkaaksesi';

  @override
  String get imageConversionFailed =>
      'Kuvan muuntaminen PDF-muotoon epäonnistui';
}
