// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get openPdf => 'PDF kholein';

  @override
  String get selectPdf => 'PDF chunein';

  @override
  String get recentFiles => 'Haal ki failein';

  @override
  String get removeFromList => 'Suchi se hataein';

  @override
  String get openedNow => 'Abhi khola gaya';

  @override
  String openedMinutesAgo(int count) {
    return '$count minute pehle khola gaya';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count ghante pehle khola gaya';
  }

  @override
  String get openedYesterday => 'Kal khola gaya';

  @override
  String openedDaysAgo(int count) {
    return '$count din pehle khola gaya';
  }

  @override
  String get fileNotFound => 'File nahi mili';

  @override
  String get fileAccessDenied => 'Pahunch asvikriti';

  @override
  String get clearRecentFiles => 'Haal ki failein saaf karein';

  @override
  String get cancel => 'Radd karein';

  @override
  String get confirm => 'Pushti karein';

  @override
  String get error => 'Truti';

  @override
  String get ok => 'Theek hai';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Kholein...';

  @override
  String get menuOpenRecent => 'Haal ke kholein';

  @override
  String get menuNoRecentFiles => 'Koi haal ki file nahi';

  @override
  String get menuClearMenu => 'Menu saaf karein';

  @override
  String get menuSave => 'Sahejein';

  @override
  String get menuSaveAs => 'Is roop mein sahejein...';

  @override
  String get menuSaveAll => 'सभी सहेजें';

  @override
  String get menuShare => 'Sajha karein...';

  @override
  String get menuCloseWindow => 'Window band karein';

  @override
  String get menuCloseAll => 'सभी बंद करें';

  @override
  String get menuQuit => 'PDFSign से बाहर निकलें';

  @override
  String get closeAllDialogTitle => 'परिवर्तन सहेजें?';

  @override
  String closeAllDialogMessage(int count) {
    return 'बंद करने से पहले $count दस्तावेजों में परिवर्तन सहेजना चाहते हैं?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'बंद करने से पहले 1 दस्तावेज में परिवर्तन सहेजना चाहते हैं?';

  @override
  String get closeAllDialogSaveAll => 'सभी सहेजें';

  @override
  String get closeAllDialogDontSave => 'न सहेजें';

  @override
  String get closeAllDialogCancel => 'रद्द करें';

  @override
  String get saveFailedDialogTitle => 'सहेजना विफल';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count दस्तावेज़ सहेजने में विफल। फिर भी बंद करें?';
  }

  @override
  String get saveFailedDialogClose => 'फिर भी बंद करें';

  @override
  String get saveChangesTitle => 'Parivartan sahejein?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Kya aap band karne se pehle \"$fileName\" mein parivartan sahejana chahte hain?';
  }

  @override
  String get saveButton => 'Sahejein';

  @override
  String get discardButton => 'Na sahejein';

  @override
  String get documentEdited => 'Sampadit';

  @override
  String get documentSaved => 'Saheja gaya';

  @override
  String get menuSettings => 'Settings...';

  @override
  String get menuWindow => 'विंडो';

  @override
  String get menuMinimize => 'छोटा करें';

  @override
  String get menuZoom => 'ज़ूम';

  @override
  String get menuBringAllToFront => 'सभी को आगे लाएं';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Bhasha';

  @override
  String get settingsLanguageSystem => 'System default';

  @override
  String get settingsUnits => 'Ikaiyaan';

  @override
  String get settingsUnitsCentimeters => 'Centimeter';

  @override
  String get settingsUnitsInches => 'Inch';

  @override
  String get settingsSearchLanguages => 'भाषाएं खोजें...';

  @override
  String get settingsGeneral => 'सामान्य';

  @override
  String get addImage => 'छवि जोड़ें';

  @override
  String get selectImages => 'छवियां चुनें';

  @override
  String get zoomFitWidth => 'चौड़ाई में फ़िट करें';

  @override
  String get zoomIn => 'ज़ूम इन';

  @override
  String get zoomOut => 'ज़ूम आउट';

  @override
  String get selectZoomLevel => 'ज़ूम स्तर चुनें';

  @override
  String get goToPage => 'पृष्ठ पर जाएं';

  @override
  String get go => 'जाएं';

  @override
  String get savePdfAs => 'PDF के रूप में सहेजें';

  @override
  String get incorrectPassword => 'गलत पासवर्ड';

  @override
  String get saveFailed => 'सहेजना विफल';

  @override
  String savedTo(String path) {
    return 'इसमें सहेजा गया: $path';
  }

  @override
  String get noOriginalPdfStored => 'कोई मूल PDF संग्रहीत नहीं';

  @override
  String get waitingForFolderPermission =>
      'फ़ोल्डर एक्सेस अनुमति की प्रतीक्षा की जा रही है...';
}
