// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get openPdf => 'Obre PDF';

  @override
  String get selectPdf => 'Selecciona PDF';

  @override
  String get recentFiles => 'Fitxers recents';

  @override
  String get removeFromList => 'Elimina de la llista';

  @override
  String get openedNow => 'Obert ara mateix';

  @override
  String openedMinutesAgo(int count) {
    return 'Obert fa $count minuts';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Obert fa $count hores';
  }

  @override
  String get openedYesterday => 'Obert ahir';

  @override
  String openedDaysAgo(int count) {
    return 'Obert fa $count dies';
  }

  @override
  String get fileNotFound => 'Fitxer no trobat';

  @override
  String get fileAccessDenied => 'Acces denegat';

  @override
  String get clearRecentFiles => 'Neteja fitxers recents';

  @override
  String get cancel => 'Cancel·la';

  @override
  String get confirm => 'Confirma';

  @override
  String get error => 'Error';

  @override
  String get ok => 'D\'acord';

  @override
  String get menuFile => 'Fitxer';

  @override
  String get menuOpen => 'Obre...';

  @override
  String get menuOpenRecent => 'Obre recents';

  @override
  String get menuNoRecentFiles => 'Cap fitxer recent';

  @override
  String get menuClearMenu => 'Neteja el menu';

  @override
  String get menuSave => 'Desa';

  @override
  String get menuSaveAs => 'Anomena i desa...';

  @override
  String get menuSaveAll => 'Desa-ho tot';

  @override
  String get menuShare => 'Comparteix...';

  @override
  String get menuCloseWindow => 'Tanca la finestra';

  @override
  String get menuCloseAll => 'Tanca-ho tot';

  @override
  String get menuQuit => 'Sortir de PDFSign';

  @override
  String get closeAllDialogTitle => 'Desar els canvis?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Vols desar els canvis a $count documents abans de tancar?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Vols desar els canvis a 1 document abans de tancar?';

  @override
  String get closeAllDialogSaveAll => 'Desa-ho tot';

  @override
  String get closeAllDialogDontSave => 'No desis';

  @override
  String get closeAllDialogCancel => 'Cancel·la';

  @override
  String get saveFailedDialogTitle => 'Error en desar';

  @override
  String saveFailedDialogMessage(int count) {
    return 'No s\'han pogut desar $count document(s). Tancar igualment?';
  }

  @override
  String get saveFailedDialogClose => 'Tanca igualment';

  @override
  String get saveChangesTitle => 'Desar els canvis?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Vols desar els canvis a \"$fileName\" abans de tancar?';
  }

  @override
  String get saveButton => 'Desa';

  @override
  String get discardButton => 'No desis';

  @override
  String get documentEdited => 'Editat';

  @override
  String get documentSaved => 'Desat';

  @override
  String get menuSettings => 'Configuracio...';

  @override
  String get menuWindow => 'Finestra';

  @override
  String get menuMinimize => 'Minimitza';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Porta-ho tot al davant';

  @override
  String get settingsTitle => 'Configuracio';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Per defecte del sistema';

  @override
  String get settingsUnits => 'Unitats';

  @override
  String get settingsUnitsCentimeters => 'Centimetres';

  @override
  String get settingsUnitsInches => 'Polzades';

  @override
  String get settingsSearchLanguages => 'Cercar idiomes...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Afegeix imatge';

  @override
  String get selectImages => 'Selecciona imatges';

  @override
  String get zoomFitWidth => 'Ajusta a l\'amplada';

  @override
  String get zoomIn => 'Apropa';

  @override
  String get zoomOut => 'Allunya';

  @override
  String get selectZoomLevel => 'Selecciona nivell de zoom';

  @override
  String get goToPage => 'Vés a la pàgina';

  @override
  String get go => 'Vés';

  @override
  String get savePdfAs => 'Desa PDF com';

  @override
  String get incorrectPassword => 'Contrasenya incorrecta';

  @override
  String get saveFailed => 'Error en desar';

  @override
  String savedTo(String path) {
    return 'Desat a: $path';
  }

  @override
  String get noOriginalPdfStored => 'No hi ha PDF original emmagatzemat';

  @override
  String get waitingForFolderPermission =>
      'Esperant permís d\'accés a la carpeta...';

  @override
  String get emptyRecentFiles => 'Obre un PDF per començar';

  @override
  String get imagesTitle => 'Imatges';

  @override
  String get noImagesYet => 'Encara no hi ha imatges';

  @override
  String get noImagesHint =>
      'Toqueu + per afegir el vostre primer segell o signatura';

  @override
  String get done => 'Fet';

  @override
  String get menuEdit => 'Edita';

  @override
  String get chooseFromFiles => 'Tria dels fitxers';

  @override
  String get chooseFromGallery => 'Tria de la galeria';

  @override
  String get imageTooBig => 'La imatge és massa gran (màx. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'La resolució és massa alta (màx. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Format d\'imatge no compatible';

  @override
  String get deleteTooltip => 'Elimina';

  @override
  String get shareTooltip => 'Comparteix';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Pàgina $currentPage de $totalPages';
  }

  @override
  String get noDocumentLoaded => 'No s\'ha carregat cap document';

  @override
  String get failedToLoadPdf => 'No s\'ha pogut carregar el PDF';

  @override
  String get passwordRequired => 'Contrasenya requerida';

  @override
  String get pdfPasswordProtected =>
      'Aquest PDF està protegit amb contrasenya.';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get unsavedChangesTitle => 'Canvis no desats';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Voleu desar els canvis a \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Toqueu per obrir un document PDF';

  @override
  String get onboardingSwipeUp =>
      'Llisqueu cap amunt per afegir signatures i segells';

  @override
  String get onboardingAddImage =>
      'Toqueu per afegir la vostra primera signatura o segell';

  @override
  String get onboardingDragImage => 'Arrossegueu sobre el PDF per col·locar-lo';

  @override
  String get onboardingResizeObject =>
      'Toqueu per seleccionar. Arrossegueu les cantonades per redimensionar.';

  @override
  String get onboardingDeleteImage => 'Tap to delete the selected image';

  @override
  String get onboardingTapToContinue => 'Toqueu a qualsevol lloc per continuar';

  @override
  String get imageConversionFailed =>
      'No s\'ha pogut convertir la imatge a PDF';
}
