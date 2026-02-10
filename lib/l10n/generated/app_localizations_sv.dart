// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get openPdf => 'Öppna PDF';

  @override
  String get selectPdf => 'Öppna fil';

  @override
  String get untitledDocument => 'Namnlös.pdf';

  @override
  String get recentFiles => 'Senaste filer';

  @override
  String get removeFromList => 'Ta bort från listan';

  @override
  String get openedNow => 'Nyss öppnad';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minuter',
      one: 'minut',
    );
    return 'Öppnad för $count $_temp0 sedan';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'timmar',
      one: 'timme',
    );
    return 'Öppnad för $count $_temp0 sedan';
  }

  @override
  String get openedYesterday => 'Öppnad igår';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dagar',
      one: 'dag',
    );
    return 'Öppnad för $count $_temp0 sedan';
  }

  @override
  String get fileNotFound => 'Filen hittades inte';

  @override
  String get fileAccessDenied => 'Åtkomst nekad';

  @override
  String get clearRecentFiles => 'Rensa senaste filer';

  @override
  String get cancel => 'Avbryt';

  @override
  String get confirm => 'Bekräfta';

  @override
  String get error => 'Fel';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Arkiv';

  @override
  String get menuOpen => 'Öppna...';

  @override
  String get menuOpenRecent => 'Öppna senaste';

  @override
  String get menuNoRecentFiles => 'Inga senaste filer';

  @override
  String get menuClearMenu => 'Rensa menyn';

  @override
  String get menuSave => 'Spara';

  @override
  String get menuSaveAs => 'Spara som...';

  @override
  String get menuSaveAll => 'Spara alla';

  @override
  String get menuShare => 'Dela...';

  @override
  String get menuCloseWindow => 'Stäng fönster';

  @override
  String get menuCloseAll => 'Stäng alla';

  @override
  String get menuQuit => 'Avsluta PDFSign';

  @override
  String get closeAllDialogTitle => 'Spara ändringar?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Vill du spara ändringar i $count dokument innan du stänger?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Vill du spara ändringar i 1 dokument innan du stänger?';

  @override
  String get closeAllDialogSaveAll => 'Spara alla';

  @override
  String get closeAllDialogDontSave => 'Spara inte';

  @override
  String get closeAllDialogCancel => 'Avbryt';

  @override
  String get saveFailedDialogTitle => 'Sparandet misslyckades';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Det gick inte att spara $count dokument. Stäng ändå?';
  }

  @override
  String get saveFailedDialogClose => 'Stäng ändå';

  @override
  String get saveChangesTitle => 'Spara ändringar?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Vill du spara ändringarna i \"$fileName\" innan du stänger?';
  }

  @override
  String get saveButton => 'Spara';

  @override
  String get discardButton => 'Spara inte';

  @override
  String get documentEdited => 'Redigerad';

  @override
  String get documentSaved => 'Sparad';

  @override
  String get menuSettings => 'Inställningar...';

  @override
  String get menuWindow => 'Fönster';

  @override
  String get menuMinimize => 'Minimera';

  @override
  String get menuZoom => 'Zooma';

  @override
  String get menuBringAllToFront => 'För alla framåt';

  @override
  String get settingsTitle => 'Inställningar';

  @override
  String get settingsLanguage => 'Språk';

  @override
  String get settingsLanguageSystem => 'Systemstandard';

  @override
  String get settingsUnits => 'Enheter';

  @override
  String get settingsUnitsCentimeters => 'Centimeter';

  @override
  String get settingsUnitsInches => 'Tum';

  @override
  String get settingsUnitsDefault => 'Standard (efter region)';

  @override
  String get settingsSearchLanguages => 'Sök språk...';

  @override
  String get settingsGeneral => 'Allmänt';

  @override
  String get addImage => 'Lägg till bild';

  @override
  String get selectImages => 'Välj bilder';

  @override
  String get zoomFitWidth => 'Anpassa bredd';

  @override
  String get zoomIn => 'Zooma in';

  @override
  String get zoomOut => 'Zooma ut';

  @override
  String get selectZoomLevel => 'Välj zoomnivå';

  @override
  String get goToPage => 'Gå till sida';

  @override
  String get go => 'Gå';

  @override
  String get savePdfAs => 'Spara PDF som';

  @override
  String get incorrectPassword => 'Felaktigt lösenord';

  @override
  String get saveFailed => 'Sparandet misslyckades';

  @override
  String savedTo(String path) {
    return 'Sparat till: $path';
  }

  @override
  String get noOriginalPdfStored => 'Ingen original-PDF sparad';

  @override
  String get waitingForFolderPermission =>
      'Väntar på åtkomstbehörighet för mapp...';

  @override
  String get emptyRecentFiles => 'Öppna en fil för att komma igång';

  @override
  String get imagesTitle => 'Bilder';

  @override
  String get noImagesYet => 'Inga bilder ännu';

  @override
  String get noImagesHint =>
      'Tryck på + för att lägga till din första stämpel eller signatur';

  @override
  String get done => 'Klar';

  @override
  String get menuEdit => 'Redigera';

  @override
  String get chooseFromFiles => 'Välj från filer';

  @override
  String get chooseFromGallery => 'Välj från galleri';

  @override
  String get imageTooBig => 'Bilden är för stor (max 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Upplösningen är för hög (max 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Bildformat stöds inte';

  @override
  String get deleteTooltip => 'Radera';

  @override
  String get shareTooltip => 'Dela';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Sida $currentPage av $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Inget dokument laddat';

  @override
  String get failedToLoadPdf => 'Kunde inte ladda PDF';

  @override
  String get passwordRequired => 'Lösenord krävs';

  @override
  String get pdfPasswordProtected => 'Denna PDF är lösenordsskyddad.';

  @override
  String errorWithMessage(String message) {
    return 'Fel: $message';
  }

  @override
  String get unsavedChangesTitle => 'Osparade ändringar';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Vill du spara ändringar i \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Tryck för att öppna ett PDF-dokument';

  @override
  String get onboardingSwipeUp =>
      'Svep uppåt för att lägga till signaturer och stämplar';

  @override
  String get onboardingAddImage =>
      'Tryck för att lägga till din första signatur eller stämpel';

  @override
  String get onboardingDragImage => 'Dra till PDF:en för att placera den';

  @override
  String get onboardingResizeObject =>
      'Tryck för att välja. Dra i hörnen för att ändra storlek.';

  @override
  String get onboardingDeleteImage => 'Tryck för att radera den valda bilden';

  @override
  String get onboardingTapToContinue => 'Tryck var som helst för att fortsätta';

  @override
  String get imageConversionFailed =>
      'Det gick inte att konvertera bilden till PDF';

  @override
  String get saveDocumentTitle => 'Spara dokument';

  @override
  String get fileNameLabel => 'Filnamn';

  @override
  String get defaultFileName => 'Dokument';

  @override
  String get onlyOnePdfAllowed => 'Endast en PDF kan öppnas åt gången';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF-filer ignorerades. Endast bilder konverteras.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'bilder',
      one: 'bild',
    );
    return 'Konverterar $count $_temp0...';
  }

  @override
  String get takePhoto => 'Ta foto';

  @override
  String get removeBackgroundTitle => 'Ta bort bakgrund?';

  @override
  String get removeBackgroundMessage =>
      'Vill du ta bort bakgrunden och göra den genomskinlig?';

  @override
  String get removeBackground => 'Ta bort';

  @override
  String get keepOriginal => 'Behåll';

  @override
  String get processingImage => 'Bearbetar bild...';

  @override
  String get backgroundRemovalFailed => 'Kunde inte ta bort bakgrund';

  @override
  String get passwordLabel => 'Lösenord';

  @override
  String get unlockButton => 'Lås upp';

  @override
  String get pasteFromClipboard => 'Klistra in från urklipp';

  @override
  String get noImageInClipboard =>
      'Ingen bild i urklipp. Kopiera en bild först.';

  @override
  String get imageDuplicated => 'Bild duplicerad';
}
