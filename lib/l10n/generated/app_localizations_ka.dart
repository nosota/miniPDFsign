// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Georgian (`ka`).
class AppLocalizationsKa extends AppLocalizations {
  AppLocalizationsKa([String locale = 'ka']) : super(locale);

  @override
  String get openPdf => 'PDF-is gakhsna';

  @override
  String get selectPdf => 'ფაილის გახსნა';

  @override
  String get untitledDocument => 'უსათაურო.pdf';

  @override
  String get recentFiles => 'bolodroindfeli failebi';

  @override
  String get removeFromList => 'siidan amoshla';

  @override
  String get openedNow => 'akhla gakhsnili';

  @override
  String openedMinutesAgo(int count) {
    return 'gakhsnili $count tsutis tsin';
  }

  @override
  String openedHoursAgo(int count) {
    return 'gakhsnili $count saatis tsin';
  }

  @override
  String get openedYesterday => 'gakhsnili gushin';

  @override
  String openedDaysAgo(int count) {
    return 'gakhsnili $count dghis tsin';
  }

  @override
  String get fileNotFound => 'faili ver moidzebna';

  @override
  String get fileAccessDenied => 'tsvrda akridzalulia';

  @override
  String get clearRecentFiles => 'bolodroindfeli failebis gasuptaveba';

  @override
  String get cancel => 'gaukmeba';

  @override
  String get confirm => 'dadastureba';

  @override
  String get error => 'shecdoma';

  @override
  String get ok => 'karghi';

  @override
  String get menuFile => 'Faili';

  @override
  String get menuOpen => 'Gakhsna...';

  @override
  String get menuOpenRecent => 'Bolodroindfeli';

  @override
  String get menuNoRecentFiles => 'Ar aris bolodroindfeli failebi';

  @override
  String get menuClearMenu => 'Meniuis gasuptaveba';

  @override
  String get menuSave => 'Shenakhva';

  @override
  String get menuSaveAs => 'Shenakhva rogorc...';

  @override
  String get menuSaveAll => 'ყველას შენახვა';

  @override
  String get menuShare => 'Gaziareba...';

  @override
  String get menuCloseWindow => 'Panjeris dakhetva';

  @override
  String get menuCloseAll => 'ყველას დახურვა';

  @override
  String get menuQuit => 'გასვლა PDFSign-დან';

  @override
  String get closeAllDialogTitle => 'ცვლილებების შენახვა?';

  @override
  String closeAllDialogMessage(int count) {
    return 'გსურთ შეინახოთ ცვლილებები $count დოკუმენტში დახურვამდე?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'გსურთ შეინახოთ ცვლილებები 1 დოკუმენტში დახურვამდე?';

  @override
  String get closeAllDialogSaveAll => 'ყველას შენახვა';

  @override
  String get closeAllDialogDontSave => 'არ შეინახო';

  @override
  String get closeAllDialogCancel => 'გაუქმება';

  @override
  String get saveFailedDialogTitle => 'შენახვა ვერ მოხერხდა';

  @override
  String saveFailedDialogMessage(int count) {
    return 'ვერ მოხერხდა $count დოკუმენტის შენახვა. მაინც დაიხუროს?';
  }

  @override
  String get saveFailedDialogClose => 'მაინც დახურვა';

  @override
  String get saveChangesTitle => 'Cvlilebebis shenakhva?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Gindakht shenakhat cvlilebebi \"$fileName\"-shi dakhetvamdfe?';
  }

  @override
  String get saveButton => 'Shenakhva';

  @override
  String get discardButton => 'Gaukmeba';

  @override
  String get documentEdited => 'Redaktrebuli';

  @override
  String get documentSaved => 'Shenakhuli';

  @override
  String get menuSettings => 'Parametrebi...';

  @override
  String get menuWindow => 'ფანჯარა';

  @override
  String get menuMinimize => 'შემცირება';

  @override
  String get menuZoom => 'მასშტაბირება';

  @override
  String get menuBringAllToFront => 'ყველას წინ მოტანა';

  @override
  String get settingsTitle => 'Parametrebi';

  @override
  String get settingsLanguage => 'Ena';

  @override
  String get settingsLanguageSystem => 'Sistemis nagulistseti';

  @override
  String get settingsUnits => 'Erteuelebi';

  @override
  String get settingsUnitsCentimeters => 'Santimetrebi';

  @override
  String get settingsUnitsInches => 'Diumebi';

  @override
  String get settingsSearchLanguages => 'ენების ძიება...';

