// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get openPdf => 'PDF thira';

  @override
  String get selectPdf => 'PDF thernthedu';

  @override
  String get recentFiles => 'Samipattiya koapugal';

  @override
  String get removeFromList => 'Pattiyal irunthu neekkavu';

  @override
  String get openedNow => 'Ippothuthan thirakkappattatu';

  @override
  String openedMinutesAgo(int count) {
    return '$count nimidam munpu thirakkappattatu';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count mani neram munpu thirakkappattatu';
  }

  @override
  String get openedYesterday => 'Netru thirakkappattatu';

  @override
  String openedDaysAgo(int count) {
    return '$count natkal munpu thirakkappattatu';
  }

  @override
  String get fileNotFound => 'Koapu kandupidikkavillai';

  @override
  String get fileAccessDenied => 'Anugal maruppu';

  @override
  String get clearRecentFiles => 'Samipattiya koapugalai azhikka';

  @override
  String get cancel => 'Raththu seiva';

  @override
  String get confirm => 'Uruthi seyya';

  @override
  String get error => 'Pizhiai';

  @override
  String get ok => 'Sari';

  @override
  String get menuFile => 'Koapu';

  @override
  String get menuOpen => 'Thira...';

  @override
  String get menuOpenRecent => 'Samipattiya thira';

  @override
  String get menuNoRecentFiles => 'Samipattiya koapugal illai';

  @override
  String get menuClearMenu => 'Menyuvai azhikka';

  @override
  String get menuSave => 'Semiykka';

  @override
  String get menuSaveAs => 'Veraraga semiykkavu...';

  @override
  String get menuSaveAll => 'அனைத்தையும் சேமிக்கவும்';

  @override
  String get menuShare => 'Pakirvu...';

  @override
  String get menuCloseWindow => 'Jannal muda';

  @override
  String get menuCloseAll => 'அனைத்தையும் மூடு';

  @override
  String get menuQuit => 'PDFSign-இலிருந்து வெளியேறு';

  @override
  String get closeAllDialogTitle => 'மாற்றங்களை சேமிக்கவா?';

  @override
  String closeAllDialogMessage(int count) {
    return 'மூடுவதற்கு முன் $count ஆவணங்களில் மாற்றங்களை சேமிக்க விரும்புகிறீர்களா?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'மூடுவதற்கு முன் 1 ஆவணத்தில் மாற்றங்களை சேமிக்க விரும்புகிறீர்களா?';

  @override
  String get closeAllDialogSaveAll => 'அனைத்தையும் சேமி';

  @override
  String get closeAllDialogDontSave => 'சேமிக்க வேண்டாம்';

  @override
  String get closeAllDialogCancel => 'ரத்து செய்';

  @override
  String get saveFailedDialogTitle => 'சேமிப்பு தோல்வி';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count ஆவணங்களைச் சேமிக்க முடியவில்லை. எப்படியும் மூடவா?';
  }

  @override
  String get saveFailedDialogClose => 'எப்படியும் மூடு';

  @override
  String get saveChangesTitle => 'Marrrangalai semikkava?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Muduvathikku munpu \"$fileName\" koapil marrrangalai semikka virumpukirayrka?';
  }

  @override
  String get saveButton => 'Semiykka';

  @override
  String get discardButton => 'Vidu';

  @override
  String get documentEdited => 'Thirutappattatu';

  @override
  String get documentSaved => 'Semikkappattathu';

  @override
  String get menuSettings => 'Amaikpugal...';

  @override
  String get menuWindow => 'சாளரம்';

  @override
  String get menuMinimize => 'சிறியதாக்கு';

  @override
  String get menuZoom => 'பெரிதாக்கு';

  @override
  String get menuBringAllToFront => 'அனைத்தையும் முன்னே கொண்டுவா';

  @override
  String get settingsTitle => 'Amaikpugal';

  @override
  String get settingsLanguage => 'Mozhli';

  @override
  String get settingsLanguageSystem => 'Amaippu default';

  @override
  String get settingsUnits => 'Alagu';

  @override
  String get settingsUnitsCentimeters => 'Sentimeettar';

  @override
  String get settingsUnitsInches => 'Inchu';

  @override
  String get settingsSearchLanguages => 'மொழிகளைத் தேடு...';

  @override
  String get settingsGeneral => 'பொது';

  @override
  String get addImage => 'படம் சேர்';

  @override
  String get selectImages => 'படங்களைத் தேர்ந்தெடு';

  @override
  String get zoomFitWidth => 'அகலத்திற்கு பொருத்து';

  @override
  String get zoomIn => 'பெரிதாக்கு';

  @override
  String get zoomOut => 'சிறிதாக்கு';

  @override
  String get selectZoomLevel => 'பெரிதாக்க நிலையைத் தேர்ந்தெடு';

  @override
  String get goToPage => 'பக்கத்திற்குச் செல்';

  @override
  String get go => 'செல்';

  @override
  String get savePdfAs => 'PDF ஆக சேமி';

  @override
  String get incorrectPassword => 'தவறான கடவுச்சொல்';

  @override
  String get saveFailed => 'சேமிப்பு தோல்வி';

  @override
  String savedTo(String path) {
    return 'சேமிக்கப்பட்டது: $path';
  }

  @override
  String get noOriginalPdfStored => 'அசல் PDF சேமிக்கப்படவில்லை';

  @override
  String get waitingForFolderPermission =>
      'கோப்புறை அணுகல் அனுமதிக்காக காத்திருக்கிறது...';

  @override
  String get emptyRecentFiles => 'Thudanga PDF thirakirathu';
}
