// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get openPdf => 'Otevřít PDF';

  @override
  String get selectPdf => 'Otevřít soubor';

  @override
  String get untitledDocument => 'Bez názvu.pdf';

  @override
  String get recentFiles => 'Nedávné soubory';

  @override
  String get removeFromList => 'Odebrat ze seznamu';

  @override
  String get openedNow => 'Právě otevřeno';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutami',
      few: 'minutami',
      one: 'minutou',
    );
    return 'Otevřeno před $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hodinami',
      few: 'hodinami',
      one: 'hodinou',
    );
    return 'Otevřeno před $count $_temp0';
  }

  @override
  String get openedYesterday => 'Otevřeno včera';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dny',
      few: 'dny',
      one: 'dnem',
    );
    return 'Otevřeno před $count $_temp0';
  }

  @override
  String get fileNotFound => 'Soubor nenalezen';

  @override
  String get fileAccessDenied => 'Přístup odepřen';

  @override
  String get clearRecentFiles => 'Vymazat nedávné soubory';

  @override
  String get cancel => 'Zrušit';

  @override
  String get confirm => 'Potvrdit';

  @override
  String get error => 'Chyba';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Soubor';

  @override
  String get menuOpen => 'Otevřít...';

  @override
  String get menuOpenRecent => 'Otevřít nedávné';

  @override
  String get menuNoRecentFiles => 'Žádné nedávné soubory';

  @override
  String get menuClearMenu => 'Vymazat nabídku';

  @override
  String get menuSave => 'Uložit';

  @override
  String get menuSaveAs => 'Uložit jako...';

  @override
  String get menuSaveAll => 'Uložit vše';

  @override
  String get menuShare => 'Sdílet...';

  @override
  String get menuCloseWindow => 'Zavřít okno';

  @override
  String get menuCloseAll => 'Zavřít vše';

  @override
  String get menuQuit => 'Ukončit PDFSign';

  @override
  String get closeAllDialogTitle => 'Uložit změny?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Chcete uložit změny v $count dokumentech před zavřením?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Chcete uložit změny v 1 dokumentu před zavřením?';

  @override
  String get closeAllDialogSaveAll => 'Uložit vše';

  @override
  String get closeAllDialogDontSave => 'Neukládat';

  @override
  String get closeAllDialogCancel => 'Zrušit';

  @override
  String get saveFailedDialogTitle => 'Uložení se nezdařilo';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Nepodařilo se uložit $count dokument(ů). Přesto zavřít?';
  }

  @override
  String get saveFailedDialogClose => 'Přesto zavřít';

  @override
  String get saveChangesTitle => 'Uložit změny?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Chcete uložit změny v \"$fileName\" před zavřením?';
  }

  @override
  String get saveButton => 'Uložit';

  @override
  String get discardButton => 'Neukládat';

  @override
  String get documentEdited => 'Upraveno';

  @override
  String get documentSaved => 'Uloženo';

  @override
  String get menuSettings => 'Nastavení...';

  @override
  String get menuWindow => 'Okno';

  @override
  String get menuMinimize => 'Minimalizovat';

  @override
  String get menuZoom => 'Zvětšit';

  @override
  String get menuBringAllToFront => 'Přenést vše dopředu';

  @override
  String get settingsTitle => 'Nastavení';

  @override
  String get settingsLanguage => 'Jazyk';

  @override
  String get settingsLanguageSystem => 'Výchozí systémový';

  @override
  String get settingsUnits => 'Jednotky';

  @override
  String get settingsUnitsCentimeters => 'Centimetry';

  @override
  String get settingsUnitsInches => 'Palce';

  @override
  String get settingsUnitsDefault => 'Výchozí (podle regionu)';

  @override
  String get settingsSearchLanguages => 'Hledat jazyky...';

  @override
  String get settingsGeneral => 'Obecné';

  @override
  String get addImage => 'Přidat obrázek';

  @override
  String get selectImages => 'Vybrat obrázky';

  @override
  String get zoomFitWidth => 'Přizpůsobit šířce';

  @override
  String get zoomIn => 'Přiblížit';

  @override
  String get zoomOut => 'Oddálit';

  @override
  String get selectZoomLevel => 'Vybrat úroveň přiblížení';

  @override
  String get goToPage => 'Přejít na stránku';

  @override
  String get go => 'Přejít';

  @override
  String get savePdfAs => 'Uložit PDF jako';

  @override
  String get incorrectPassword => 'Nesprávné heslo';

  @override
  String get saveFailed => 'Uložení selhalo';

  @override
  String savedTo(String path) {
    return 'Uloženo do: $path';
  }

  @override
  String get noOriginalPdfStored => 'Žádné původní PDF není uloženo';

  @override
  String get waitingForFolderPermission =>
      'Čekání na povolení přístupu ke složce...';

  @override
  String get emptyRecentFiles => 'Otevřete soubor a začněte';

  @override
  String get imagesTitle => 'Obrázky';

  @override
  String get noImagesYet => 'Zatím žádné obrázky';

  @override
  String get noImagesHint =>
      'Klepnutím na + přidejte první razítko nebo podpis';

  @override
  String get done => 'Hotovo';

  @override
  String get menuEdit => 'Upravit';

  @override
  String get chooseFromFiles => 'Vybrat ze souborů';

  @override
  String get chooseFromGallery => 'Vybrat z galerie';

  @override
  String get imageTooBig => 'Obrázek je příliš velký (max. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Rozlišení je příliš vysoké (max. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Nepodporovaný formát obrázku';

  @override
  String get deleteTooltip => 'Smazat';

  @override
  String get shareTooltip => 'Sdílet';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Stránka $currentPage z $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Žádný dokument není načten';

  @override
  String get failedToLoadPdf => 'Nepodařilo se načíst PDF';

  @override
  String get passwordRequired => 'Vyžadováno heslo';

  @override
  String get pdfPasswordProtected => 'Tento PDF je chráněn heslem.';

  @override
  String errorWithMessage(String message) {
    return 'Chyba: $message';
  }

  @override
  String get unsavedChangesTitle => 'Neuložené změny';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Chcete uložit změny v \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Klepněte pro otevření PDF dokumentu';

  @override
  String get onboardingSwipeUp =>
      'Přejeďte nahoru pro přidání podpisů a razítek';

  @override
  String get onboardingAddImage =>
      'Klepněte pro přidání prvního podpisu nebo razítka';

  @override
  String get onboardingDragImage => 'Přetáhněte na PDF pro umístění';

  @override
  String get onboardingResizeObject =>
      'Klepněte pro výběr. Přetáhněte rohy pro změnu velikosti.';

  @override
  String get onboardingDeleteImage => 'Klepnutím smažete vybraný obrázek';

  @override
  String get onboardingTapToContinue => 'Klepněte kamkoliv pro pokračování';

  @override
  String get imageConversionFailed => 'Nepodařilo se převést obrázek na PDF';

  @override
  String get saveDocumentTitle => 'Uložit dokument';

  @override
  String get fileNameLabel => 'Název souboru';

  @override
  String get defaultFileName => 'Dokument';

  @override
  String get onlyOnePdfAllowed => 'Lze otevřít pouze jeden PDF soubor najednou';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF soubory byly ignorovány. Konvertují se pouze obrázky.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'obrázků',
      many: 'obrázků',
      few: 'obrázky',
      one: 'obrázek',
    );
    return 'Konvertuji $count $_temp0...';
  }

  @override
  String get takePhoto => 'Vyfotit';

  @override
  String get removeBackgroundTitle => 'Odstranit pozadí?';

  @override
  String get removeBackgroundMessage =>
      'Chcete odstranit pozadí a zprůhlednit ho?';

  @override
  String get removeBackground => 'Odstranit';

  @override
  String get keepOriginal => 'Ponechat';

  @override
  String get processingImage => 'Zpracování obrázku...';

  @override
  String get backgroundRemovalFailed => 'Odstranění pozadí se nezdařilo';

  @override
  String get passwordLabel => 'Heslo';

  @override
  String get unlockButton => 'Odemknout';
}