  @override
  String get settingsGeneral => 'ზოგადი';

  @override
  String get addImage => 'სურათის დამატება';

  @override
  String get selectImages => 'სურათების არჩევა';

  @override
  String get zoomFitWidth => 'სიგანეზე მორგება';

  @override
  String get zoomIn => 'გადიდება';

  @override
  String get zoomOut => 'შემცირება';

  @override
  String get selectZoomLevel => 'მასშტაბის არჩევა';

  @override
  String get goToPage => 'გვერდზე გადასვლა';

  @override
  String get go => 'გადასვლა';

  @override
  String get savePdfAs => 'PDF-ის შენახვა როგორც';

  @override
  String get incorrectPassword => 'არასწორი პაროლი';

  @override
  String get saveFailed => 'შენახვა ვერ მოხერხდა';

  @override
  String savedTo(String path) {
    return 'შენახულია: $path';
  }

  @override
  String get noOriginalPdfStored => 'ორიგინალი PDF არ არის შენახული';

  @override
  String get waitingForFolderPermission =>
      'საქაღალდეზე წვდომის ნებართვის მოლოდინი...';

  @override
  String get emptyRecentFiles => 'გახსენით ფაილი დასაწყებად';

  @override
  String get imagesTitle => 'სურათები';

  @override
  String get noImagesYet => 'ჯერ არ არის სურათები';

  @override
  String get noImagesHint =>
      'შეეხეთ + თქვენი პირველი ბეჭდის ან ხელმოწერის დასამატებლად';

  @override
  String get done => 'დასრულდა';

  @override
  String get menuEdit => 'რედაქტირება';

  @override
  String get chooseFromFiles => 'აირჩიეთ ფაილებიდან';

  @override
  String get chooseFromGallery => 'აირჩიეთ გალერეიდან';

  @override
  String get imageTooBig => 'სურათი ძალიან დიდია (მაქს. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'გარჩევადობა ძალიან მაღალია (მაქს. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'მხარდაუჭერელი სურათის ფორმატი';

  @override
  String get deleteTooltip => 'წაშლა';

  @override
  String get shareTooltip => 'გაზიარება';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'გვერდი $currentPage / $totalPages';
  }

  @override
  String get noDocumentLoaded => 'დოკუმენტი არ არის ჩატვირთული';

  @override
  String get failedToLoadPdf => 'PDF-ის ჩატვირთვა ვერ მოხერხდა';

  @override
  String get passwordRequired => 'პაროლი საჭიროა';

  @override
  String get pdfPasswordProtected => 'ეს PDF პაროლით დაცულია.';

  @override
  String errorWithMessage(String message) {
    return 'შეცდომა: $message';
  }

  @override
  String get unsavedChangesTitle => 'შეუნახავი ცვლილებები';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'გსურთ შეინახოთ ცვლილებები \"$fileName\"-ში?';
  }

  @override
  String get onboardingOpenPdf => 'შეეხეთ PDF დოკუმენტის გასახსნელად';

  @override
  String get onboardingSwipeUp =>
      'გადაფურცლეთ ზემოთ ხელმოწერებისა და ბეჭდების დასამატებლად';

  @override
  String get onboardingAddImage =>
      'შეეხეთ თქვენი პირველი ხელმოწერის ან ბეჭდის დასამატებლად';

  @override
  String get onboardingDragImage => 'გადაიტანეთ PDF-ზე განსათავსებლად';

  @override
  String get onboardingResizeObject =>
      'შეეხეთ ასარჩევად. გადაიტანეთ კუთხეები ზომის შესაცვლელად.';

  @override
  String get onboardingDeleteImage => 'შეეხეთ არჩეული სურათის წასაშლელად';

  @override
  String get onboardingTapToContinue =>
      'შეეხეთ ნებისმიერ ადგილას გასაგრძელებლად';

  @override
  String get imageConversionFailed => 'სურათის PDF-ში გარდაქმნა ვერ მოხერხდა';

  @override
  String get saveDocumentTitle => 'დოკუმენტის შენახვა';

  @override
  String get fileNameLabel => 'ფაილის სახელი';

  @override
  String get defaultFileName => 'დოკუმენტი';

  @override
  String get onlyOnePdfAllowed =>
      'ერთდროულად მხოლოდ ერთი PDF შეიძლება გაიხსნას';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF ფაილები უგულებელყოფილია. მხოლოდ სურათები გარდაიქმნება.';
}
