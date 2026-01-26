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
  String get selectPdf => 'PDF kiválasztása';

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
  String get emptyRecentFiles => 'Nyisson meg egy PDF-et a kezdéshez';

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
}
