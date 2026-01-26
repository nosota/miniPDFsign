// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get openPdf => 'PDF öffnen';

  @override
  String get selectPdf => 'PDF auswählen';

  @override
  String get recentFiles => 'Zuletzt verwendet';

  @override
  String get removeFromList => 'Aus Liste entfernen';

  @override
  String get openedNow => 'Gerade geöffnet';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Minuten',
      one: 'Minute',
    );
    return 'Vor $count $_temp0 geöffnet';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Stunden',
      one: 'Stunde',
    );
    return 'Vor $count $_temp0 geöffnet';
  }

  @override
  String get openedYesterday => 'Gestern geöffnet';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tagen',
      one: 'Tag',
    );
    return 'Vor $count $_temp0 geöffnet';
  }

  @override
  String get fileNotFound => 'Datei nicht gefunden';

  @override
  String get fileAccessDenied => 'Zugriff verweigert';

  @override
  String get clearRecentFiles => 'Zuletzt verwendet löschen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get error => 'Fehler';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Ablage';

  @override
  String get menuOpen => 'Öffnen...';

  @override
  String get menuOpenRecent => 'Zuletzt verwendet';

  @override
  String get menuNoRecentFiles => 'Keine zuletzt verwendeten Dateien';

  @override
  String get menuClearMenu => 'Menü löschen';

  @override
  String get menuSave => 'Sichern';

  @override
  String get menuSaveAs => 'Sichern unter...';

  @override
  String get menuSaveAll => 'Alle speichern';

  @override
  String get menuShare => 'Teilen...';

  @override
  String get menuCloseWindow => 'Fenster schließen';

  @override
  String get menuCloseAll => 'Alle schließen';

  @override
  String get menuQuit => 'PDFSign beenden';

  @override
  String get closeAllDialogTitle => 'Änderungen speichern?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Möchten Sie die Änderungen in $count Dokumenten vor dem Schließen speichern?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Möchten Sie die Änderungen in 1 Dokument vor dem Schließen speichern?';

  @override
  String get closeAllDialogSaveAll => 'Alle speichern';

  @override
  String get closeAllDialogDontSave => 'Nicht speichern';

  @override
  String get closeAllDialogCancel => 'Abbrechen';

  @override
  String get saveFailedDialogTitle => 'Speichern fehlgeschlagen';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count Dokument(e) konnten nicht gespeichert werden. Trotzdem schließen?';
  }

  @override
  String get saveFailedDialogClose => 'Trotzdem schließen';

  @override
  String get saveChangesTitle => 'Änderungen sichern?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Möchten Sie die Änderungen in \"$fileName\" vor dem Schließen sichern?';
  }

  @override
  String get saveButton => 'Sichern';

  @override
  String get discardButton => 'Nicht sichern';

  @override
  String get documentEdited => 'Bearbeitet';

  @override
  String get documentSaved => 'Gesichert';

  @override
  String get menuSettings => 'Einstellungen...';

  @override
  String get menuWindow => 'Fenster';

  @override
  String get menuMinimize => 'Minimieren';

  @override
  String get menuZoom => 'Zoomen';

  @override
  String get menuBringAllToFront => 'Alle nach vorne bringen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsLanguageSystem => 'Systemstandard';

  @override
  String get settingsUnits => 'Einheiten';

  @override
  String get settingsUnitsCentimeters => 'Zentimeter';

  @override
  String get settingsUnitsInches => 'Zoll';

  @override
  String get settingsSearchLanguages => 'Sprachen suchen...';

  @override
  String get settingsGeneral => 'Allgemein';

  @override
  String get addImage => 'Bild hinzufügen';

  @override
  String get selectImages => 'Bilder auswählen';

  @override
  String get zoomFitWidth => 'Breite anpassen';

  @override
  String get zoomIn => 'Vergrößern';

  @override
  String get zoomOut => 'Verkleinern';

  @override
  String get selectZoomLevel => 'Zoomstufe auswählen';

  @override
  String get goToPage => 'Gehe zu Seite';

  @override
  String get go => 'Los';

  @override
  String get savePdfAs => 'PDF speichern unter';

  @override
  String get incorrectPassword => 'Falsches Passwort';

  @override
  String get saveFailed => 'Speichern fehlgeschlagen';

  @override
  String savedTo(String path) {
    return 'Gespeichert unter: $path';
  }

  @override
  String get noOriginalPdfStored => 'Kein Original-PDF gespeichert';

  @override
  String get waitingForFolderPermission =>
      'Warten auf Ordnerzugriffsberechtigung...';

  @override
  String get emptyRecentFiles => 'Öffnen Sie eine PDF, um zu beginnen';

  @override
  String get imagesTitle => 'Bilder';

  @override
  String get noImagesYet => 'Noch keine Bilder';

  @override
  String get noImagesHint => 'Tippen Sie +, um Ihr erstes Bild hinzuzufügen';

  @override
  String get done => 'Fertig';

  @override
  String get menuEdit => 'Bearbeiten';
}
