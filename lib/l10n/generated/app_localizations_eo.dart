// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Esperanto (`eo`).
class AppLocalizationsEo extends AppLocalizations {
  AppLocalizationsEo([String locale = 'eo']) : super(locale);

  @override
  String get openPdf => 'Malfermi PDF';

  @override
  String get selectPdf => 'Elekti PDF';

  @override
  String get recentFiles => 'Lastaj dosieroj';

  @override
  String get removeFromList => 'Forigi el listo';

  @override
  String get openedNow => 'Jxus malfermita';

  @override
  String openedMinutesAgo(int count) {
    return 'Malfermita antaux $count minutoj';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Malfermita antaux $count horoj';
  }

  @override
  String get openedYesterday => 'Malfermita hieraux';

  @override
  String openedDaysAgo(int count) {
    return 'Malfermita antaux $count tagoj';
  }

  @override
  String get fileNotFound => 'Dosiero ne trovita';

  @override
  String get fileAccessDenied => 'Aliro rifuzita';

  @override
  String get clearRecentFiles => 'Forviŝi lastajn dosierojn';

  @override
  String get cancel => 'Nuligi';

  @override
  String get confirm => 'Konfirmi';

  @override
  String get error => 'Eraro';

  @override
  String get ok => 'Bone';

  @override
  String get menuFile => 'Dosiero';

  @override
  String get menuOpen => 'Malfermi...';

  @override
  String get menuOpenRecent => 'Malfermi lastajn';

  @override
  String get menuNoRecentFiles => 'Neniuj lastaj dosieroj';

  @override
  String get menuClearMenu => 'Forviŝi menuon';

  @override
  String get menuSave => 'Konservi';

  @override
  String get menuSaveAs => 'Konservi kiel...';

  @override
  String get menuSaveAll => 'Konservi ĉiujn';

  @override
  String get menuShare => 'Kunhavigi...';

  @override
  String get menuCloseWindow => 'Fermi fenestron';

  @override
  String get menuCloseAll => 'Fermi ĉiujn';

  @override
  String get menuQuit => 'Eliri PDFSign';

  @override
  String get closeAllDialogTitle => 'Konservi ŝanĝojn?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Ĉu vi volas konservi ŝanĝojn en $count dokumentoj antaŭ fermi?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Ĉu vi volas konservi ŝanĝojn en 1 dokumento antaŭ fermi?';

  @override
  String get closeAllDialogSaveAll => 'Konservi ĉiujn';

  @override
  String get closeAllDialogDontSave => 'Ne konservi';

  @override
  String get closeAllDialogCancel => 'Nuligi';

  @override
  String get saveFailedDialogTitle => 'Konservo malsukcesis';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Malsukcesis konservi $count dokumenton(jn). Ĉu fermi tamen?';
  }

  @override
  String get saveFailedDialogClose => 'Fermi tamen';

  @override
  String get saveChangesTitle => 'Konservi sxangxojn?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Cxu vi volas konservi sxangxojn en \"$fileName\" antaux fermi?';
  }

  @override
  String get saveButton => 'Konservi';

  @override
  String get discardButton => 'Ne konservi';

  @override
  String get documentEdited => 'Redaktita';

  @override
  String get documentSaved => 'Konservita';

  @override
  String get menuSettings => 'Agordoj...';

  @override
  String get menuWindow => 'Fenestro';

  @override
  String get menuMinimize => 'Minimumigi';

  @override
  String get menuZoom => 'Zomi';

  @override
  String get menuBringAllToFront => 'Ĉiujn antaŭen';

  @override
  String get settingsTitle => 'Agordoj';

  @override
  String get settingsLanguage => 'Lingvo';

  @override
  String get settingsLanguageSystem => 'Sistema defauxlto';

  @override
  String get settingsUnits => 'Unuoj';

  @override
  String get settingsUnitsCentimeters => 'Centimetroj';

  @override
  String get settingsUnitsInches => 'Coloj';

  @override
  String get settingsSearchLanguages => 'Serĉi lingvojn...';

  @override
  String get settingsGeneral => 'Ĝenerale';

  @override
  String get addImage => 'Aldoni bildon';

  @override
  String get selectImages => 'Elekti bildojn';

  @override
  String get zoomFitWidth => 'Adapti larĝon';

  @override
  String get zoomIn => 'Pligrandigi';

  @override
  String get zoomOut => 'Malpligrandigi';

  @override
  String get selectZoomLevel => 'Elekti zoomnivelon';

  @override
  String get goToPage => 'Iri al paĝo';

  @override
  String get go => 'Iri';

  @override
  String get savePdfAs => 'Konservi PDF kiel';

  @override
  String get incorrectPassword => 'Malĝusta pasvorto';

  @override
  String get saveFailed => 'Konservado fiaskis';

  @override
  String savedTo(String path) {
    return 'Konservita al: $path';
  }

  @override
  String get noOriginalPdfStored => 'Neniu originala PDF konservita';

  @override
  String get waitingForFolderPermission =>
      'Atendante dosierujan alirpermeson...';
}
