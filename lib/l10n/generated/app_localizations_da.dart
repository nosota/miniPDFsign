// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get openPdf => 'Åbn PDF';

  @override
  String get selectPdf => 'Vælg PDF';

  @override
  String get recentFiles => 'Seneste filer';

  @override
  String get removeFromList => 'Fjern fra listen';

  @override
  String get openedNow => 'Lige åbnet';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutter',
      one: 'minut',
    );
    return 'Åbnet for $count $_temp0 siden';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'timer',
      one: 'time',
    );
    return 'Åbnet for $count $_temp0 siden';
  }

  @override
  String get openedYesterday => 'Åbnet i går';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dage',
      one: 'dag',
    );
    return 'Åbnet for $count $_temp0 siden';
  }

  @override
  String get fileNotFound => 'Filen blev ikke fundet';

  @override
  String get fileAccessDenied => 'Adgang nægtet';

  @override
  String get clearRecentFiles => 'Ryd seneste filer';

  @override
  String get cancel => 'Annuller';

  @override
  String get confirm => 'Bekræft';

  @override
  String get error => 'Fejl';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Arkiv';

  @override
  String get menuOpen => 'Åbn...';

  @override
  String get menuOpenRecent => 'Åbn seneste';

  @override
  String get menuNoRecentFiles => 'Ingen seneste filer';

  @override
  String get menuClearMenu => 'Ryd menu';

  @override
  String get menuSave => 'Gem';

  @override
  String get menuSaveAs => 'Gem som...';

  @override
  String get menuSaveAll => 'Gem alle';

  @override
  String get menuShare => 'Del...';

  @override
  String get menuCloseWindow => 'Luk vindue';

  @override
  String get menuCloseAll => 'Luk alle';

  @override
  String get menuQuit => 'Afslut PDFSign';

  @override
  String get closeAllDialogTitle => 'Gem ændringer?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Vil du gemme ændringerne i $count dokumenter før lukning?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Vil du gemme ændringerne i 1 dokument før lukning?';

  @override
  String get closeAllDialogSaveAll => 'Gem alle';

  @override
  String get closeAllDialogDontSave => 'Gem ikke';

  @override
  String get closeAllDialogCancel => 'Annuller';

  @override
  String get saveFailedDialogTitle => 'Gem mislykkedes';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Kunne ikke gemme $count dokument(er). Luk alligevel?';
  }

  @override
  String get saveFailedDialogClose => 'Luk alligevel';

  @override
  String get saveChangesTitle => 'Gem ændringer?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Vil du gemme ændringerne i \"$fileName\" før lukning?';
  }

  @override
  String get saveButton => 'Gem';

  @override
  String get discardButton => 'Gem ikke';

  @override
  String get documentEdited => 'Redigeret';

  @override
  String get documentSaved => 'Gemt';

  @override
  String get menuSettings => 'Indstillinger...';

  @override
  String get menuWindow => 'Vindue';

  @override
  String get menuMinimize => 'Minimer';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Bring alle forrest';

  @override
  String get settingsTitle => 'Indstillinger';

  @override
  String get settingsLanguage => 'Sprog';

  @override
  String get settingsLanguageSystem => 'Systemstandard';

  @override
  String get settingsUnits => 'Enheder';

  @override
  String get settingsUnitsCentimeters => 'Centimeter';

  @override
  String get settingsUnitsInches => 'Tommer';

  @override
  String get settingsSearchLanguages => 'Søg sprog...';

  @override
  String get settingsGeneral => 'Generelt';

  @override
  String get addImage => 'Tilføj billede';

  @override
  String get selectImages => 'Vælg billeder';

  @override
  String get zoomFitWidth => 'Tilpas bredde';

  @override
  String get zoomIn => 'Zoom ind';

  @override
  String get zoomOut => 'Zoom ud';

  @override
  String get selectZoomLevel => 'Vælg zoomniveau';

  @override
  String get goToPage => 'Gå til side';

  @override
  String get go => 'Gå';

  @override
  String get savePdfAs => 'Gem PDF som';

  @override
  String get incorrectPassword => 'Forkert adgangskode';

  @override
  String get saveFailed => 'Gemning mislykkedes';

  @override
  String savedTo(String path) {
    return 'Gemt til: $path';
  }

  @override
  String get noOriginalPdfStored => 'Ingen original PDF gemt';

  @override
  String get waitingForFolderPermission =>
      'Venter på tilladelse til mappeadgang...';

  @override
  String get emptyRecentFiles => 'Åbn en PDF for at komme i gang';

  @override
  String get imagesTitle => 'Billeder';

  @override
  String get noImagesYet => 'Ingen billeder endnu';

  @override
  String get noImagesHint =>
      'Tryk på + for at tilføje dit første stempel eller underskrift';

  @override
  String get done => 'Færdig';

  @override
  String get menuEdit => 'Rediger';

  @override
  String get chooseFromFiles => 'Vælg fra filer';

  @override
  String get chooseFromGallery => 'Vælg fra galleri';

  @override
  String get imageTooBig => 'Billedet er for stort (maks. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Opløsningen er for høj (maks. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Ikke-understøttet billedformat';

  @override
  String get deleteTooltip => 'Slet';

  @override
  String get shareTooltip => 'Del';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Side $currentPage af $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Intet dokument indlæst';

  @override
  String get failedToLoadPdf => 'Kunne ikke indlæse PDF';

  @override
  String get passwordRequired => 'Adgangskode påkrævet';

  @override
  String get pdfPasswordProtected => 'Denne PDF er beskyttet med adgangskode.';

  @override
  String errorWithMessage(String message) {
    return 'Fejl: $message';
  }

  @override
  String get unsavedChangesTitle => 'Ikke-gemte ændringer';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Vil du gemme ændringerne i \"$fileName\"?';
  }
}
