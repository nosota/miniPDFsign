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
  String get selectPdf => 'फ़ाइल खोलें';

  @override
  String get untitledDocument => 'बिना शीर्षक.pdf';

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
  String get settingsUnitsDefault => 'डिफ़ॉल्ट (क्षेत्र के अनुसार)';

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

  @override
  String get emptyRecentFiles => 'शुरू करने के लिए फ़ाइल खोलें';

  @override
  String get imagesTitle => 'छवियां';

  @override
  String get noImagesYet => 'अभी तक कोई छवि नहीं';

  @override
  String get noImagesHint =>
      'अपनी पहली मुहर या हस्ताक्षर जोड़ने के लिए + टैप करें';

  @override
  String get done => 'हो गया';

  @override
  String get menuEdit => 'संपादित करें';

  @override
  String get chooseFromFiles => 'फ़ाइलों से चुनें';

  @override
  String get chooseFromGallery => 'गैलरी से चुनें';

  @override
  String get imageTooBig => 'छवि बहुत बड़ी है (अधिकतम 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'रिज़ॉल्यूशन बहुत अधिक है (अधिकतम 4096×4096)';

  @override
  String get unsupportedImageFormat => 'असमर्थित छवि प्रारूप';

  @override
  String get deleteTooltip => 'हटाएं';

  @override
  String get shareTooltip => 'साझा करें';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'पृष्ठ $currentPage का $totalPages';
  }

  @override
  String get noDocumentLoaded => 'कोई दस्तावेज़ लोड नहीं हुआ';

  @override
  String get failedToLoadPdf => 'PDF लोड करने में विफल';

  @override
  String get passwordRequired => 'पासवर्ड आवश्यक है';

  @override
  String get pdfPasswordProtected => 'यह PDF पासवर्ड से सुरक्षित है।';

  @override
  String errorWithMessage(String message) {
    return 'त्रुटि: $message';
  }

  @override
  String get unsavedChangesTitle => 'असहेजे गए परिवर्तन';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'क्या आप \"$fileName\" में परिवर्तन सहेजना चाहते हैं?';
  }

  @override
  String get onboardingOpenPdf => 'PDF दस्तावेज़ खोलने के लिए टैप करें';

  @override
  String get onboardingSwipeUp =>
      'हस्ताक्षर और मुहरें जोड़ने के लिए ऊपर स्वाइप करें';

  @override
  String get onboardingAddImage =>
      'अपना पहला हस्ताक्षर या मुहर जोड़ने के लिए टैप करें';

  @override
  String get onboardingDragImage => 'इसे रखने के लिए PDF पर खींचें';

  @override
  String get onboardingResizeObject =>
      'चुनने के लिए टैप करें। आकार बदलने के लिए कोनों को खींचें।';

  @override
  String get onboardingDeleteImage => 'चयनित छवि को हटाने के लिए टैप करें';

  @override
  String get onboardingTapToContinue => 'जारी रखने के लिए कहीं भी टैप करें';

  @override
  String get imageConversionFailed => 'छवि को PDF में बदलने में विफल';

  @override
  String get saveDocumentTitle => 'दस्तावेज़ सहेजें';

  @override
  String get fileNameLabel => 'फ़ाइल का नाम';

  @override
  String get defaultFileName => 'दस्तावेज़';

  @override
  String get onlyOnePdfAllowed => 'एक समय में केवल एक PDF खोली जा सकती है';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF फ़ाइलें अनदेखा की गईं। केवल छवियां परिवर्तित की जाती हैं।';

  @override
  String convertingImages(int count) {
    return '$count छवियां परिवर्तित हो रही हैं...';
  }

  @override
  String get takePhoto => 'फ़ोटो लें';

  @override
  String get removeBackgroundTitle => 'पृष्ठभूमि हटाएं?';

  @override
  String get removeBackgroundMessage =>
      'क्या आप पृष्ठभूमि हटाकर उसे पारदर्शी बनाना चाहते हैं?';

  @override
  String get removeBackground => 'हटाएं';

  @override
  String get keepOriginal => 'रखें';

  @override
  String get processingImage => 'छवि संसाधित हो रही है...';

  @override
  String get backgroundRemovalFailed => 'पृष्ठभूमि हटाने में विफल';

  @override
  String get passwordLabel => 'पासवर्ड';

  @override
  String get unlockButton => 'अनलॉक करें';
}
