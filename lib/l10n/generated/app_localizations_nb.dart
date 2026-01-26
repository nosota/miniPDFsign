// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get openPdf => 'Åpne PDF';

  @override
  String get selectPdf => 'Velg PDF';

  @override
  String get recentFiles => 'Nylige filer';

  @override
  String get removeFromList => 'Fjern fra listen';

  @override
  String get openedNow => 'Nettopp åpnet';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutter',
      one: 'minutt',
    );
    return 'Åpnet for $count $_temp0 siden';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'timer',
      one: 'time',
    );
    return 'Åpnet for $count $_temp0 siden';
  }

  @override
  String get openedYesterday => 'Åpnet i går';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dager',
      one: 'dag',
    );
    return 'Åpnet for $count $_temp0 siden';
  }

  @override
  String get fileNotFound => 'Filen ble ikke funnet';

  @override
  String get fileAccessDenied => 'Tilgang nektet';

  @override
  String get clearRecentFiles => 'Tøm nylige filer';

  @override
  String get cancel => 'Avbryt';

  @override
  String get confirm => 'Bekreft';

  @override
  String get error => 'Feil';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Arkiv';

  @override
  String get menuOpen => 'Åpne...';

  @override
  String get menuOpenRecent => 'Åpne nylige';

  @override
  String get menuNoRecentFiles => 'Ingen nylige filer';

  @override
  String get menuClearMenu => 'Tøm meny';

  @override
  String get menuSave => 'Lagre';

  @override
  String get menuSaveAs => 'Lagre som...';

  @override
  String get menuSaveAll => 'Lagre alle';

  @override
  String get menuShare => 'Del...';

  @override
  String get menuCloseWindow => 'Lukk vindu';

  @override
  String get menuCloseAll => 'Lukk alle';

  @override
  String get menuQuit => 'Avslutt PDFSign';

  @override
  String get closeAllDialogTitle => 'Lagre endringer?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Vil du lagre endringene i $count dokumenter før lukking?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Vil du lagre endringene i 1 dokument før lukking?';

  @override
  String get closeAllDialogSaveAll => 'Lagre alle';

  @override
  String get closeAllDialogDontSave => 'Ikke lagre';

  @override
  String get closeAllDialogCancel => 'Avbryt';

  @override
  String get saveFailedDialogTitle => 'Lagring mislyktes';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Kunne ikke lagre $count dokument(er). Lukke likevel?';
  }

  @override
  String get saveFailedDialogClose => 'Lukk likevel';

  @override
  String get saveChangesTitle => 'Lagre endringer?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Vil du lagre endringene i \"$fileName\" før lukking?';
  }

  @override
  String get saveButton => 'Lagre';

  @override
  String get discardButton => 'Ikke lagre';

  @override
  String get documentEdited => 'Redigert';

  @override
  String get documentSaved => 'Lagret';

  @override
  String get menuSettings => 'Innstillinger...';

  @override
  String get menuWindow => 'Vindu';

  @override
  String get menuMinimize => 'Minimer';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Vis alle foran';

  @override
  String get settingsTitle => 'Innstillinger';

  @override
  String get settingsLanguage => 'Språk';

  @override
  String get settingsLanguageSystem => 'Systemstandard';

  @override
  String get settingsUnits => 'Enheter';

  @override
  String get settingsUnitsCentimeters => 'Centimeter';

  @override
  String get settingsUnitsInches => 'Tommer';

  @override
  String get settingsSearchLanguages => 'Søk etter språk...';

  @override
  String get settingsGeneral => 'Generelt';

  @override
  String get addImage => 'Legg til bilde';

  @override
  String get selectImages => 'Velg bilder';

  @override
  String get zoomFitWidth => 'Tilpass bredde';

  @override
  String get zoomIn => 'Zoom inn';

  @override
  String get zoomOut => 'Zoom ut';

  @override
  String get selectZoomLevel => 'Velg zoomnivå';

  @override
  String get goToPage => 'Gå til side';

  @override
  String get go => 'Gå';

  @override
  String get savePdfAs => 'Lagre PDF som';

  @override
  String get incorrectPassword => 'Feil passord';

  @override
  String get saveFailed => 'Lagring mislyktes';

  @override
  String savedTo(String path) {
    return 'Lagret til: $path';
  }

  @override
  String get noOriginalPdfStored => 'Ingen original PDF lagret';

  @override
  String get waitingForFolderPermission =>
      'Venter på tillatelse til mappeadgang...';

  @override
  String get emptyRecentFiles => 'Åpne en PDF for å komme i gang';

  @override
  String get imagesTitle => 'Bilder';

  @override
  String get noImagesYet => 'Ingen bilder ennå';

  @override
  String get noImagesHint =>
      'Trykk på + for å legge til ditt første stempel eller signatur';

  @override
  String get done => 'Ferdig';

  @override
  String get menuEdit => 'Rediger';

  @override
  String get chooseFromFiles => 'Velg fra filer';

  @override
  String get chooseFromGallery => 'Velg fra galleri';

  @override
  String get imageTooBig => 'Bildet er for stort (maks. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Oppløsningen er for høy (maks. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Bildeformat støttes ikke';
}
