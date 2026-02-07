// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get openPdf => 'PDF megnyitása';

  @override
  String get selectPdf => 'Fájl megnyitása';

  @override
  String get untitledDocument => 'Névtelen.pdf';

  @override
  String get recentFiles => 'Legutóbbi fájlok';

  @override
  String get removeFromList => 'Eltávolítás a listáról';

  @override
  String get openedNow => 'Most megnyitva';

  @override
  String openedMinutesAgo(int count) {
    return '$count perccel ezelőtt megnyitva';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count órával ezelőtt megnyitva';
  }

  @override
  String get openedYesterday => 'Tegnap megnyitva';

  @override
  String openedDaysAgo(int count) {
    return '$count nappal ezelőtt megnyitva';
  }

  @override
  String get fileNotFound => 'A fájl nem található';

  @override
  String get fileAccessDenied => 'Hozzáférés megtagadva';

  @override
  String get clearRecentFiles => 'Legutóbbi fájlok törlése';

  @override
  String get cancel => 'Mégse';

  @override
  String get confirm => 'Megerősítés';

  @override
  String get error => 'Hiba';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fájl';

  @override
  String get menuOpen => 'Megnyitás...';

  @override
  String get menuOpenRecent => 'Legutóbbiak megnyitása';

  @override
  String get menuNoRecentFiles => 'Nincsenek legutóbbi fájlok';

  @override
  String get menuClearMenu => 'Menü törlése';

  @override
  String get menuSave => 'Mentés';

  @override
  String get menuSaveAs => 'Mentés másként...';

  @override
  String get menuSaveAll => 'Összes mentése';

  @override
  String get menuShare => 'Megosztás...';

  @override
  String get menuCloseWindow => 'Ablak bezárása';

  @override
  String get menuCloseAll => 'Összes bezárása';

  @override
  String get menuQuit => 'PDFSign bezárása';

  @override
  String get closeAllDialogTitle => 'Változások mentése?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Szeretné menteni a változtatásokat $count dokumentumban bezárás előtt?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Szeretné menteni a változtatásokat 1 dokumentumban bezárás előtt?';

  @override
  String get closeAllDialogSaveAll => 'Összes mentése';

  @override
  String get closeAllDialogDontSave => 'Ne mentse';

  @override
  String get closeAllDialogCancel => 'Mégse';

  @override
  String get saveFailedDialogTitle => 'Mentés sikertelen';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count dokumentum mentése sikertelen. Mégis bezárja?';
  }

  @override
  String get saveFailedDialogClose => 'Mégis bezár';

  @override
  String get saveChangesTitle => 'Változások mentése?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Szeretné menteni a \"$fileName\" fájlban végzett változtatásokat bezárás előtt?';
  }

  @override
  String get saveButton => 'Mentés';

  @override
  String get discardButton => 'Elvetés';

  @override
  String get documentEdited => 'Szerkesztve';

  @override
  String get documentSaved => 'Mentve';

  @override
  String get menuSettings => 'Beállítások...';

  @override
  String get menuWindow => 'Ablak';

  @override
  String get menuMinimize => 'Kis méret';

  @override
  String get menuZoom => 'Nagyítás';

  @override
  String get menuBringAllToFront => 'Összes előtérbe hozása';

  @override
  String get settingsTitle => 'Beállítások';

  @override
  String get settingsLanguage => 'Nyelv';

  @override
  String get settingsLanguageSystem => 'Rendszer alapértelmezett';

  @override
  String get settingsUnits => 'Mértékegységek';

  @override
  String get settingsUnitsCentimeters => 'Centiméter';

  @override
  String get settingsUnitsInches => 'Hüvelyk';

  @override
  String get settingsUnitsDefault => 'Alapértelmezett (régió szerint)';

  @override
  String get settingsSearchLanguages => 'Nyelvek keresése...';

  @override
  String get settingsGeneral => 'Általános';

  @override
  String get addImage => 'Kép hozzáadása';

  @override
  String get selectImages => 'Képek kiválasztása';

  @override
  String get zoomFitWidth => 'Szélesség illesztése';

  @override
  String get zoomIn => 'Nagyítás';

  @override
  String get zoomOut => 'Kicsinyítés';

  @override
  String get selectZoomLevel => 'Nagyítási szint kiválasztása';

  @override
  String get goToPage => 'Ugrás oldalra';

  @override
  String get go => 'Ugrás';

  @override
  String get savePdfAs => 'PDF mentése másként';

  @override
  String get incorrectPassword => 'Helytelen jelszó';

  @override
  String get saveFailed => 'Mentés sikertelen';

  @override
  String savedTo(String path) {
    return 'Mentve ide: $path';
  }

  @override
  String get noOriginalPdfStored => 'Nincs eredeti PDF tárolva';

  @override
  String get waitingForFolderPermission =>
      'Várakozás a mappa hozzáférési engedélyére...';

  @override
  String get emptyRecentFiles => 'Nyisson meg egy fájlt a kezdéshez';

  @override
  String get imagesTitle => 'Képek';

  @override
  String get noImagesYet => 'Még nincsenek képek';

  @override
  String get noImagesHint =>
      'Érintse meg a + gombot az első pecsét vagy aláírás hozzáadásához';

  @override
  String get done => 'Kész';

  @override
  String get menuEdit => 'Szerkesztés';

  @override
  String get chooseFromFiles => 'Választás fájlokból';

  @override
  String get chooseFromGallery => 'Választás galériából';

  @override
  String get imageTooBig => 'A kép túl nagy (max. 50 MB)';

  @override
  String get imageResolutionTooHigh => 'A felbontás túl magas (max. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Nem támogatott képformátum';

  @override
  String get deleteTooltip => 'Törlés';

  @override
  String get shareTooltip => 'Megosztás';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return '$currentPage. oldal / $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Nincs dokumentum betöltve';

  @override
  String get failedToLoadPdf => 'A PDF betöltése sikertelen';

  @override
  String get passwordRequired => 'Jelszó szükséges';

  @override
  String get pdfPasswordProtected => 'Ez a PDF jelszóval védett.';

  @override
  String errorWithMessage(String message) {
    return 'Hiba: $message';
  }

  @override
  String get unsavedChangesTitle => 'Mentetlen változások';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Szeretné menteni a változtatásokat a(z) \"$fileName\" fájlban?';
  }

  @override
  String get onboardingOpenPdf => 'Koppintson egy PDF dokumentum megnyitásához';

  @override
  String get onboardingSwipeUp =>
      'Húzzon felfelé aláírások és pecsétek hozzáadásához';

  @override
  String get onboardingAddImage =>
      'Koppintson az első aláírás vagy pecsét hozzáadásához';

  @override
  String get onboardingDragImage => 'Húzza a PDF-re az elhelyezéshez';

  @override
  String get onboardingResizeObject =>
      'Koppintson a kiválasztáshoz. Húzza a sarkokat az átméretezéshez.';

  @override
  String get onboardingDeleteImage =>
      'Érintse meg a kiválasztott kép törléséhez';

  @override
  String get onboardingTapToContinue => 'Koppintson bárhová a folytatáshoz';

  @override
  String get imageConversionFailed =>
      'Nem sikerült a képet PDF formátumba konvertálni';

  @override
  String get saveDocumentTitle => 'Dokumentum mentése';

  @override
  String get fileNameLabel => 'Fájlnév';

  @override
  String get defaultFileName => 'Dokumentum';

  @override
  String get onlyOnePdfAllowed => 'Egyszerre csak egy PDF nyitható meg';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'A PDF fájlok figyelmen kívül lettek hagyva. Csak a képek konvertálódnak.';

  @override
  String convertingImages(int count) {
    return '$count kép konvertálása...';
  }

  @override
  String get takePhoto => 'Fotó készítése';

  @override
  String get removeBackgroundTitle => 'Háttér eltávolítása?';

  @override
  String get removeBackgroundMessage =>
      'Szeretné eltávolítani a hátteret és átlátszóvá tenni?';

  @override
  String get removeBackground => 'Eltávolítás';

  @override
  String get keepOriginal => 'Megtartás';

  @override
  String get processingImage => 'Kép feldolgozása...';

  @override
  String get backgroundRemovalFailed => 'A háttér eltávolítása sikertelen';

  @override
  String get passwordLabel => 'Jelszó';

  @override
  String get unlockButton => 'Feloldás';
}
