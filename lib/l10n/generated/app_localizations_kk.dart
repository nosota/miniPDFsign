// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get openPdf => 'PDF ashu';

  @override
  String get selectPdf => 'PDF tandau';

  @override
  String get recentFiles => 'Songhy fayldar';

  @override
  String get removeFromList => 'Tizimnen oshiru';

  @override
  String get openedNow => 'Kazir ashyldy';

  @override
  String openedMinutesAgo(int count) {
    return '$count minut buryn ashyldy';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count saghat buryn ashyldy';
  }

  @override
  String get openedYesterday => 'Keshe ashyldy';

  @override
  String openedDaysAgo(int count) {
    return '$count kun buryn ashyldy';
  }

  @override
  String get fileNotFound => 'Fayl tabylmady';

  @override
  String get fileAccessDenied => 'Kiru tyiym salyndy';

  @override
  String get clearRecentFiles => 'Songhy fayldardy tazalau';

  @override
  String get cancel => 'Boldyrmai';

  @override
  String get confirm => 'Rastau';

  @override
  String get error => 'Qate';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fayl';

  @override
  String get menuOpen => 'Ashu...';

  @override
  String get menuOpenRecent => 'Songhylardy ashu';

  @override
  String get menuNoRecentFiles => 'Songhy fayldar zhoq';

  @override
  String get menuClearMenu => 'Menudi tazalau';

  @override
  String get menuSave => 'Saqtau';

  @override
  String get menuSaveAs => 'Basqasha saqtau...';

  @override
  String get menuSaveAll => 'Барлығын сақтау';

  @override
  String get menuShare => 'Bolisu...';

  @override
  String get menuCloseWindow => 'Terezeni zhabu';

  @override
  String get menuCloseAll => 'Барлығын жабу';

  @override
  String get menuQuit => 'PDFSign-нан шығу';

  @override
  String get closeAllDialogTitle => 'Өзгерістерді сақтау керек пе?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Жабу алдында $count құжаттағы өзгерістерді сақтағыңыз келе ме?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Жабу алдында 1 құжаттағы өзгерістерді сақтағыңыз келе ме?';

  @override
  String get closeAllDialogSaveAll => 'Барлығын сақтау';

  @override
  String get closeAllDialogDontSave => 'Сақтамау';

  @override
  String get closeAllDialogCancel => 'Болдырмау';

  @override
  String get saveFailedDialogTitle => 'Сақтау сәтсіз аяқталды';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count құжатты сақтау сәтсіз. Бәрібір жабу керек пе?';
  }

  @override
  String get saveFailedDialogClose => 'Бәрібір жабу';

  @override
  String get saveChangesTitle => 'Ozgeristerdi saqtau?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Zhabardyn aldynda \"$fileName\" faylyndaghy ozgeristerdi saqtaunu qalaisyz ba?';
  }

  @override
  String get saveButton => 'Saqtau';

  @override
  String get discardButton => 'Saqtamau';

  @override
  String get documentEdited => 'Ozgertildi';

  @override
  String get documentSaved => 'Saqtaldy';

  @override
  String get menuSettings => 'Parametrler...';

  @override
  String get menuWindow => 'Терезе';

  @override
  String get menuMinimize => 'Кішірейту';

  @override
  String get menuZoom => 'Масштаб';

  @override
  String get menuBringAllToFront => 'Барлығын алдыға әкелу';

  @override
  String get settingsTitle => 'Parametrler';

  @override
  String get settingsLanguage => 'Til';

  @override
  String get settingsLanguageSystem => 'Zhyie adepki';

  @override
  String get settingsUnits => 'Olshem birlkteri';

  @override
  String get settingsUnitsCentimeters => 'Santimetr';

  @override
  String get settingsUnitsInches => 'Diuym';

  @override
  String get settingsSearchLanguages => 'Тілдерді іздеу...';

  @override
  String get settingsGeneral => 'Жалпы';

  @override
  String get addImage => 'Сурет қосу';

  @override
  String get selectImages => 'Суреттерді таңдау';

  @override
  String get zoomFitWidth => 'Енге сәйкестендіру';

  @override
  String get zoomIn => 'Үлкейту';

  @override
  String get zoomOut => 'Кішірейту';

  @override
  String get selectZoomLevel => 'Масштаб деңгейін таңдау';

  @override
  String get goToPage => 'Бетке өту';

  @override
  String get go => 'Өту';

  @override
  String get savePdfAs => 'PDF ретінде сақтау';

  @override
  String get incorrectPassword => 'Құпия сөз қате';

  @override
  String get saveFailed => 'Сақтау сәтсіз';

  @override
  String savedTo(String path) {
    return 'Сақталды: $path';
  }

  @override
  String get noOriginalPdfStored => 'Түпнұсқа PDF сақталмаған';

  @override
  String get waitingForFolderPermission => 'Қалтаға кіру рұқсатын күтуде...';
}
