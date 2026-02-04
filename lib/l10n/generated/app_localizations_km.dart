// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Khmer Central Khmer (`km`).
class AppLocalizationsKm extends AppLocalizations {
  AppLocalizationsKm([String locale = 'km']) : super(locale);

  @override
  String get openPdf => 'Berk PDF';

  @override
  String get selectPdf => 'បើកឯកសារ';

  @override
  String get untitledDocument => 'គ្មានចំណងជើង.pdf';

  @override
  String get recentFiles => 'Aeksaa tmey';

  @override
  String get removeFromList => 'Loub chenh pi banchhi';

  @override
  String get openedNow => 'Trov ban berk';

  @override
  String openedMinutesAgo(int count) {
    return 'Berk $count neatii muon';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Berk $count maong muon';
  }

  @override
  String get openedYesterday => 'Berk mselminhh';

  @override
  String openedDaysAgo(int count) {
    return 'Berk $count thngai muon';
  }

  @override
  String get fileNotFound => 'Rork min kheunh aeksaa';

  @override
  String get fileAccessDenied => 'Kar choul dak min trov ban anunhhat';

  @override
  String get clearRecentFiles => 'Somat aeksaa tmey';

  @override
  String get cancel => 'Loeuk leng';

  @override
  String get confirm => 'Banghanh';

  @override
  String get error => 'Khoh';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Aeksaa';

  @override
  String get menuOpen => 'Berk...';

  @override
  String get menuOpenRecent => 'Berk tmey';

  @override
  String get menuNoRecentFiles => 'Kmean aeksaa tmey';

  @override
  String get menuClearMenu => 'Somat menu';

  @override
  String get menuSave => 'Tuktuk';

  @override
  String get menuSaveAs => 'Tuktuk chea...';

  @override
  String get menuSaveAll => 'រក្សាទុកទាំងអស់';

  @override
  String get menuShare => 'Chek ruum...';

  @override
  String get menuCloseWindow => 'But baong aas';

  @override
  String get menuCloseAll => 'បិទទាំងអស់';

  @override
  String get menuQuit => 'ចាកចេញពី PDFSign';

  @override
  String get closeAllDialogTitle => 'រក្សាទុកការផ្លាស់ប្តូរ?';

  @override
  String closeAllDialogMessage(int count) {
    return 'តើអ្នកចង់រក្សាទុកការផ្លាស់ប្តូរក្នុងឯកសារ $count មុនពេលបិទទេ?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'តើអ្នកចង់រក្សាទុកការផ្លាស់ប្តូរក្នុងឯកសារ 1 មុនពេលបិទទេ?';

  @override
  String get closeAllDialogSaveAll => 'រក្សាទុកទាំងអស់';

  @override
  String get closeAllDialogDontSave => 'កុំរក្សាទុក';

  @override
  String get closeAllDialogCancel => 'បោះបង់';

  @override
  String get saveFailedDialogTitle => 'រក្សាទុកបរាជ័យ';

  @override
  String saveFailedDialogMessage(int count) {
    return 'បរាជ័យក្នុងការរក្សាទុក $count ឯកសារ។ បិទទោះយ៉ាងណា?';
  }

  @override
  String get saveFailedDialogClose => 'បិទទោះយ៉ាងណា';

  @override
  String get saveChangesTitle => 'Tuktuk kar phlash phder?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Tae anak chong tuktuk kar phlash phder knong \"$fileName\" muon pel but?';
  }

  @override
  String get saveButton => 'Tuktuk';

  @override
  String get discardButton => 'Kum tuktuk';

  @override
  String get documentEdited => 'Kae samruel';

  @override
  String get documentSaved => 'Trov ban tuktuk';

  @override
  String get menuSettings => 'Kar kat tong...';

  @override
  String get menuWindow => 'បង្អួច';

  @override
  String get menuMinimize => 'បង្រួម';

  @override
  String get menuZoom => 'ពង្រីក';

  @override
  String get menuBringAllToFront => 'នាំទាំងអស់មកមុខ';

  @override
  String get settingsTitle => 'Kar kat tong';

  @override
  String get settingsLanguage => 'Pheasaa';

  @override
  String get settingsLanguageSystem => 'Propanh robos brapon';

  @override
  String get settingsUnits => 'Akhphmaan';

  @override
  String get settingsUnitsCentimeters => 'Saangtimaet';

  @override
  String get settingsUnitsInches => 'Aengh';

  @override
  String get settingsUnitsDefault => 'លំនាំដើម (តាមតំបន់)';

  @override
  String get settingsSearchLanguages => 'ស្វែងរកភាសា...';

  @override
  String get settingsGeneral => 'ទូទៅ';

  @override
  String get addImage => 'បន្ថែមរូបភាព';

  @override
  String get selectImages => 'ជ្រើសរើសរូបភាព';

  @override
  String get zoomFitWidth => 'សម្រួលតាមទទឹង';

