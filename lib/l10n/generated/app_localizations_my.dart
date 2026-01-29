// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get openPdf => 'PDF phwint';

  @override
  String get selectPdf => 'PDF rwe';

  @override
  String get recentFiles => 'Makhawkamhar file myar';

  @override
  String get removeFromList => 'Saryin hma hpyout';

  @override
  String get openedNow => 'Achu phwint lite';

  @override
  String openedMinutesAgo(int count) {
    return 'Minit $count u gar phwint';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Nari $count u gar phwint';
  }

  @override
  String get openedYesterday => 'Mahnekaun phwint';

  @override
  String openedDaysAgo(int count) {
    return 'Rout $count u gar phwint';
  }

  @override
  String get fileNotFound => 'File mar shi';

  @override
  String get fileAccessDenied => 'Win khwint mar rhi';

  @override
  String get clearRecentFiles => 'Makhawkamhar file myar ko shot';

  @override
  String get cancel => 'Pyet';

  @override
  String get confirm => 'Atint pyuu';

  @override
  String get error => 'Arhar';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Phwint...';

  @override
  String get menuOpenRecent => 'Makhawkamhar phwint';

  @override
  String get menuNoRecentFiles => 'Makhawkamhar file myar mar rhi';

  @override
  String get menuClearMenu => 'Menu ko shot';

  @override
  String get menuSave => 'Thein';

  @override
  String get menuSaveAs => 'Aloat thein...';

  @override
  String get menuSaveAll => 'အားလုံးသိမ်းဆည်းပါ';

  @override
  String get menuShare => 'Mhway vway...';

  @override
  String get menuCloseWindow => 'Window peit';

  @override
  String get menuCloseAll => 'အားလုံးပိတ်ရန်';

  @override
  String get menuQuit => 'PDFSign မှထွက်ရန်';

  @override
  String get closeAllDialogTitle => 'ပြောင်းလဲမှုများသိမ်းမလား?';

  @override
  String closeAllDialogMessage(int count) {
    return 'မပိတ်မီ စာရွက်စာတမ်း $count ခုတွင် ပြောင်းလဲမှုများကို သိမ်းဆည်းလိုပါသလား?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'မပိတ်မီ စာရွက်စာတမ်း 1 ခုတွင် ပြောင်းလဲမှုများကို သိမ်းဆည်းလိုပါသလား?';

  @override
  String get closeAllDialogSaveAll => 'အားလုံးသိမ်းရန်';

  @override
  String get closeAllDialogDontSave => 'မသိမ်းပါ';

  @override
  String get closeAllDialogCancel => 'ပယ်ဖျက်ရန်';

  @override
  String get saveFailedDialogTitle => 'သိမ်းဆည်းခြင်း မအောင်မြင်ပါ';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count စာရွက်စာတမ်း သိမ်းဆည်းခြင်း မအောင်မြင်ပါ။ ဘာပဲဖြစ်ဖြစ် ပိတ်မလား?';
  }

  @override
  String get saveFailedDialogClose => 'ဘာပဲဖြစ်ဖြစ် ပိတ်ပါ';

  @override
  String get saveChangesTitle => 'Pyaunglevmhuu thein malar?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Mapeitmhin \"$fileName\" hta pyaunglevmhuu thein larmalar?';
  }

  @override
  String get saveButton => 'Thein';

  @override
  String get discardButton => 'Ma thein';

  @override
  String get documentEdited => 'Pyifjyifpyi';

  @override
  String get documentSaved => 'Thein pyi';

  @override
  String get menuSettings => 'Setting myar...';

  @override
  String get menuWindow => 'ဝင်းဒိုး';

  @override
  String get menuMinimize => 'ချုံ့ရန်';

  @override
  String get menuZoom => 'ချဲ့ရန်';

  @override
  String get menuBringAllToFront => 'အားလုံးကိုရှေ့သို့ယူလာရန်';

  @override
  String get settingsTitle => 'Setting myar';

  @override
  String get settingsLanguage => 'Bhashar zagar';

  @override
  String get settingsLanguageSystem => 'System mhuu run';

  @override
  String get settingsUnits => 'Tinetunit myar';

  @override
  String get settingsUnitsCentimeters => 'Centimeter';

  @override
  String get settingsUnitsInches => 'Inch';

  @override
  String get settingsSearchLanguages => 'ဘာသာစကား ရှာရန်...';

  @override
  String get settingsGeneral => 'အထွေထွေ';

  @override
  String get addImage => 'ပုံထည့်ရန်';

  @override
  String get selectImages => 'ပုံများရွေးရန်';

  @override
  String get zoomFitWidth => 'အကျယ်နဲ့ကိုက်ညီအောင်';

  @override
  String get zoomIn => 'ချဲ့ကြည့်ရန်';

  @override
  String get zoomOut => 'ချုံ့ကြည့်ရန်';

  @override
  String get selectZoomLevel => 'ချဲ့/ချုံ့အဆင့်ရွေးရန်';

  @override
  String get goToPage => 'စာမျက်နှာသို့သွားရန်';

  @override
  String get go => 'သွားရန်';

  @override
  String get savePdfAs => 'PDF အဖြစ်သိမ်းရန်';

  @override
  String get incorrectPassword => 'စကားဝှက်မှားနေသည်';

  @override
  String get saveFailed => 'သိမ်းဆည်းမှုမအောင်မြင်ပါ';

  @override
  String savedTo(String path) {
    return 'သိမ်းဆည်းပြီး: $path';
  }

  @override
  String get noOriginalPdfStored => 'မူရင်း PDF မသိမ်းရသေးပါ';

  @override
  String get waitingForFolderPermission =>
      'ဖိုင်တွဲဝင်ရောက်ခွင့်အတွက်စောင့်ဆိုင်းနေသည်...';

  @override
  String get emptyRecentFiles => 'Sat lone hpyit PDF phwint';

  @override
  String get imagesTitle => 'ပုံများ';

  @override
  String get noImagesYet => 'ပုံများ မရှိသေးပါ';

  @override
  String get noImagesHint =>
      'သင့်ပထမဆုံး တံဆိပ် သို့မဟုတ် လက်မှတ်ထည့်ရန် + ကိုနှိပ်ပါ';

  @override
  String get done => 'ပြီးပြီ';

  @override
  String get menuEdit => 'တည်းဖြတ်';

  @override
  String get chooseFromFiles => 'ဖိုင်များမှရွေးချယ်ပါ';

  @override
  String get chooseFromGallery => 'ဂယ်လရီမှရွေးချယ်ပါ';

  @override
  String get imageTooBig => 'ပုံကြီးလွန်းသည် (အများဆုံး 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'ကြည်လင်ပြတ်သားမှုမြင့်လွန်းသည် (အများဆုံး 4096×4096)';

  @override
  String get unsupportedImageFormat => 'ပံ့ပိုးမထားသောပုံဖော်မတ်';

  @override
  String get deleteTooltip => 'ဖျက်ရန်';

  @override
  String get shareTooltip => 'မျှဝေရန်';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'စာမျက်နှာ $currentPage / $totalPages';
  }

  @override
  String get noDocumentLoaded => 'စာရွက်စာတမ်း မဖွင့်ရသေးပါ';

  @override
  String get failedToLoadPdf => 'PDF ဖွင့်ခြင်း မအောင်မြင်ပါ';

  @override
  String get passwordRequired => 'စကားဝှက် လိုအပ်သည်';

  @override
  String get pdfPasswordProtected => 'ဤ PDF သည် စကားဝှက်ဖြင့် ကာကွယ်ထားသည်။';

  @override
  String errorWithMessage(String message) {
    return 'အမှား: $message';
  }

  @override
  String get unsavedChangesTitle => 'မသိမ်းရသေးသော ပြောင်းလဲမှုများ';

  @override
  String unsavedChangesMessage(String fileName) {
    return '\"$fileName\" ရှိ ပြောင်းလဲမှုများကို သိမ်းဆည်းလိုပါသလား?';
  }

  @override
  String get onboardingOpenPdf => 'PDF စာရွက်စာတမ်းဖွင့်ရန် နှိပ်ပါ';

  @override
  String get onboardingSwipeUp =>
      'လက်မှတ်များနှင့် တံဆိပ်များထည့်ရန် အပေါ်သို့ပွတ်ဆွဲပါ';

  @override
  String get onboardingAddImage =>
      'သင့်ပထမဆုံး လက်မှတ် သို့မဟုတ် တံဆိပ်ထည့်ရန် နှိပ်ပါ';

  @override
  String get onboardingDragImage => 'နေရာချထားရန် PDF ပေါ်သို့ ဆွဲယူပါ';

  @override
  String get onboardingResizeObject =>
      'ရွေးချယ်ရန် နှိပ်ပါ။ အရွယ်အစားပြောင်းရန် ထောင့်များကို ဆွဲယူပါ။';

  @override
  String get onboardingDeleteImage => 'Tap to delete the selected image';

  @override
  String get onboardingTapToContinue => 'ဆက်လက်ရန် မည်သည့်နေရာတွင်မဆို နှိပ်ပါ';
}
