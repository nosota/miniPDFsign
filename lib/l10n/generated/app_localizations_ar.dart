// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get openPdf => 'فتح PDF';

  @override
  String get selectPdf => 'اختر PDF';

  @override
  String get recentFiles => 'الملفات الأخيرة';

  @override
  String get removeFromList => 'إزالة من القائمة';

  @override
  String get openedNow => 'فُتح للتو';

  @override
  String openedMinutesAgo(int count) {
    return 'فُتح منذ $count دقيقة';
  }

  @override
  String openedHoursAgo(int count) {
    return 'فُتح منذ $count ساعة';
  }

  @override
  String get openedYesterday => 'فُتح أمس';

  @override
  String openedDaysAgo(int count) {
    return 'فُتح منذ $count يوم';
  }

  @override
  String get fileNotFound => 'الملف غير موجود';

  @override
  String get fileAccessDenied => 'تم رفض الوصول';

  @override
  String get clearRecentFiles => 'مسح الملفات الأخيرة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get error => 'خطأ';

  @override
  String get ok => 'حسناً';

  @override
  String get menuFile => 'ملف';

  @override
  String get menuOpen => 'فتح...';

  @override
  String get menuOpenRecent => 'فتح الأخيرة';

  @override
  String get menuNoRecentFiles => 'لا توجد ملفات أخيرة';

  @override
  String get menuClearMenu => 'مسح القائمة';

  @override
  String get menuSave => 'حفظ';

  @override
  String get menuSaveAs => 'حفظ باسم...';

  @override
  String get menuSaveAll => 'حفظ الكل';

  @override
  String get menuShare => 'مشاركة...';

  @override
  String get menuCloseWindow => 'إغلاق النافذة';

  @override
  String get menuCloseAll => 'إغلاق الكل';

  @override
  String get menuQuit => 'إنهاء PDFSign';

  @override
  String get closeAllDialogTitle => 'حفظ التغييرات؟';

  @override
  String closeAllDialogMessage(int count) {
    return 'هل تريد حفظ التغييرات في $count مستند قبل الإغلاق؟';
  }

  @override
  String get closeAllDialogMessageOne =>
      'هل تريد حفظ التغييرات في مستند واحد قبل الإغلاق؟';

  @override
  String get closeAllDialogSaveAll => 'حفظ الكل';

  @override
  String get closeAllDialogDontSave => 'عدم الحفظ';

  @override
  String get closeAllDialogCancel => 'إلغاء';

  @override
  String get saveFailedDialogTitle => 'فشل الحفظ';

  @override
  String saveFailedDialogMessage(int count) {
    return 'فشل حفظ $count مستند(مستندات). هل تريد الإغلاق على أي حال؟';
  }

  @override
  String get saveFailedDialogClose => 'إغلاق على أي حال';

  @override
  String get saveChangesTitle => 'حفظ التغييرات؟';

  @override
  String saveChangesMessage(String fileName) {
    return 'هل تريد حفظ التغييرات في \"$fileName\" قبل الإغلاق؟';
  }

  @override
  String get saveButton => 'حفظ';

  @override
  String get discardButton => 'عدم الحفظ';

  @override
  String get documentEdited => 'تم التحرير';

  @override
  String get documentSaved => 'تم الحفظ';

  @override
  String get menuSettings => 'الإعدادات...';

  @override
  String get menuWindow => 'نافذة';

  @override
  String get menuMinimize => 'تصغير';

  @override
  String get menuZoom => 'تكبير/تصغير';

  @override
  String get menuBringAllToFront => 'إظهار الكل في المقدمة';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsLanguageSystem => 'افتراضي النظام';

  @override
  String get settingsUnits => 'الوحدات';

  @override
  String get settingsUnitsCentimeters => 'سنتيمتر';

  @override
  String get settingsUnitsInches => 'بوصة';

  @override
  String get settingsSearchLanguages => 'البحث عن اللغات...';

  @override
  String get settingsGeneral => 'عام';

  @override
  String get addImage => 'إضافة صورة';

  @override
  String get selectImages => 'اختيار الصور';

  @override
  String get zoomFitWidth => 'ملاءمة العرض';

  @override
  String get zoomIn => 'تكبير';

  @override
  String get zoomOut => 'تصغير';

  @override
  String get selectZoomLevel => 'اختر مستوى التكبير';

  @override
  String get goToPage => 'الانتقال إلى صفحة';

  @override
  String get go => 'انتقال';

  @override
  String get savePdfAs => 'حفظ PDF باسم';

  @override
  String get incorrectPassword => 'كلمة المرور غير صحيحة';

  @override
  String get saveFailed => 'فشل الحفظ';

  @override
  String savedTo(String path) {
    return 'تم الحفظ في: $path';
  }

  @override
  String get noOriginalPdfStored => 'لا يوجد ملف PDF أصلي محفوظ';

  @override
  String get waitingForFolderPermission => 'في انتظار إذن الوصول إلى المجلد...';

  @override
  String get emptyRecentFiles => 'افتح ملف PDF للبدء';

  @override
  String get imagesTitle => 'الصور';

  @override
  String get noImagesYet => 'لا توجد صور';

  @override
  String get noImagesHint => 'اضغط + لإضافة أول ختم أو توقيع';

  @override
  String get done => 'تم';

  @override
  String get menuEdit => 'تحرير';

  @override
  String get chooseFromFiles => 'اختر من الملفات';

  @override
  String get chooseFromGallery => 'اختر من المعرض';

  @override
  String get imageTooBig => 'الصورة كبيرة جداً (الحد الأقصى 50 ميجابايت)';

  @override
  String get imageResolutionTooHigh =>
      'دقة الصورة عالية جداً (الحد الأقصى 4096×4096)';

  @override
  String get unsupportedImageFormat => 'صيغة صورة غير مدعومة';
}