  @override
  String get zoomIn => 'ពង្រីក';

  @override
  String get zoomOut => 'បង្រួម';

  @override
  String get selectZoomLevel => 'ជ្រើសរើសកម្រិតពង្រីក';

  @override
  String get goToPage => 'ទៅទំព័រ';

  @override
  String get go => 'ទៅ';

  @override
  String get savePdfAs => 'រក្សាទុក PDF ជា';

  @override
  String get incorrectPassword => 'ពាក្យសម្ងាត់មិនត្រឹមត្រូវ';

  @override
  String get saveFailed => 'រក្សាទុកបរាជ័យ';

  @override
  String savedTo(String path) {
    return 'បានរក្សាទុកនៅ: $path';
  }

  @override
  String get noOriginalPdfStored => 'គ្មាន PDF ដើមត្រូវបានរក្សាទុក';

  @override
  String get waitingForFolderPermission => 'កំពុងរង់ចាំការអនុញ្ញាតចូលប្រើថត...';

  @override
  String get emptyRecentFiles => 'បើកឯកសារដើម្បីចាប់ផ្តើម';

  @override
  String get imagesTitle => 'រូបភាព';

  @override
  String get noImagesYet => 'មិនទាន់មានរូបភាពទេ';

  @override
  String get noImagesHint => 'ចុច + ដើម្បីបន្ថែមត្រា ឬហត្ថលេខាដំបូងរបស់អ្នក';

  @override
  String get done => 'រួចរាល់';

  @override
  String get menuEdit => 'កែសម្រួល';

  @override
  String get chooseFromFiles => 'ជ្រើសរើសពីឯកសារ';

  @override
  String get chooseFromGallery => 'ជ្រើសរើសពីវិចិត្រសាល';

  @override
  String get imageTooBig => 'រូបភាពធំពេក (អតិបរមា 50 MB)';

  @override
  String get imageResolutionTooHigh => 'គុណភាពខ្ពស់ពេក (អតិបរមា 4096×4096)';

  @override
  String get unsupportedImageFormat => 'ទម្រង់រូបភាពមិនគាំទ្រ';

  @override
  String get deleteTooltip => 'លុប';

  @override
  String get shareTooltip => 'ចែករំលែក';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'ទំព័រ $currentPage នៃ $totalPages';
  }

  @override
  String get noDocumentLoaded => 'គ្មានឯកសារត្រូវបានផ្ទុក';

  @override
  String get failedToLoadPdf => 'បរាជ័យក្នុងការផ្ទុក PDF';

  @override
  String get passwordRequired => 'ត្រូវការពាក្យសម្ងាត់';

  @override
  String get pdfPasswordProtected => 'PDF នេះត្រូវបានការពារដោយពាក្យសម្ងាត់។';

  @override
  String errorWithMessage(String message) {
    return 'កំហុស: $message';
  }

  @override
  String get unsavedChangesTitle => 'ការផ្លាស់ប្តូរដែលមិនបានរក្សាទុក';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'តើអ្នកចង់រក្សាទុកការផ្លាស់ប្តូរនៅក្នុង \"$fileName\" ទេ?';
  }

  @override
  String get onboardingOpenPdf => 'ចុចដើម្បីបើកឯកសារ PDF';

  @override
  String get onboardingSwipeUp => 'អូសឡើងលើដើម្បីបន្ថែមហត្ថលេខា និងត្រា';

  @override
  String get onboardingAddImage => 'ចុចដើម្បីបន្ថែមហត្ថលេខា ឬត្រាដំបូងរបស់អ្នក';

  @override
  String get onboardingDragImage => 'អូសទៅ PDF ដើម្បីដាក់វា';

  @override
  String get onboardingResizeObject =>
      'ចុចដើម្បីជ្រើសរើស។ អូសជ្រុងដើម្បីប្តូរទំហំ។';

  @override
  String get onboardingDeleteImage => 'ចុចដើម្បីលុបរូបភាពដែលបានជ្រើសរើស';

  @override
  String get onboardingTapToContinue => 'ចុចកន្លែងណាមួយដើម្បីបន្ត';

  @override
  String get imageConversionFailed => 'បរាជ័យក្នុងការបំប្លែងរូបភាពទៅជា PDF';

  @override
  String get saveDocumentTitle => 'រក្សាទុកឯកសារ';

  @override
  String get fileNameLabel => 'ឈ្មោះឯកសារ';

  @override
  String get defaultFileName => 'ឯកសារ';

  @override
  String get onlyOnePdfAllowed => 'អាចបើកបានតែ PDF មួយក្នុងមួយពេល';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'ឯកសារ PDF ត្រូវបានមិនអើពើ។ បំប្លែងរូបភាពតែប៉ុណ្ណោះ។';

  @override
  String convertingImages(int count) {
    return 'កំពុងបំប្លែង $count រូបភាព...';
  }
}
