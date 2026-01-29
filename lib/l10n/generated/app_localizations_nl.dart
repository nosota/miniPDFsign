// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get openPdf => 'PDF openen';

  @override
  String get selectPdf => 'PDF selecteren';

  @override
  String get recentFiles => 'Recente bestanden';

  @override
  String get removeFromList => 'Verwijderen uit lijst';

  @override
  String get openedNow => 'Zojuist geopend';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minuten',
      one: 'minuut',
    );
    return '$count $_temp0 geleden geopend';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'uur',
      one: 'uur',
    );
    return '$count $_temp0 geleden geopend';
  }

  @override
  String get openedYesterday => 'Gisteren geopend';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dagen',
      one: 'dag',
    );
    return '$count $_temp0 geleden geopend';
  }

  @override
  String get fileNotFound => 'Bestand niet gevonden';

  @override
  String get fileAccessDenied => 'Toegang geweigerd';

  @override
  String get clearRecentFiles => 'Recente bestanden wissen';

  @override
  String get cancel => 'Annuleer';

  @override
  String get confirm => 'Bevestig';

  @override
  String get error => 'Fout';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Archief';

  @override
  String get menuOpen => 'Open...';

  @override
  String get menuOpenRecent => 'Open recente';

  @override
  String get menuNoRecentFiles => 'Geen recente bestanden';

  @override
  String get menuClearMenu => 'Wis menu';

  @override
  String get menuSave => 'Bewaar';

  @override
  String get menuSaveAs => 'Bewaar als...';

  @override
  String get menuSaveAll => 'Alles opslaan';

  @override
  String get menuShare => 'Deel...';

  @override
  String get menuCloseWindow => 'Sluit venster';

  @override
  String get menuCloseAll => 'Alles sluiten';

  @override
  String get menuQuit => 'Stop PDFSign';

  @override
  String get closeAllDialogTitle => 'Wijzigingen opslaan?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Wilt u de wijzigingen in $count documenten opslaan voordat u sluit?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Wilt u de wijzigingen in 1 document opslaan voordat u sluit?';

  @override
  String get closeAllDialogSaveAll => 'Alles opslaan';

  @override
  String get closeAllDialogDontSave => 'Niet opslaan';

  @override
  String get closeAllDialogCancel => 'Annuleren';

  @override
  String get saveFailedDialogTitle => 'Opslaan mislukt';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Kon $count document(en) niet opslaan. Toch sluiten?';
  }

  @override
  String get saveFailedDialogClose => 'Toch sluiten';

  @override
  String get saveChangesTitle => 'Wijzigingen bewaren?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Wilt u de wijzigingen in \"$fileName\" bewaren voordat u sluit?';
  }

  @override
  String get saveButton => 'Bewaar';

  @override
  String get discardButton => 'Niet bewaren';

  @override
  String get documentEdited => 'Bewerkt';

  @override
  String get documentSaved => 'Bewaard';

  @override
  String get menuSettings => 'Instellingen...';

  @override
  String get menuWindow => 'Venster';

  @override
  String get menuMinimize => 'Minimaliseer';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Breng alles naar voren';

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get settingsLanguage => 'Taal';

  @override
  String get settingsLanguageSystem => 'Systeemstandaard';

  @override
  String get settingsUnits => 'Eenheden';

  @override
  String get settingsUnitsCentimeters => 'Centimeters';

  @override
  String get settingsUnitsInches => 'Inches';

  @override
  String get settingsSearchLanguages => 'Talen zoeken...';

  @override
  String get settingsGeneral => 'Algemeen';

  @override
  String get addImage => 'Afbeelding toevoegen';

  @override
  String get selectImages => 'Afbeeldingen selecteren';

  @override
  String get zoomFitWidth => 'Breedte aanpassen';

  @override
  String get zoomIn => 'Inzoomen';

  @override
  String get zoomOut => 'Uitzoomen';

  @override
  String get selectZoomLevel => 'Zoomniveau selecteren';

  @override
  String get goToPage => 'Ga naar pagina';

  @override
  String get go => 'Ga';

  @override
  String get savePdfAs => 'PDF opslaan als';

  @override
  String get incorrectPassword => 'Onjuist wachtwoord';

  @override
  String get saveFailed => 'Opslaan mislukt';

  @override
  String savedTo(String path) {
    return 'Opgeslagen naar: $path';
  }

  @override
  String get noOriginalPdfStored => 'Geen originele PDF opgeslagen';

  @override
  String get waitingForFolderPermission =>
      'Wachten op toestemming voor maptoegang...';

  @override
  String get emptyRecentFiles => 'Open een PDF om te beginnen';

  @override
  String get imagesTitle => 'Afbeeldingen';

  @override
  String get noImagesYet => 'Nog geen afbeeldingen';

  @override
  String get noImagesHint =>
      'Tik op + om je eerste stempel of handtekening toe te voegen';

  @override
  String get done => 'Klaar';

  @override
  String get menuEdit => 'Bewerken';

  @override
  String get chooseFromFiles => 'Kies uit bestanden';

  @override
  String get chooseFromGallery => 'Kies uit galerij';

  @override
  String get imageTooBig => 'Afbeelding is te groot (max. 50 MB)';

  @override
  String get imageResolutionTooHigh => 'Resolutie is te hoog (max. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Niet-ondersteund afbeeldingsformaat';

  @override
  String get deleteTooltip => 'Verwijderen';

  @override
  String get shareTooltip => 'Delen';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Pagina $currentPage van $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Geen document geladen';

  @override
  String get failedToLoadPdf => 'Kan PDF niet laden';

  @override
  String get passwordRequired => 'Wachtwoord vereist';

  @override
  String get pdfPasswordProtected =>
      'Deze PDF is beveiligd met een wachtwoord.';

  @override
  String errorWithMessage(String message) {
    return 'Fout: $message';
  }

  @override
  String get unsavedChangesTitle => 'Niet-opgeslagen wijzigingen';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Wilt u de wijzigingen in \"$fileName\" opslaan?';
  }
}
