// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get openPdf => 'Apri PDF';

  @override
  String get selectPdf => 'Seleziona PDF';

  @override
  String get recentFiles => 'File recenti';

  @override
  String get removeFromList => 'Rimuovi dalla lista';

  @override
  String get openedNow => 'Aperto ora';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minuti',
      one: 'minuto',
    );
    return 'Aperto $count $_temp0 fa';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ore',
      one: 'ora',
    );
    return 'Aperto $count $_temp0 fa';
  }

  @override
  String get openedYesterday => 'Aperto ieri';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'giorni',
      one: 'giorno',
    );
    return 'Aperto $count $_temp0 fa';
  }

  @override
  String get fileNotFound => 'File non trovato';

  @override
  String get fileAccessDenied => 'Accesso negato';

  @override
  String get clearRecentFiles => 'Cancella file recenti';

  @override
  String get cancel => 'Annulla';

  @override
  String get confirm => 'Conferma';

  @override
  String get error => 'Errore';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Apri...';

  @override
  String get menuOpenRecent => 'Apri recenti';

  @override
  String get menuNoRecentFiles => 'Nessun file recente';

  @override
  String get menuClearMenu => 'Cancella menu';

  @override
  String get menuSave => 'Salva';

  @override
  String get menuSaveAs => 'Salva come...';

  @override
  String get menuSaveAll => 'Salva tutto';

  @override
  String get menuShare => 'Condividi...';

  @override
  String get menuCloseWindow => 'Chiudi finestra';

  @override
  String get menuCloseAll => 'Chiudi tutto';

  @override
  String get menuQuit => 'Esci da PDFSign';

  @override
  String get closeAllDialogTitle => 'Salvare le modifiche?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Vuoi salvare le modifiche a $count documenti prima di chiudere?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Vuoi salvare le modifiche a 1 documento prima di chiudere?';

  @override
  String get closeAllDialogSaveAll => 'Salva tutto';

  @override
  String get closeAllDialogDontSave => 'Non salvare';

  @override
  String get closeAllDialogCancel => 'Annulla';

  @override
  String get saveFailedDialogTitle => 'Salvataggio non riuscito';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Impossibile salvare $count documento(i). Chiudere comunque?';
  }

  @override
  String get saveFailedDialogClose => 'Chiudi comunque';

  @override
  String get saveChangesTitle => 'Salvare le modifiche?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Vuoi salvare le modifiche in \"$fileName\" prima di chiudere?';
  }

  @override
  String get saveButton => 'Salva';

  @override
  String get discardButton => 'Non salvare';

  @override
  String get documentEdited => 'Modificato';

  @override
  String get documentSaved => 'Salvato';

  @override
  String get menuSettings => 'Impostazioni...';

  @override
  String get menuWindow => 'Finestra';

  @override
  String get menuMinimize => 'Contrai';

  @override
  String get menuZoom => 'Ridimensiona';

  @override
  String get menuBringAllToFront => 'Porta tutto in primo piano';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsLanguage => 'Lingua';

  @override
  String get settingsLanguageSystem => 'Predefinito di sistema';

  @override
  String get settingsUnits => 'Unità';

  @override
  String get settingsUnitsCentimeters => 'Centimetri';

  @override
  String get settingsUnitsInches => 'Pollici';

  @override
  String get settingsSearchLanguages => 'Cerca lingue...';

  @override
  String get settingsGeneral => 'Generale';

  @override
  String get addImage => 'Aggiungi immagine';

  @override
  String get selectImages => 'Seleziona immagini';

  @override
  String get zoomFitWidth => 'Adatta larghezza';

  @override
  String get zoomIn => 'Ingrandisci';

  @override
  String get zoomOut => 'Riduci';

  @override
  String get selectZoomLevel => 'Seleziona livello di zoom';

  @override
  String get goToPage => 'Vai alla pagina';

  @override
  String get go => 'Vai';

  @override
  String get savePdfAs => 'Salva PDF come';

  @override
  String get incorrectPassword => 'Password errata';

  @override
  String get saveFailed => 'Salvataggio fallito';

  @override
  String savedTo(String path) {
    return 'Salvato in: $path';
  }

  @override
  String get noOriginalPdfStored => 'Nessun PDF originale memorizzato';

  @override
  String get waitingForFolderPermission =>
      'In attesa dell\'autorizzazione di accesso alla cartella...';

  @override
  String get emptyRecentFiles => 'Apri un PDF per iniziare';

  @override
  String get imagesTitle => 'Immagini';

  @override
  String get noImagesYet => 'Nessuna immagine';

  @override
  String get noImagesHint =>
      'Tocca + per aggiungere il tuo primo timbro o firma';

  @override
  String get done => 'Fine';

  @override
  String get menuEdit => 'Modifica';

  @override
  String get chooseFromFiles => 'Scegli dai file';

  @override
  String get chooseFromGallery => 'Scegli dalla galleria';

  @override
  String get imageTooBig => 'L\'immagine è troppo grande (max 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'La risoluzione è troppo alta (max 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Formato immagine non supportato';
}
