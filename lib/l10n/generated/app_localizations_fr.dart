// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get openPdf => 'Ouvrir PDF';

  @override
  String get selectPdf => 'Sélectionner PDF';

  @override
  String get recentFiles => 'Fichiers récents';

  @override
  String get removeFromList => 'Supprimer de la liste';

  @override
  String get openedNow => 'Ouvert à l\'instant';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutes',
      one: 'minute',
    );
    return 'Ouvert il y a $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'heures',
      one: 'heure',
    );
    return 'Ouvert il y a $count $_temp0';
  }

  @override
  String get openedYesterday => 'Ouvert hier';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'jours',
      one: 'jour',
    );
    return 'Ouvert il y a $count $_temp0';
  }

  @override
  String get fileNotFound => 'Fichier introuvable';

  @override
  String get fileAccessDenied => 'Accès refusé';

  @override
  String get clearRecentFiles => 'Effacer les fichiers récents';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get error => 'Erreur';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fichier';

  @override
  String get menuOpen => 'Ouvrir...';

  @override
  String get menuOpenRecent => 'Ouvrir récent';

  @override
  String get menuNoRecentFiles => 'Aucun fichier récent';

  @override
  String get menuClearMenu => 'Effacer le menu';

  @override
  String get menuSave => 'Enregistrer';

  @override
  String get menuSaveAs => 'Enregistrer sous...';

  @override
  String get menuSaveAll => 'Tout enregistrer';

  @override
  String get menuShare => 'Partager...';

  @override
  String get menuCloseWindow => 'Fermer la fenêtre';

  @override
  String get menuCloseAll => 'Tout fermer';

  @override
  String get menuQuit => 'Quitter PDFSign';

  @override
  String get closeAllDialogTitle => 'Enregistrer les modifications ?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Voulez-vous enregistrer les modifications de $count documents avant de fermer ?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Voulez-vous enregistrer les modifications de 1 document avant de fermer ?';

  @override
  String get closeAllDialogSaveAll => 'Tout enregistrer';

  @override
  String get closeAllDialogDontSave => 'Ne pas enregistrer';

  @override
  String get closeAllDialogCancel => 'Annuler';

  @override
  String get saveFailedDialogTitle => 'Échec de l\'enregistrement';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Échec de l\'enregistrement de $count document(s). Fermer quand même ?';
  }

  @override
  String get saveFailedDialogClose => 'Fermer quand même';

  @override
  String get saveChangesTitle => 'Enregistrer les modifications?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Voulez-vous enregistrer les modifications apportées à \"$fileName\" avant de fermer?';
  }

  @override
  String get saveButton => 'Enregistrer';

  @override
  String get discardButton => 'Ne pas enregistrer';

  @override
  String get documentEdited => 'Modifié';

  @override
  String get documentSaved => 'Enregistré';

  @override
  String get menuSettings => 'Réglages...';

  @override
  String get menuWindow => 'Fenêtre';

  @override
  String get menuMinimize => 'Réduire';

  @override
  String get menuZoom => 'Réduire/agrandir';

  @override
  String get menuBringAllToFront => 'Tout ramener au premier plan';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageSystem => 'Par défaut du système';

  @override
  String get settingsUnits => 'Unités';

  @override
  String get settingsUnitsCentimeters => 'Centimètres';

  @override
  String get settingsUnitsInches => 'Pouces';

  @override
  String get settingsSearchLanguages => 'Rechercher des langues...';

  @override
  String get settingsGeneral => 'Général';

  @override
  String get addImage => 'Ajouter une image';

  @override
  String get selectImages => 'Sélectionner des images';

  @override
  String get zoomFitWidth => 'Ajuster à la largeur';

  @override
  String get zoomIn => 'Zoom avant';

  @override
  String get zoomOut => 'Zoom arrière';

  @override
  String get selectZoomLevel => 'Sélectionner le niveau de zoom';

  @override
  String get goToPage => 'Aller à la page';

  @override
  String get go => 'Aller';

  @override
  String get savePdfAs => 'Enregistrer le PDF sous';

  @override
  String get incorrectPassword => 'Mot de passe incorrect';

  @override
  String get saveFailed => 'Échec de l\'enregistrement';

  @override
  String savedTo(String path) {
    return 'Enregistré dans : $path';
  }

  @override
  String get noOriginalPdfStored => 'Aucun PDF original stocké';

  @override
  String get waitingForFolderPermission =>
      'En attente de l\'autorisation d\'accès au dossier...';

  @override
  String get emptyRecentFiles => 'Ouvrez un PDF pour commencer';

  @override
  String get imagesTitle => 'Images';

  @override
  String get noImagesYet => 'Aucune image';

  @override
  String get noImagesHint =>
      'Appuyez sur + pour ajouter votre premier tampon ou signature';

  @override
  String get done => 'Terminé';

  @override
  String get menuEdit => 'Modifier';

  @override
  String get chooseFromFiles => 'Choisir dans les fichiers';

  @override
  String get chooseFromGallery => 'Choisir dans la galerie';

  @override
  String get imageTooBig => 'L\'image est trop volumineuse (max 50 Mo)';

  @override
  String get imageResolutionTooHigh =>
      'La résolution est trop élevée (max 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Format d\'image non pris en charge';

  @override
  String get deleteTooltip => 'Supprimer';

  @override
  String get shareTooltip => 'Partager';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Page $currentPage sur $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Aucun document chargé';

  @override
  String get failedToLoadPdf => 'Échec du chargement du PDF';

  @override
  String get passwordRequired => 'Mot de passe requis';

  @override
  String get pdfPasswordProtected => 'Ce PDF est protégé par mot de passe.';

  @override
  String errorWithMessage(String message) {
    return 'Erreur : $message';
  }

  @override
  String get unsavedChangesTitle => 'Modifications non enregistrées';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Voulez-vous enregistrer les modifications apportées à « $fileName » ?';
  }
}
