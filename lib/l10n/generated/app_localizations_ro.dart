// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get openPdf => 'Deschide PDF';

  @override
  String get selectPdf => 'Selecteaza PDF';

  @override
  String get recentFiles => 'Fisiere recente';

  @override
  String get removeFromList => 'Elimina din lista';

  @override
  String get openedNow => 'Deschis acum';

  @override
  String openedMinutesAgo(int count) {
    return 'Deschis acum $count minute';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Deschis acum $count ore';
  }

  @override
  String get openedYesterday => 'Deschis ieri';

  @override
  String openedDaysAgo(int count) {
    return 'Deschis acum $count zile';
  }

  @override
  String get fileNotFound => 'Fisierul nu a fost gasit';

  @override
  String get fileAccessDenied => 'Acces refuzat';

  @override
  String get clearRecentFiles => 'Sterge fisierele recente';

  @override
  String get cancel => 'Anulare';

  @override
  String get confirm => 'Confirmare';

  @override
  String get error => 'Eroare';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fisier';

  @override
  String get menuOpen => 'Deschide...';

  @override
  String get menuOpenRecent => 'Deschide recente';

  @override
  String get menuNoRecentFiles => 'Nu exista fisiere recente';

  @override
  String get menuClearMenu => 'Sterge meniu';

  @override
  String get menuSave => 'Salvare';

  @override
  String get menuSaveAs => 'Salvare ca...';

  @override
  String get menuSaveAll => 'Salvează tot';

  @override
  String get menuShare => 'Partajare...';

  @override
  String get menuCloseWindow => 'Inchide fereastra';

  @override
  String get menuCloseAll => 'Închide tot';

  @override
  String get menuQuit => 'Ieșire din PDFSign';

  @override
  String get closeAllDialogTitle => 'Salvați modificările?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Doriți să salvați modificările din $count documente înainte de închidere?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Doriți să salvați modificările din 1 document înainte de închidere?';

  @override
  String get closeAllDialogSaveAll => 'Salvează tot';

  @override
  String get closeAllDialogDontSave => 'Nu salva';

  @override
  String get closeAllDialogCancel => 'Anulare';

  @override
  String get saveFailedDialogTitle => 'Salvarea a eșuat';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Nu s-au putut salva $count document(e). Închideți oricum?';
  }

  @override
  String get saveFailedDialogClose => 'Închide oricum';

  @override
  String get saveChangesTitle => 'Salvati modificarile?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Doriti sa salvati modificarile din \"$fileName\" inainte de inchidere?';
  }

  @override
  String get saveButton => 'Salvare';

  @override
  String get discardButton => 'Renuntare';

  @override
  String get documentEdited => 'Editat';

  @override
  String get documentSaved => 'Salvat';

  @override
  String get menuSettings => 'Setari...';

  @override
  String get menuWindow => 'Fereastră';

  @override
  String get menuMinimize => 'Minimizare';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Adu Toate în Față';

  @override
  String get settingsTitle => 'Setari';

  @override
  String get settingsLanguage => 'Limba';

  @override
  String get settingsLanguageSystem => 'Implicit sistem';

  @override
  String get settingsUnits => 'Unitati';

  @override
  String get settingsUnitsCentimeters => 'Centimetri';

  @override
  String get settingsUnitsInches => 'Toli';

  @override
  String get settingsSearchLanguages => 'Căutare limbi...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Adaugă imagine';

  @override
  String get selectImages => 'Selectează imagini';

  @override
  String get zoomFitWidth => 'Potrivire lățime';

  @override
  String get zoomIn => 'Mărește';

  @override
  String get zoomOut => 'Micșorează';

  @override
  String get selectZoomLevel => 'Selectează nivelul de zoom';

  @override
  String get goToPage => 'Mergi la pagina';

  @override
  String get go => 'Mergi';

  @override
  String get savePdfAs => 'Salvează PDF ca';

  @override
  String get incorrectPassword => 'Parolă incorectă';

  @override
  String get saveFailed => 'Salvare eșuată';

  @override
  String savedTo(String path) {
    return 'Salvat în: $path';
  }

  @override
  String get noOriginalPdfStored => 'Niciun PDF original stocat';

  @override
  String get waitingForFolderPermission =>
      'Se așteaptă permisiunea de acces la folder...';

  @override
  String get emptyRecentFiles => 'Deschide un PDF pentru a incepe';

  @override
  String get imagesTitle => 'Imagini';

  @override
  String get noImagesYet => 'Nicio imagine încă';

  @override
  String get noImagesHint =>
      'Apăsați + pentru a adăuga prima ștampilă sau semnătură';

  @override
  String get done => 'Gata';

  @override
  String get menuEdit => 'Editare';

  @override
  String get chooseFromFiles => 'Alege din fișiere';

  @override
  String get chooseFromGallery => 'Alege din galerie';

  @override
  String get imageTooBig => 'Imaginea este prea mare (max. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Rezoluția este prea mare (max. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Format de imagine neacceptat';

  @override
  String get deleteTooltip => 'Șterge';

  @override
  String get shareTooltip => 'Partajează';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Pagina $currentPage din $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Niciun document încărcat';

  @override
  String get failedToLoadPdf => 'Nu s-a putut încărca PDF-ul';

  @override
  String get passwordRequired => 'Parolă necesară';

  @override
  String get pdfPasswordProtected => 'Acest PDF este protejat cu parolă.';

  @override
  String errorWithMessage(String message) {
    return 'Eroare: $message';
  }

  @override
  String get unsavedChangesTitle => 'Modificări nesalvate';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Doriți să salvați modificările din \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Atingeți pentru a deschide un document PDF';

  @override
  String get onboardingSwipeUp =>
      'Glisați în sus pentru a adăuga semnături și ștampile';

  @override
  String get onboardingAddImage =>
      'Atingeți pentru a adăuga prima semnătură sau ștampilă';

  @override
  String get onboardingDragImage => 'Trageți pe PDF pentru a-l plasa';

  @override
  String get onboardingResizeObject =>
      'Atingeți pentru a selecta. Trageți colțurile pentru a redimensiona.';

  @override
  String get onboardingDeleteImage => 'Tap to delete the selected image';

  @override
  String get onboardingTapToContinue => 'Atingeți oriunde pentru a continua';
}
