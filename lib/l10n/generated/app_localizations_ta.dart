// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get openPdf => 'PDF thira';

  @override
  String get selectPdf => 'கோப்பைத் திற';

  @override
  String get untitledDocument => 'தலைப்பிடாத.pdf';

  @override
  String get recentFiles => 'Samipattiya koapugal';

  @override
  String get removeFromList => 'Pattiyal irunthu neekkavu';

  @override
  String get openedNow => 'Ippothuthan thirakkappattatu';

  @override
  String openedMinutesAgo(int count) {
    return '$count nimidam munpu thirakkappattatu';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count mani neram munpu thirakkappattatu';
  }

  @override
  String get openedYesterday => 'Netru thirakkappattatu';

  @override
  String openedDaysAgo(int count) {
    return '$count natkal munpu thirakkappattatu';
  }

  @override
  String get fileNotFound => 'Koapu kandupidikkavillai';

  @override
  String get fileAccessDenied => 'Anugal maruppu';

  @override
  String get clearRecentFiles => 'Samipattiya koapugalai azhikka';

  @override
  String get cancel => 'Raththu seiva';

  @override
  String get confirm => 'Uruthi seyya';

  @override
  String get error => 'Pizhiai';

  @override
  String get ok => 'Sari';

  @override
  String get menuFile => 'Koapu';

  @override
  String get menuOpen => 'Thira...';

  @override
  String get menuOpenRecent => 'Samipattiya thira';

  @override
  String get menuNoRecentFiles => 'Samipattiya koapugal illai';

  @override
  String get menuClearMenu => 'Menyuvai azhikka';

  @override
  String get menuSave => 'Semiykka';

  @override
  String get menuSaveAs => 'Veraraga semiykkavu...';

  @override
  String get menuSaveAll => 'அனைத்தையும் சேமிக்கவும்';

  @override
  String get menuShare => 'Pakirvu...';

  @override
  String get menuCloseWindow => 'Jannal muda';

  @override
  String get menuCloseAll => 'அனைத்தையும் மூடு';

  @override
  String get menuQuit => 'PDFSign-இலிருந்து வெளியேறு';

  @override
  String get closeAllDialogTitle => 'மாற்றங்களை சேமிக்கவா?';

  @override
  String closeAllDialogMessage(int count) {
    return 'மூடுவதற்கு முன் $count ஆவணங்களில் மாற்றங்களை சேமிக்க விரும்புகிறீர்களா?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'மூடுவதற்கு முன் 1 ஆவணத்தில் மாற்றங்களை சேமிக்க விரும்புகிறீர்களா?';

  @override
  String get closeAllDialogSaveAll => 'அனைத்தையும் சேமி';

  @override
  String get closeAllDialogDontSave => 'சேமிக்க வேண்டாம்';

  @override
  String get closeAllDialogCancel => 'ரத்து செய்';

  @override
  String get saveFailedDialogTitle => 'சேமிப்பு தோல்வி';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count ஆவணங்களைச் சேமிக்க முடியவில்லை. எப்படியும் மூடவா?';
  }

  @override
  String get saveFailedDialogClose => 'எப்படியும் மூடு';

  @override
  String get saveChangesTitle => 'Marrrangalai semikkava?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Muduvathikku munpu \"$fileName\" koapil marrrangalai semikka virumpukirayrka?';
  }

  @override
  String get saveButton => 'Semiykka';

  @override
  String get discardButton => 'Vidu';

  @override
  String get documentEdited => 'Thirutappattatu';

  @override
  String get documentSaved => 'Semikkappattathu';

  @override
  String get menuSettings => 'Amaikpugal...';

  @override
  String get menuWindow => 'சாளரம்';

  @override
  String get menuMinimize => 'சிறியதாக்கு';

  @override
  String get menuZoom => 'பெரிதாக்கு';

  @override
  String get menuBringAllToFront => 'அனைத்தையும் முன்னே கொண்டுவா';

  @override
  String get settingsTitle => 'Amaikpugal';

  @override
  String get settingsLanguage => 'Mozhli';

  @override
  String get settingsLanguageSystem => 'Amaippu default';

  @override
  String get settingsUnits => 'Alagu';

  @override
  String get settingsUnitsCentimeters => 'Sentimeettar';

  @override
  String get settingsUnitsInches => 'Inchu';

  @override
  String get settingsUnitsDefault => 'இயல்புநிலை (பகுதி வாரியாக)';

  @override
  String get settingsSearchLanguages => 'மொழிகளைத் தேடு...';

  @override
  String get settingsGeneral => 'பொது';

  @override
  String get addImage => 'படம் சேர்';

  @override
  String get selectImages => 'படங்களைத் தேர்ந்தெடு';

  @override
  String get zoomFitWidth => 'அகலத்திற்கு பொருத்து';

  @override
  String get zoomIn => 'பெரிதாக்கு';

  @override
  String get zoomOut => 'சிறிதாக்கு';

  @override
  String get selectZoomLevel => 'பெரிதாக்க நிலையைத் தேர்ந்தெடு';

  @override
  String get goToPage => 'பக்கத்திற்குச் செல்';

  @override
  String get go => 'செல்';

  @override
  String get savePdfAs => 'PDF ஆக சேமி';

  @override
  String get incorrectPassword => 'தவறான கடவுச்சொல்';

  @override
  String get saveFailed => 'சேமிப்பு தோல்வி';

  @override
  String savedTo(String path) {
    return 'சேமிக்கப்பட்டது: $path';
  }

  @override
  String get noOriginalPdfStored => 'அசல் PDF சேமிக்கப்படவில்லை';

  @override
  String get waitingForFolderPermission =>
      'கோப்புறை அணுகல் அனுமதிக்காக காத்திருக்கிறது...';

  @override
  String get emptyRecentFiles => 'தொடங்க கோப்பைத் திறக்கவும்';

  @override
  String get imagesTitle => 'படங்கள்';

  @override
  String get noImagesYet => 'இன்னும் படங்கள் இல்லை';

  @override
  String get noImagesHint =>
      'உங்கள் முதல் முத்திரை அல்லது கையொப்பத்தைச் சேர்க்க + தட்டவும்';

  @override
  String get done => 'முடிந்தது';

  @override
  String get menuEdit => 'திருத்து';

  @override
  String get chooseFromFiles => 'கோப்புகளிலிருந்து தேர்வு';

  @override
  String get chooseFromGallery => 'தொகுப்பிலிருந்து தேர்வு';

  @override
  String get imageTooBig => 'படம் மிகப்பெரியது (அதிகபட்சம் 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'தெளிவுத்திறன் மிக அதிகம் (அதிகபட்சம் 4096×4096)';

  @override
  String get unsupportedImageFormat => 'ஆதரிக்கப்படாத பட வடிவம்';

  @override
  String get deleteTooltip => 'நீக்கு';

  @override
  String get shareTooltip => 'பகிர்';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'பக்கம் $currentPage / $totalPages';
  }

  @override
  String get noDocumentLoaded => 'ஆவணம் ஏற்றப்படவில்லை';

  @override
  String get failedToLoadPdf => 'PDF ஏற்றுவதில் தோல்வி';

  @override
  String get passwordRequired => 'கடவுச்சொல் தேவை';

  @override
  String get pdfPasswordProtected => 'இந்த PDF கடவுச்சொல் பாதுகாக்கப்பட்டது.';

  @override
  String errorWithMessage(String message) {
    return 'பிழை: $message';
  }

  @override
  String get unsavedChangesTitle => 'சேமிக்கப்படாத மாற்றங்கள்';

  @override
  String unsavedChangesMessage(String fileName) {
    return '\"$fileName\" இல் மாற்றங்களைச் சேமிக்க விரும்புகிறீர்களா?';
  }

  @override
  String get onboardingOpenPdf => 'PDF ஆவணத்தைத் திறக்க தட்டவும்';

  @override
  String get onboardingSwipeUp =>
      'கையொப்பங்கள் மற்றும் முத்திரைகளைச் சேர்க்க மேலே ஸ்வைப் செய்யவும்';

  @override
  String get onboardingAddImage =>
      'உங்கள் முதல் கையொப்பம் அல்லது முத்திரையைச் சேர்க்க தட்டவும்';

  @override
  String get onboardingDragImage => 'வைக்க PDF மீது இழுக்கவும்';

  @override
  String get onboardingResizeObject =>
      'தேர்ந்தெடுக்க தட்டவும். அளவை மாற்ற மூலைகளை இழுக்கவும்.';

  @override
  String get onboardingDeleteImage =>
      'தேர்ந்தெடுக்கப்பட்ட படத்தை நீக்க தட்டவும்';

  @override
  String get onboardingTapToContinue => 'தொடர எங்கு வேண்டுமானாலும் தட்டவும்';

  @override
  String get imageConversionFailed => 'படத்தை PDF ஆக மாற்ற முடியவில்லை';

  @override
  String get saveDocumentTitle => 'ஆவணத்தை சேமி';

  @override
  String get fileNameLabel => 'கோப்பு பெயர்';

  @override
  String get defaultFileName => 'ஆவணம்';

  @override
  String get onlyOnePdfAllowed =>
      'ஒரு நேரத்தில் ஒரே PDF மட்டுமே திறக்க முடியும்';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF கோப்புகள் புறக்கணிக்கப்பட்டன. படங்கள் மட்டுமே மாற்றப்படுகின்றன.';

  @override
  String convertingImages(int count) {
    return '$count படங்களை மாற்றுகிறது...';
  }

  @override
  String get takePhoto => 'புகைப்படம் எடு';

  @override
  String get removeBackgroundTitle => 'பின்னணியை நீக்கவா?';

  @override
  String get removeBackgroundMessage =>
      'பின்னணியை நீக்கி வெளிப்படையாக்க விரும்புகிறீர்களா?';

  @override
  String get removeBackground => 'நீக்கு';

  @override
  String get keepOriginal => 'வைத்திரு';

  @override
  String get processingImage => 'படம் செயலாக்கப்படுகிறது...';

  @override
  String get backgroundRemovalFailed => 'பின்னணியை நீக்க முடியவில்லை';

  @override
  String get passwordLabel => 'கடவுச்சொல்';

  @override
  String get unlockButton => 'திறக்கவும்';

  @override
  String get pasteFromClipboard => 'கிளிப்போர்டிலிருந்து ஒட்டுக';

  @override
  String get noImageInClipboard =>
      'கிளிப்போர்டில் படம் இல்லை. முதலில் ஒரு படத்தை நகலெடுக்கவும்.';

  @override
  String get imageDuplicated => 'படம் நகலெடுக்கப்பட்டது';
}
