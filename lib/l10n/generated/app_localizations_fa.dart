// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get openPdf => 'باز کردن PDF';

  @override
  String get selectPdf => 'باز کردن فایل';

  @override
  String get untitledDocument => 'بدون عنوان.pdf';

  @override
  String get recentFiles => 'فایل‌های اخیر';

  @override
  String get removeFromList => 'حذف از لیست';

  @override
  String get openedNow => 'همین الان باز شد';

  @override
  String openedMinutesAgo(int count) {
    return '$count دقیقه پیش باز شد';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count ساعت پیش باز شد';
  }

  @override
  String get openedYesterday => 'دیروز باز شد';

  @override
  String openedDaysAgo(int count) {
    return '$count روز پیش باز شد';
  }

  @override
  String get fileNotFound => 'فایل یافت نشد';

  @override
  String get fileAccessDenied => 'دسترسی رد شد';

  @override
  String get clearRecentFiles => 'پاک کردن فایل‌های اخیر';

  @override
  String get cancel => 'لغو';

  @override
  String get confirm => 'تایید';

  @override
  String get error => 'خطا';

  @override
  String get ok => 'باشه';

  @override
  String get menuFile => 'فایل';

  @override
  String get menuOpen => 'باز کردن...';

  @override
  String get menuOpenRecent => 'باز کردن اخیر';

  @override
  String get menuNoRecentFiles => 'فایل اخیری وجود ندارد';

  @override
  String get menuClearMenu => 'پاک کردن منو';

  @override
  String get menuSave => 'ذخیره';

  @override
  String get menuSaveAs => 'ذخیره به عنوان...';

  @override
  String get menuSaveAll => 'ذخیره همه';

  @override
  String get menuShare => 'اشتراک‌گذاری...';

  @override
  String get menuCloseWindow => 'بستن پنجره';

  @override
  String get menuCloseAll => 'بستن همه';

  @override
  String get menuQuit => 'خروج از PDFSign';

  @override
  String get closeAllDialogTitle => 'ذخیره تغییرات؟';

  @override
  String closeAllDialogMessage(int count) {
    return 'آیا می‌خواهید تغییرات در $count سند را قبل از بستن ذخیره کنید؟';
  }

  @override
  String get closeAllDialogMessageOne =>
      'آیا می‌خواهید تغییرات در 1 سند را قبل از بستن ذخیره کنید؟';

  @override
  String get closeAllDialogSaveAll => 'ذخیره همه';

  @override
  String get closeAllDialogDontSave => 'ذخیره نکن';

  @override
  String get closeAllDialogCancel => 'لغو';

  @override
  String get saveFailedDialogTitle => 'ذخیره ناموفق';

  @override
  String saveFailedDialogMessage(int count) {
    return 'ذخیره $count سند ناموفق بود. به هر حال ببندید؟';
  }

  @override
  String get saveFailedDialogClose => 'به هر حال ببند';

  @override
  String get saveChangesTitle => 'ذخیره تغییرات؟';

  @override
  String saveChangesMessage(String fileName) {
    return 'آیا می‌خواهید تغییرات در \"$fileName\" را قبل از بستن ذخیره کنید؟';
  }

  @override
  String get saveButton => 'ذخیره';

  @override
  String get discardButton => 'ذخیره نکن';

  @override
  String get documentEdited => 'ویرایش شده';

  @override
  String get documentSaved => 'ذخیره شد';

  @override
  String get menuSettings => 'تنظیمات...';

  @override
  String get menuWindow => 'پنجره';

  @override
  String get menuMinimize => 'کوچک‌سازی';

  @override
  String get menuZoom => 'بزرگ‌نمایی';

  @override
  String get menuBringAllToFront => 'همه را جلو بیاور';

  @override
  String get settingsTitle => 'تنظیمات';

  @override
  String get settingsLanguage => 'زبان';

  @override
  String get settingsLanguageSystem => 'پیش‌فرض سیستم';

  @override
  String get settingsUnits => 'واحدها';

  @override
  String get settingsUnitsCentimeters => 'سانتی‌متر';

  @override
  String get settingsUnitsInches => 'اینچ';

  @override
  String get settingsUnitsDefault => 'پیش‌فرض (بر اساس منطقه)';

  @override
  String get settingsSearchLanguages => 'جستجوی زبان‌ها...';

  @override
  String get settingsGeneral => 'عمومی';

  @override
  String get addImage => 'افزودن تصویر';

  @override
  String get selectImages => 'انتخاب تصاویر';

  @override
  String get zoomFitWidth => 'تناسب با عرض';

  @override
  String get zoomIn => 'بزرگنمایی';

  @override
  String get zoomOut => 'کوچک‌نمایی';

  @override
  String get selectZoomLevel => 'انتخاب سطح بزرگنمایی';

  @override
  String get goToPage => 'رفتن به صفحه';

  @override
  String get go => 'برو';

  @override
  String get savePdfAs => 'ذخیره PDF به عنوان';

  @override
  String get incorrectPassword => 'رمز عبور نادرست';

  @override
  String get saveFailed => 'ذخیره ناموفق';

  @override
  String savedTo(String path) {
    return 'ذخیره شده در: $path';
  }

  @override
  String get noOriginalPdfStored => 'PDF اصلی ذخیره نشده است';

  @override
  String get waitingForFolderPermission => 'در انتظار اجازه دسترسی به پوشه...';

  @override
  String get emptyRecentFiles => 'یک فایل باز کنید تا شروع کنید';

  @override
  String get imagesTitle => 'تصاویر';

  @override
  String get noImagesYet => 'تصویری وجود ندارد';

  @override
  String get noImagesHint =>
      'روی + بزنید تا اولین مهر یا امضای خود را اضافه کنید';

  @override
  String get done => 'انجام شد';

  @override
  String get menuEdit => 'ویرایش';

  @override
  String get chooseFromFiles => 'انتخاب از فایل‌ها';

  @override
  String get chooseFromGallery => 'انتخاب از گالری';

  @override
  String get imageTooBig => 'تصویر خیلی بزرگ است (حداکثر ۵۰ مگابایت)';

  @override
  String get imageResolutionTooHigh =>
      'رزولوشن تصویر خیلی بالاست (حداکثر ۴۰۹۶×۴۰۹۶)';

  @override
  String get unsupportedImageFormat => 'فرمت تصویر پشتیبانی نمی‌شود';

  @override
  String get deleteTooltip => 'حذف';

  @override
  String get shareTooltip => 'اشتراک‌گذاری';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'صفحه $currentPage از $totalPages';
  }

  @override
  String get noDocumentLoaded => 'سندی بارگذاری نشده';

  @override
  String get failedToLoadPdf => 'بارگذاری PDF ناموفق بود';

  @override
  String get passwordRequired => 'رمز عبور لازم است';

  @override
  String get pdfPasswordProtected => 'این PDF با رمز عبور محافظت شده است.';

  @override
  String errorWithMessage(String message) {
    return 'خطا: $message';
  }

  @override
  String get unsavedChangesTitle => 'تغییرات ذخیره نشده';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'آیا می‌خواهید تغییرات در \"$fileName\" را ذخیره کنید؟';
  }

  @override
  String get onboardingOpenPdf => 'برای باز کردن سند PDF ضربه بزنید';

  @override
  String get onboardingSwipeUp => 'برای افزودن امضا و مهر به بالا بکشید';

  @override
  String get onboardingAddImage => 'برای افزودن اولین امضا یا مهر ضربه بزنید';

  @override
  String get onboardingDragImage => 'روی PDF بکشید تا قرار گیرد';

  @override
  String get onboardingResizeObject =>
      'برای انتخاب ضربه بزنید. گوشه‌ها را برای تغییر اندازه بکشید.';

  @override
  String get onboardingDeleteImage => 'برای حذف تصویر انتخاب شده ضربه بزنید';

  @override
  String get onboardingTapToContinue => 'برای ادامه هر جایی ضربه بزنید';

  @override
  String get imageConversionFailed => 'تبدیل تصویر به PDF ناموفق بود';

  @override
  String get saveDocumentTitle => 'ذخیره سند';

  @override
  String get fileNameLabel => 'نام فایل';

  @override
  String get defaultFileName => 'سند';

  @override
  String get onlyOnePdfAllowed => 'تنها یک فایل PDF در هر بار قابل باز شدن است';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'فایل‌های PDF نادیده گرفته شدند. فقط تصاویر تبدیل می‌شوند.';

  @override
  String convertingImages(int count) {
    return 'در حال تبدیل $count تصویر...';
  }
}
