// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get openPdf => 'פתח PDF';

  @override
  String get selectPdf => 'בחר PDF';

  @override
  String get recentFiles => 'קבצים אחרונים';

  @override
  String get removeFromList => 'הסר מהרשימה';

  @override
  String get openedNow => 'נפתח זה עתה';

  @override
  String openedMinutesAgo(int count) {
    return 'נפתח לפני $count דקות';
  }

  @override
  String openedHoursAgo(int count) {
    return 'נפתח לפני $count שעות';
  }

  @override
  String get openedYesterday => 'נפתח אתמול';

  @override
  String openedDaysAgo(int count) {
    return 'נפתח לפני $count ימים';
  }

  @override
  String get fileNotFound => 'הקובץ לא נמצא';

  @override
  String get fileAccessDenied => 'הגישה נדחתה';

  @override
  String get clearRecentFiles => 'נקה קבצים אחרונים';

  @override
  String get cancel => 'ביטול';

  @override
  String get confirm => 'אישור';

  @override
  String get error => 'שגיאה';

  @override
  String get ok => 'אישור';

  @override
  String get menuFile => 'קובץ';

  @override
  String get menuOpen => 'פתח...';

  @override
  String get menuOpenRecent => 'פתח אחרונים';

  @override
  String get menuNoRecentFiles => 'אין קבצים אחרונים';

  @override
  String get menuClearMenu => 'נקה תפריט';

  @override
  String get menuSave => 'שמור';

  @override
  String get menuSaveAs => 'שמור בשם...';

  @override
  String get menuSaveAll => 'שמור הכל';

  @override
  String get menuShare => 'שתף...';

  @override
  String get menuCloseWindow => 'סגור חלון';

  @override
  String get menuCloseAll => 'סגור הכל';

  @override
  String get menuQuit => 'צא מ-PDFSign';

  @override
  String get closeAllDialogTitle => 'לשמור שינויים?';

  @override
  String closeAllDialogMessage(int count) {
    return 'האם ברצונך לשמור את השינויים ב-$count מסמכים לפני הסגירה?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'האם ברצונך לשמור את השינויים במסמך אחד לפני הסגירה?';

  @override
  String get closeAllDialogSaveAll => 'שמור הכל';

  @override
  String get closeAllDialogDontSave => 'אל תשמור';

  @override
  String get closeAllDialogCancel => 'ביטול';

  @override
  String get saveFailedDialogTitle => 'השמירה נכשלה';

  @override
  String saveFailedDialogMessage(int count) {
    return 'השמירה של $count מסמכים נכשלה. לסגור בכל זאת?';
  }

  @override
  String get saveFailedDialogClose => 'סגור בכל זאת';

  @override
  String get saveChangesTitle => 'לשמור שינויים?';

  @override
  String saveChangesMessage(String fileName) {
    return 'האם ברצונך לשמור את השינויים ב-\"$fileName\" לפני הסגירה?';
  }

  @override
  String get saveButton => 'שמור';

  @override
  String get discardButton => 'אל תשמור';

  @override
  String get documentEdited => 'נערך';

  @override
  String get documentSaved => 'נשמר';

  @override
  String get menuSettings => 'הגדרות...';

  @override
  String get menuWindow => 'חלון';

  @override
  String get menuMinimize => 'מזער';

  @override
  String get menuZoom => 'הגדל/הקטן';

  @override
  String get menuBringAllToFront => 'הבא הכל לחזית';

  @override
  String get settingsTitle => 'הגדרות';

  @override
  String get settingsLanguage => 'שפה';

  @override
  String get settingsLanguageSystem => 'ברירת מחדל מערכת';

  @override
  String get settingsUnits => 'יחידות';

  @override
  String get settingsUnitsCentimeters => 'סנטימטרים';

  @override
  String get settingsUnitsInches => 'אינצים';

  @override
  String get settingsSearchLanguages => 'חיפוש שפות...';

  @override
  String get settingsGeneral => 'כללי';

  @override
  String get addImage => 'הוסף תמונה';

  @override
  String get selectImages => 'בחר תמונות';

  @override
  String get zoomFitWidth => 'התאם לרוחב';

  @override
  String get zoomIn => 'הגדל';

  @override
  String get zoomOut => 'הקטן';

  @override
  String get selectZoomLevel => 'בחר רמת זום';

  @override
  String get goToPage => 'עבור לעמוד';

  @override
  String get go => 'עבור';

  @override
  String get savePdfAs => 'שמור PDF בשם';

  @override
  String get incorrectPassword => 'סיסמה שגויה';

  @override
  String get saveFailed => 'השמירה נכשלה';

  @override
  String savedTo(String path) {
    return 'נשמר ב: $path';
  }

  @override
  String get noOriginalPdfStored => 'לא נשמר PDF מקורי';

  @override
  String get waitingForFolderPermission => 'ממתין להרשאת גישה לתיקייה...';

  @override
  String get emptyRecentFiles => 'פתח PDF כדי להתחיל';

  @override
  String get imagesTitle => 'תמונות';

  @override
  String get noImagesYet => 'אין תמונות עדיין';

  @override
  String get noImagesHint => 'הקש + כדי להוסיף את החותמת או החתימה הראשונה שלך';

  @override
  String get done => 'סיום';

  @override
  String get menuEdit => 'עריכה';

  @override
  String get chooseFromFiles => 'בחר מקבצים';

  @override
  String get chooseFromGallery => 'בחר מגלריה';

  @override
  String get imageTooBig => 'התמונה גדולה מדי (מקסימום 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'הרזולוציה גבוהה מדי (מקסימום 4096×4096)';

  @override
  String get unsupportedImageFormat => 'פורמט תמונה לא נתמך';
}
