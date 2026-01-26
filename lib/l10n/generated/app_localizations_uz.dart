// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get openPdf => 'PDF ochish';

  @override
  String get selectPdf => 'PDF tanlash';

  @override
  String get recentFiles => 'Soʻnggi fayllar';

  @override
  String get removeFromList => 'Roʻyxatdan oʻchirish';

  @override
  String get openedNow => 'Hozirgina ochildi';

  @override
  String openedMinutesAgo(int count) {
    return '$count daqiqa oldin ochildi';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count soat oldin ochildi';
  }

  @override
  String get openedYesterday => 'Kecha ochildi';

  @override
  String openedDaysAgo(int count) {
    return '$count kun oldin ochildi';
  }

  @override
  String get fileNotFound => 'Fayl topilmadi';

  @override
  String get fileAccessDenied => 'Kirish taqiqlangan';

  @override
  String get clearRecentFiles => 'Soʻnggi fayllarni tozalash';

  @override
  String get cancel => 'Bekor qilish';

  @override
  String get confirm => 'Tasdiqlash';

  @override
  String get error => 'Xato';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fayl';

  @override
  String get menuOpen => 'Ochish...';

  @override
  String get menuOpenRecent => 'Soʻnggilarni ochish';

  @override
  String get menuNoRecentFiles => 'Soʻnggi fayllar yoʻq';

  @override
  String get menuClearMenu => 'Menyuni tozalash';

  @override
  String get menuSave => 'Saqlash';

  @override
  String get menuSaveAs => 'Boshqacha saqlash...';

  @override
  String get menuSaveAll => 'Barchasini saqlash';

  @override
  String get menuShare => 'Ulashish...';

  @override
  String get menuCloseWindow => 'Oynani yopish';

  @override
  String get menuCloseAll => 'Barchasini yopish';

  @override
  String get menuQuit => 'PDFSign-dan chiqish';

  @override
  String get closeAllDialogTitle => 'O\'zgarishlarni saqlash?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Yopishdan oldin $count hujjatdagi o\'zgarishlarni saqlamoqchimisiz?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Yopishdan oldin 1 hujjatdagi o\'zgarishlarni saqlamoqchimisiz?';

  @override
  String get closeAllDialogSaveAll => 'Barchasini saqlash';

  @override
  String get closeAllDialogDontSave => 'Saqlamaslik';

  @override
  String get closeAllDialogCancel => 'Bekor qilish';

  @override
  String get saveFailedDialogTitle => 'Saqlash muvaffaqiyatsiz';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count ta hujjatni saqlash muvaffaqiyatsiz. Baribir yopilsinmi?';
  }

  @override
  String get saveFailedDialogClose => 'Baribir yopish';

  @override
  String get saveChangesTitle => 'Oʻzgarishlarni saqlash?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Yopishdan oldin \"$fileName\" faylidagi oʻzgarishlarni saqlamoqchimisiz?';
  }

  @override
  String get saveButton => 'Saqlash';

  @override
  String get discardButton => 'Saqlamaslik';

  @override
  String get documentEdited => 'Tahrirlangan';

  @override
  String get documentSaved => 'Saqlandi';

  @override
  String get menuSettings => 'Sozlamalar...';

  @override
  String get menuWindow => 'Oyna';

  @override
  String get menuMinimize => 'Kichiklashtirish';

  @override
  String get menuZoom => 'Masshtab';

  @override
  String get menuBringAllToFront => 'Barchasini oldinga olib kelish';

  @override
  String get settingsTitle => 'Sozlamalar';

  @override
  String get settingsLanguage => 'Til';

  @override
  String get settingsLanguageSystem => 'Tizim standart';

  @override
  String get settingsUnits => 'Oʻlchov birliklari';

  @override
  String get settingsUnitsCentimeters => 'Santimetr';

  @override
  String get settingsUnitsInches => 'Dyuym';

  @override
  String get settingsSearchLanguages => 'Tillarni qidirish...';

  @override
  String get settingsGeneral => 'Umumiy';

  @override
  String get addImage => 'Rasm qoʻshish';

  @override
  String get selectImages => 'Rasmlarni tanlash';

  @override
  String get zoomFitWidth => 'Kenglikka moslashtirish';

  @override
  String get zoomIn => 'Kattalashtirish';

  @override
  String get zoomOut => 'Kichiklashtirish';

  @override
  String get selectZoomLevel => 'Masshtab darajasini tanlash';

  @override
  String get goToPage => 'Sahifaga oʻtish';

  @override
  String get go => 'Oʻtish';

  @override
  String get savePdfAs => 'PDF sifatida saqlash';

  @override
  String get incorrectPassword => 'Notoʻgʻri parol';

  @override
  String get saveFailed => 'Saqlash muvaffaqiyatsiz';

  @override
  String savedTo(String path) {
    return 'Saqlandi: $path';
  }

  @override
  String get noOriginalPdfStored => 'Asl PDF saqlanmagan';

  @override
  String get waitingForFolderPermission =>
      'Jildga kirish ruxsati kutilmoqda...';

  @override
  String get emptyRecentFiles => 'Boshlash uchun PDF oching';

  @override
  String get imagesTitle => 'Rasmlar';

  @override
  String get noImagesYet => 'Hali rasmlar yo\'q';

  @override
  String get noImagesHint =>
      'Birinchi muhur yoki imzongizni qo\'shish uchun + ga bosing';

  @override
  String get done => 'Tayyor';

  @override
  String get menuEdit => 'Tahrirlash';

  @override
  String get chooseFromFiles => 'Fayllardan tanlash';

  @override
  String get chooseFromGallery => 'Galereyadan tanlash';

  @override
  String get imageTooBig => 'Rasm juda katta (maks. 50 MB)';

  @override
  String get imageResolutionTooHigh => 'Ruxsat juda yuqori (maks. 4096×4096)';

  @override
  String get unsupportedImageFormat =>
      'Qo\'llab-quvvatlanmaydigan rasm formati';
}
