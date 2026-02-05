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
  String get selectPdf => 'Datei öffnen';

  @override
  String get untitledDocument => 'Unbenannt.pdf';

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
  String get settingsUnitsDefault => 'Standard (nach Region)';

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
  String get emptyRecentFiles => 'Öffnen Sie eine Datei, um zu beginnen';

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

  @override
  String get chooseFromFiles => 'Aus Dateien wählen';

  @override
  String get chooseFromGallery => 'Aus Galerie wählen';

  @override
  String get imageTooBig => 'Bild ist zu groß (max. 50 MB)';

  @override
  String get imageResolutionTooHigh => 'Auflösung ist zu hoch (max. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Nicht unterstütztes Bildformat';

  @override
  String get deleteTooltip => 'Löschen';

  @override
  String get shareTooltip => 'Teilen';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Seite $currentPage von $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Kein Dokument geladen';

  @override
  String get failedToLoadPdf => 'PDF konnte nicht geladen werden';

  @override
  String get passwordRequired => 'Passwort erforderlich';

  @override
  String get pdfPasswordProtected => 'Dieses PDF ist passwortgeschützt.';

  @override
  String errorWithMessage(String message) {
    return 'Fehler: $message';
  }

  @override
  String get unsavedChangesTitle => 'Ungespeicherte Änderungen';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Möchten Sie die Änderungen an \"$fileName\" speichern?';
  }

  @override
  String get onboardingOpenPdf => 'Tippen, um ein PDF-Dokument zu öffnen';

  @override
  String get onboardingSwipeUp =>
      'Nach oben wischen, um Unterschriften und Stempel hinzuzufügen';

  @override
  String get onboardingAddImage =>
      'Tippen, um Ihre erste Unterschrift oder Ihren Stempel hinzuzufügen';

  @override
  String get onboardingDragImage => 'Auf das PDF ziehen, um es zu platzieren';

  @override
  String get onboardingResizeObject =>
      'Tippen zum Auswählen. Ecken ziehen zum Ändern der Größe.';

  @override
  String get onboardingDeleteImage =>
      'Tippen, um das ausgewählte Bild zu löschen';

  @override
  String get onboardingTapToContinue => 'Tippen Sie irgendwo, um fortzufahren';

  @override
  String get imageConversionFailed =>
      'Bild konnte nicht in PDF konvertiert werden';

  @override
  String get saveDocumentTitle => 'Dokument speichern';

  @override
  String get fileNameLabel => 'Dateiname';

  @override
  String get defaultFileName => 'Dokument';

  @override
  String get onlyOnePdfAllowed =>
      'Es kann nur eine PDF-Datei gleichzeitig geöffnet werden';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF-Dateien wurden ignoriert. Nur Bilder werden konvertiert.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bilder',
      one: 'Bild',
    );
    return 'Konvertiere $count $_temp0...';
  }

  @override
  String get takePhoto => 'Foto aufnehmen';

  @override
  String get removeBackgroundTitle => 'Hintergrund entfernen?';

  @override
  String get removeBackgroundMessage =>
      'Ein einheitlicher Hintergrund wurde erkannt. Möchten Sie ihn transparent machen?';

  @override
  String get removeBackground => 'Entfernen';

  @override
  String get keepOriginal => 'Behalten';

  @override
  String get processingImage => 'Bild wird verarbeitet...';

  @override
  String get backgroundRemovalFailed =>
      'Hintergrund konnte nicht entfernt werden';
}
