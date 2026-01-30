// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get openPdf => 'PDF khulun';

  @override
  String get selectPdf => 'PDF bachun';

  @override
  String get recentFiles => 'Sompratik file';

  @override
  String get removeFromList => 'Taliqa theke mochun';

  @override
  String get openedNow => 'Ekhonoi khola hoyeche';

  @override
  String openedMinutesAgo(int count) {
    return '$count minute age khola hoyeche';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count ghonta age khola hoyeche';
  }

  @override
  String get openedYesterday => 'Gatokal khola hoyeche';

  @override
  String openedDaysAgo(int count) {
    return '$count din age khola hoyeche';
  }

  @override
  String get fileNotFound => 'File paoa jayni';

  @override
  String get fileAccessDenied => 'Probesh nishiddho';

  @override
  String get clearRecentFiles => 'Sompratik file mochun';

  @override
  String get cancel => 'Batal';

  @override
  String get confirm => 'Nischit';

  @override
  String get error => 'Truti';

  @override
  String get ok => 'Thik ache';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Khulun...';

  @override
  String get menuOpenRecent => 'Sompratik khulun';

  @override
  String get menuNoRecentFiles => 'Kono sompratik file nei';

  @override
  String get menuClearMenu => 'Menu mochun';

  @override
  String get menuSave => 'Sanchhoy korun';

  @override
  String get menuSaveAs => 'Erup sanchhoy korun...';

  @override
  String get menuSaveAll => 'সব সংরক্ষণ করুন';

  @override
  String get menuShare => 'Share korun...';

  @override
  String get menuCloseWindow => 'Janala bondho korun';

  @override
  String get menuCloseAll => 'সব বন্ধ করুন';

  @override
  String get menuQuit => 'PDFSign থেকে প্রস্থান';

  @override
  String get closeAllDialogTitle => 'পরিবর্তন সংরক্ষণ করবেন?';

  @override
  String closeAllDialogMessage(int count) {
    return 'বন্ধ করার আগে $countটি নথিতে পরিবর্তন সংরক্ষণ করতে চান?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'বন্ধ করার আগে 1টি নথিতে পরিবর্তন সংরক্ষণ করতে চান?';

  @override
  String get closeAllDialogSaveAll => 'সব সংরক্ষণ করুন';

  @override
  String get closeAllDialogDontSave => 'সংরক্ষণ করবেন না';

  @override
  String get closeAllDialogCancel => 'বাতিল';

  @override
  String get saveFailedDialogTitle => 'সংরক্ষণ ব্যর্থ';

  @override
  String saveFailedDialogMessage(int count) {
    return '$countটি নথি সংরক্ষণ করতে ব্যর্থ। যাইহোক বন্ধ করবেন?';
  }

  @override
  String get saveFailedDialogClose => 'যাইহোক বন্ধ করুন';

  @override
  String get saveChangesTitle => 'Paribartan sanchhoy korben?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Bondho korar age \"$fileName\" file-e paribartan sanchhoy korte chan?';
  }

  @override
  String get saveButton => 'Sanchhoy korun';

  @override
  String get discardButton => 'Bajay din';

  @override
  String get documentEdited => 'Sompadito';

  @override
  String get documentSaved => 'Sanchhoy hoyeche';

  @override
  String get menuSettings => 'Settingsh...';

  @override
  String get menuWindow => 'উইন্ডো';

  @override
  String get menuMinimize => 'ছোট করুন';

  @override
  String get menuZoom => 'জুম';

  @override
  String get menuBringAllToFront => 'সব সামনে আনুন';

  @override
  String get settingsTitle => 'Settingsh';

  @override
  String get settingsLanguage => 'Bhasha';

  @override
  String get settingsLanguageSystem => 'System default';

  @override
  String get settingsUnits => 'Ekai';

  @override
  String get settingsUnitsCentimeters => 'Sentimeter';

  @override
  String get settingsUnitsInches => 'Inch';

  @override
  String get settingsSearchLanguages => 'ভাষা অনুসন্ধান...';

  @override
  String get settingsGeneral => 'সাধারণ';

  @override
  String get addImage => 'ছবি যোগ করুন';

  @override
  String get selectImages => 'ছবি নির্বাচন করুন';

  @override
  String get zoomFitWidth => 'প্রস্থে মানানসই';

  @override
  String get zoomIn => 'জুম ইন';

  @override
  String get zoomOut => 'জুম আউট';

  @override
  String get selectZoomLevel => 'জুম স্তর নির্বাচন করুন';

  @override
  String get goToPage => 'পৃষ্ঠায় যান';

  @override
  String get go => 'যান';

  @override
  String get savePdfAs => 'PDF হিসাবে সংরক্ষণ করুন';

  @override
  String get incorrectPassword => 'ভুল পাসওয়ার্ড';

  @override
  String get saveFailed => 'সংরক্ষণ ব্যর্থ';

  @override
  String savedTo(String path) {
    return 'সংরক্ষিত: $path';
  }

  @override
  String get noOriginalPdfStored => 'কোনো মূল PDF সংরক্ষিত নেই';

  @override
  String get waitingForFolderPermission =>
      'ফোল্ডার অ্যাক্সেস অনুমতির জন্য অপেক্ষা করা হচ্ছে...';

  @override
  String get emptyRecentFiles => 'শুরু করতে একটি PDF খুলুন';

  @override
  String get imagesTitle => 'ছবি';

  @override
  String get noImagesYet => 'এখনো কোনো ছবি নেই';

  @override
  String get noImagesHint =>
      'আপনার প্রথম সীল বা স্বাক্ষর যোগ করতে + ট্যাপ করুন';

  @override
  String get done => 'সম্পন্ন';

  @override
  String get menuEdit => 'সম্পাদনা';

  @override
  String get chooseFromFiles => 'ফাইল থেকে বাছুন';

  @override
  String get chooseFromGallery => 'গ্যালারি থেকে বাছুন';

  @override
  String get imageTooBig => 'ছবি খুব বড় (সর্বোচ্চ ৫০ MB)';

  @override
  String get imageResolutionTooHigh =>
      'ছবির রেজোলিউশন খুব বেশি (সর্বোচ্চ ৪০৯৬×৪০৯৬)';

  @override
  String get unsupportedImageFormat => 'অসমর্থিত ছবির ফরম্যাট';

  @override
  String get deleteTooltip => 'মুছুন';

  @override
  String get shareTooltip => 'শেয়ার করুন';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'পৃষ্ঠা $currentPage এর মধ্যে $totalPages';
  }

  @override
  String get noDocumentLoaded => 'কোনো নথি লোড হয়নি';

  @override
  String get failedToLoadPdf => 'PDF লোড করতে ব্যর্থ';

  @override
  String get passwordRequired => 'পাসওয়ার্ড প্রয়োজন';

  @override
  String get pdfPasswordProtected => 'এই PDF পাসওয়ার্ড সুরক্ষিত।';

  @override
  String errorWithMessage(String message) {
    return 'ত্রুটি: $message';
  }

  @override
  String get unsavedChangesTitle => 'অসংরক্ষিত পরিবর্তন';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'আপনি কি \"$fileName\" এ পরিবর্তন সংরক্ষণ করতে চান?';
  }

  @override
  String get onboardingOpenPdf => 'একটি PDF ডকুমেন্ট খুলতে ট্যাপ করুন';

  @override
  String get onboardingSwipeUp => 'স্বাক্ষর এবং সীল যোগ করতে উপরে সোয়াইপ করুন';

  @override
  String get onboardingAddImage =>
      'আপনার প্রথম স্বাক্ষর বা সীল যোগ করতে ট্যাপ করুন';

  @override
  String get onboardingDragImage => 'এটি স্থাপন করতে PDF-এ টেনে আনুন';

  @override
  String get onboardingResizeObject =>
      'নির্বাচন করতে ট্যাপ করুন। আকার পরিবর্তন করতে কোণগুলি টানুন।';

  @override
  String get onboardingDeleteImage => 'Tap to delete the selected image';

  @override
  String get onboardingTapToContinue =>
      'চালিয়ে যেতে যেকোনো জায়গায় ট্যাপ করুন';

  @override
  String get imageConversionFailed => 'ছবিকে PDF-এ রূপান্তর করা যায়নি';
}
