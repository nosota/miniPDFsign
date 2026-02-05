// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get openPdf => 'Open PDF';

  @override
  String get selectPdf => 'Open File';

  @override
  String get untitledDocument => 'Untitled.pdf';

  @override
  String get recentFiles => 'Recent Files';

  @override
  String get removeFromList => 'Remove from list';

  @override
  String get openedNow => 'Opened just now';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutes',
      one: 'minute',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hours',
      one: 'hour',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String get openedYesterday => 'Opened yesterday';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String get fileNotFound => 'File not found';

  @override
  String get fileAccessDenied => 'Access denied';

  @override
  String get clearRecentFiles => 'Clear recent files';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get error => 'Error';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Open...';

  @override
  String get menuOpenRecent => 'Open Recent';

  @override
  String get menuNoRecentFiles => 'No Recent Files';

  @override
  String get menuClearMenu => 'Clear Menu';

  @override
  String get menuSave => 'Save';

  @override
  String get menuSaveAs => 'Save As...';

  @override
  String get menuSaveAll => 'Save All';

  @override
  String get menuShare => 'Share...';

  @override
  String get menuCloseWindow => 'Close Window';

  @override
  String get menuCloseAll => 'Close All';

  @override
  String get menuQuit => 'Quit PDFSign';

  @override
  String get closeAllDialogTitle => 'Save Changes?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Do you want to save changes to $count documents before closing?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Do you want to save changes to 1 document before closing?';

  @override
  String get closeAllDialogSaveAll => 'Save All';

  @override
  String get closeAllDialogDontSave => 'Don\'t Save';

  @override
  String get closeAllDialogCancel => 'Cancel';

  @override
  String get saveFailedDialogTitle => 'Save Failed';

  @override
  String saveFailedDialogMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'documents',
      one: 'document',
    );
    return 'Failed to save $count $_temp0. Close anyway?';
  }

  @override
  String get saveFailedDialogClose => 'Close Anyway';

  @override
  String get saveChangesTitle => 'Save Changes?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Do you want to save changes to \"$fileName\" before closing?';
  }

  @override
  String get saveButton => 'Save';

  @override
  String get discardButton => 'Discard';

  @override
  String get documentEdited => 'Edited';

  @override
  String get documentSaved => 'Saved';

  @override
  String get menuSettings => 'Settings...';

  @override
  String get menuWindow => 'Window';

  @override
  String get menuMinimize => 'Minimize';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Bring All to Front';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'System Default';

  @override
  String get settingsUnits => 'Units';

  @override
  String get settingsUnitsCentimeters => 'Centimeters';

  @override
  String get settingsUnitsInches => 'Inches';

  @override
  String get settingsUnitsDefault => 'Default (by region)';

  @override
  String get settingsSearchLanguages => 'Search languages...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Add Image';

  @override
  String get selectImages => 'Select Images';

  @override
  String get zoomFitWidth => 'Fit Width';

  @override
  String get zoomIn => 'Zoom In';

  @override
  String get zoomOut => 'Zoom Out';

  @override
  String get selectZoomLevel => 'Select zoom level';

  @override
  String get goToPage => 'Go to Page';

  @override
  String get go => 'Go';

  @override
  String get savePdfAs => 'Save PDF As';

  @override
  String get incorrectPassword => 'Incorrect password';

  @override
  String get saveFailed => 'Save failed';

  @override
  String savedTo(String path) {
    return 'Saved to: $path';
  }

  @override
  String get noOriginalPdfStored => 'No original PDF stored';

  @override
  String get waitingForFolderPermission =>
      'Waiting for folder access permission...';

  @override
  String get emptyRecentFiles => 'Open a file to get started';

  @override
  String get imagesTitle => 'Images';

  @override
  String get noImagesYet => 'No images yet';

  @override
  String get noImagesHint => 'Tap + to add your first stamp or signature';

  @override
  String get done => 'Done';

  @override
  String get menuEdit => 'Edit';

  @override
  String get chooseFromFiles => 'Choose from Files';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get imageTooBig => 'Image is too large (max 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Image resolution is too high (max 4096x4096)';

  @override
  String get unsupportedImageFormat => 'Unsupported image format';

  @override
  String get deleteTooltip => 'Delete';

  @override
  String get shareTooltip => 'Share';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Page $currentPage of $totalPages';
  }

  @override
  String get noDocumentLoaded => 'No document loaded';

  @override
  String get failedToLoadPdf => 'Failed to load PDF';

  @override
  String get passwordRequired => 'Password Required';

  @override
  String get pdfPasswordProtected => 'This PDF is password protected.';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get unsavedChangesTitle => 'Unsaved Changes';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Do you want to save changes to \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Tap to open a PDF document';

  @override
  String get onboardingSwipeUp => 'Swipe up to add signatures and stamps';

  @override
  String get onboardingAddImage => 'Tap to add your first signature or stamp';

  @override
  String get onboardingDragImage => 'Drag onto PDF to place it';

  @override
  String get onboardingResizeObject => 'Tap to select. Drag corners to resize.';

  @override
  String get onboardingDeleteImage => 'Tap to delete the selected image';

  @override
  String get onboardingTapToContinue => 'Tap anywhere to continue';

  @override
  String get imageConversionFailed => 'Failed to convert image to PDF';

  @override
  String get saveDocumentTitle => 'Save Document';

  @override
  String get fileNameLabel => 'File name';

  @override
  String get defaultFileName => 'Document';

  @override
  String get onlyOnePdfAllowed => 'Only one PDF can be opened at a time';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF files were ignored. Converting images only.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images',
      one: 'image',
    );
    return 'Converting $count $_temp0...';
  }

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get removeBackgroundTitle => 'Remove Background?';

  @override
  String get removeBackgroundMessage =>
      'A uniform background was detected. Would you like to make it transparent?';

  @override
  String get removeBackground => 'Remove';

  @override
  String get keepOriginal => 'Keep';

  @override
  String get processingImage => 'Processing image...';

  @override
  String get backgroundRemovalFailed => 'Failed to remove background';
}

/// The translations for English, as used in Australia (`en_AU`).
class AppLocalizationsEnAu extends AppLocalizationsEn {
  AppLocalizationsEnAu() : super('en_AU');

  @override
  String get openPdf => 'Open PDF';

  @override
  String get selectPdf => 'Open File';

  @override
  String get untitledDocument => 'Untitled.pdf';

  @override
  String get recentFiles => 'Recent Files';

  @override
  String get removeFromList => 'Remove from list';

  @override
  String get openedNow => 'Opened just now';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutes',
      one: 'minute',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hours',
      one: 'hour',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String get openedYesterday => 'Opened yesterday';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String get fileNotFound => 'File not found';

  @override
  String get fileAccessDenied => 'Access denied';

  @override
  String get clearRecentFiles => 'Clear recent files';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get error => 'Error';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Open...';

  @override
  String get menuOpenRecent => 'Open Recent';

  @override
  String get menuNoRecentFiles => 'No Recent Files';

  @override
  String get menuClearMenu => 'Clear Menu';

  @override
  String get menuSave => 'Save';

  @override
  String get menuSaveAs => 'Save As...';

  @override
  String get menuSaveAll => 'Save All';

  @override
  String get menuShare => 'Share...';

  @override
  String get menuCloseWindow => 'Close Window';

  @override
  String get menuCloseAll => 'Close All';

  @override
  String get menuQuit => 'Quit PDFSign';

  @override
  String get closeAllDialogTitle => 'Save Changes?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Do you want to save changes in $count documents before closing?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Do you want to save changes in 1 document before closing?';

  @override
  String get closeAllDialogSaveAll => 'Save All';

  @override
  String get closeAllDialogDontSave => 'Don\'t Save';

  @override
  String get closeAllDialogCancel => 'Cancel';

  @override
  String get saveFailedDialogTitle => 'Save Failed';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Failed to save $count document(s). Close anyway?';
  }

  @override
  String get saveFailedDialogClose => 'Close Anyway';

  @override
  String get saveChangesTitle => 'Save Changes?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Do you want to save changes to \"$fileName\" before closing?';
  }

  @override
  String get saveButton => 'Save';

  @override
  String get discardButton => 'Discard';

  @override
  String get documentEdited => 'Edited';

  @override
  String get documentSaved => 'Saved';

  @override
  String get menuSettings => 'Settings...';

  @override
  String get menuWindow => 'Window';

  @override
  String get menuMinimize => 'Minimise';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Bring All to Front';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'System Default';

  @override
  String get settingsUnits => 'Units';

  @override
  String get settingsUnitsCentimeters => 'Centimetres';

  @override
  String get settingsUnitsInches => 'Inches';

  @override
  String get settingsUnitsDefault => 'Default (by region)';

  @override
  String get settingsSearchLanguages => 'Search languages...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Add Image';

  @override
  String get selectImages => 'Select Images';

  @override
  String get zoomFitWidth => 'Fit Width';

  @override
  String get zoomIn => 'Zoom In';

  @override
  String get zoomOut => 'Zoom Out';

  @override
  String get selectZoomLevel => 'Select zoom level';

  @override
  String get goToPage => 'Go to Page';

  @override
  String get go => 'Go';

  @override
  String get savePdfAs => 'Save PDF As';

  @override
  String get incorrectPassword => 'Incorrect password';

  @override
  String get saveFailed => 'Save failed';

  @override
  String savedTo(String path) {
    return 'Saved to: $path';
  }

  @override
  String get noOriginalPdfStored => 'No original PDF stored';

  @override
  String get waitingForFolderPermission =>
      'Waiting for folder access permission...';

  @override
  String get emptyRecentFiles => 'Open a file to get started';

  @override
  String get imagesTitle => 'Images';

  @override
  String get noImagesYet => 'No images yet';

  @override
  String get noImagesHint => 'Tap + to add your first stamp or signature';

  @override
  String get done => 'Done';

  @override
  String get menuEdit => 'Edit';

  @override
  String get chooseFromFiles => 'Choose from Files';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get imageTooBig => 'Image is too large (max 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Image resolution is too high (max 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Unsupported image format';

  @override
  String get deleteTooltip => 'Delete';

  @override
  String get shareTooltip => 'Share';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Page $currentPage of $totalPages';
  }

  @override
  String get noDocumentLoaded => 'No document loaded';

  @override
  String get failedToLoadPdf => 'Failed to load PDF';

  @override
  String get passwordRequired => 'Password Required';

  @override
  String get pdfPasswordProtected => 'This PDF is password protected.';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get unsavedChangesTitle => 'Unsaved Changes';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Do you want to save changes to \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Tap to open a PDF document';

  @override
  String get onboardingSwipeUp => 'Swipe up to add signatures and stamps';

  @override
  String get onboardingAddImage => 'Tap to add your first signature or stamp';

  @override
  String get onboardingDragImage => 'Drag onto PDF to place it';

  @override
  String get onboardingResizeObject => 'Tap to select. Drag corners to resize.';

  @override
  String get onboardingDeleteImage => 'Tap to delete the selected image';

  @override
  String get onboardingTapToContinue => 'Tap anywhere to continue';

  @override
  String get imageConversionFailed => 'Failed to convert image to PDF';

  @override
  String get saveDocumentTitle => 'Save Document';

  @override
  String get fileNameLabel => 'File name';

  @override
  String get defaultFileName => 'Document';

  @override
  String get onlyOnePdfAllowed => 'Only one PDF can be opened at a time';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF files were ignored. Converting images only.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images',
      one: 'image',
    );
    return 'Converting $count $_temp0...';
  }

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get removeBackgroundTitle => 'Remove Background?';

  @override
  String get removeBackgroundMessage =>
      'A uniform background was detected. Would you like to make it transparent?';

  @override
  String get removeBackground => 'Remove';

  @override
  String get keepOriginal => 'Keep';

  @override
  String get processingImage => 'Processing image...';

  @override
  String get backgroundRemovalFailed => 'Failed to remove background';
}

/// The translations for English, as used in the United Kingdom (`en_GB`).
class AppLocalizationsEnGb extends AppLocalizationsEn {
  AppLocalizationsEnGb() : super('en_GB');

  @override
  String get openPdf => 'Open PDF';

  @override
  String get selectPdf => 'Open File';

  @override
  String get untitledDocument => 'Untitled.pdf';

  @override
  String get recentFiles => 'Recent Files';

  @override
  String get removeFromList => 'Remove from list';

  @override
  String get openedNow => 'Opened just now';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutes',
      one: 'minute',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hours',
      one: 'hour',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String get openedYesterday => 'Opened yesterday';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String get fileNotFound => 'File not found';

  @override
  String get fileAccessDenied => 'Access denied';

  @override
  String get clearRecentFiles => 'Clear recent files';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get error => 'Error';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Open...';

  @override
  String get menuOpenRecent => 'Open Recent';

  @override
  String get menuNoRecentFiles => 'No Recent Files';

  @override
  String get menuClearMenu => 'Clear Menu';

  @override
  String get menuSave => 'Save';

  @override
  String get menuSaveAs => 'Save As...';

  @override
  String get menuSaveAll => 'Save All';

  @override
  String get menuShare => 'Share...';

  @override
  String get menuCloseWindow => 'Close Window';

  @override
  String get menuCloseAll => 'Close All';

  @override
  String get menuQuit => 'Quit PDFSign';

  @override
  String get closeAllDialogTitle => 'Save Changes?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Do you want to save changes in $count documents before closing?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Do you want to save changes in 1 document before closing?';

  @override
  String get closeAllDialogSaveAll => 'Save All';

  @override
  String get closeAllDialogDontSave => 'Don\'t Save';

  @override
  String get closeAllDialogCancel => 'Cancel';

  @override
  String get saveFailedDialogTitle => 'Save Failed';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Failed to save $count document(s). Close anyway?';
  }

  @override
  String get saveFailedDialogClose => 'Close Anyway';

  @override
  String get saveChangesTitle => 'Save Changes?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Do you want to save changes to \"$fileName\" before closing?';
  }

  @override
  String get saveButton => 'Save';

  @override
  String get discardButton => 'Discard';

  @override
  String get documentEdited => 'Edited';

  @override
  String get documentSaved => 'Saved';

  @override
  String get menuSettings => 'Settings...';

  @override
  String get menuWindow => 'Window';

  @override
  String get menuMinimize => 'Minimise';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Bring All to Front';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'System Default';

  @override
  String get settingsUnits => 'Units';

  @override
  String get settingsUnitsCentimeters => 'Centimetres';

  @override
  String get settingsUnitsInches => 'Inches';

  @override
  String get settingsUnitsDefault => 'Default (by region)';

  @override
  String get settingsSearchLanguages => 'Search languages...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Add Image';

  @override
  String get selectImages => 'Select Images';

  @override
  String get zoomFitWidth => 'Fit Width';

  @override
  String get zoomIn => 'Zoom In';

  @override
  String get zoomOut => 'Zoom Out';

  @override
  String get selectZoomLevel => 'Select zoom level';

  @override
  String get goToPage => 'Go to Page';

  @override
  String get go => 'Go';

  @override
  String get savePdfAs => 'Save PDF As';

  @override
  String get incorrectPassword => 'Incorrect password';

  @override
  String get saveFailed => 'Save failed';

  @override
  String savedTo(String path) {
    return 'Saved to: $path';
  }

  @override
  String get noOriginalPdfStored => 'No original PDF stored';

  @override
  String get waitingForFolderPermission =>
      'Waiting for folder access permission...';

  @override
  String get emptyRecentFiles => 'Open a file to get started';

  @override
  String get imagesTitle => 'Images';

  @override
  String get noImagesYet => 'No images yet';

  @override
  String get noImagesHint => 'Tap + to add your first stamp or signature';

  @override
  String get done => 'Done';

  @override
  String get menuEdit => 'Edit';

  @override
  String get chooseFromFiles => 'Choose from Files';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get imageTooBig => 'Image is too large (max 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Image resolution is too high (max 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Unsupported image format';

  @override
  String get deleteTooltip => 'Delete';

  @override
  String get shareTooltip => 'Share';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Page $currentPage of $totalPages';
  }

  @override
  String get noDocumentLoaded => 'No document loaded';

  @override
  String get failedToLoadPdf => 'Failed to load PDF';

  @override
  String get passwordRequired => 'Password Required';

  @override
  String get pdfPasswordProtected => 'This PDF is password protected.';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get unsavedChangesTitle => 'Unsaved Changes';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Do you want to save changes to \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Tap to open a PDF document';

  @override
  String get onboardingSwipeUp => 'Swipe up to add signatures and stamps';

  @override
  String get onboardingAddImage => 'Tap to add your first signature or stamp';

  @override
  String get onboardingDragImage => 'Drag onto PDF to place it';

  @override
  String get onboardingResizeObject => 'Tap to select. Drag corners to resize.';

  @override
  String get onboardingDeleteImage => 'Tap to delete the selected image';

  @override
  String get onboardingTapToContinue => 'Tap anywhere to continue';

  @override
  String get imageConversionFailed => 'Failed to convert image to PDF';

  @override
  String get saveDocumentTitle => 'Save Document';

  @override
  String get fileNameLabel => 'File name';

  @override
  String get defaultFileName => 'Document';

  @override
  String get onlyOnePdfAllowed => 'Only one PDF can be opened at a time';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF files were ignored. Converting images only.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images',
      one: 'image',
    );
    return 'Converting $count $_temp0...';
  }

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get removeBackgroundTitle => 'Remove Background?';

  @override
  String get removeBackgroundMessage =>
      'A uniform background was detected. Would you like to make it transparent?';

  @override
  String get removeBackground => 'Remove';

  @override
  String get keepOriginal => 'Keep';

  @override
  String get processingImage => 'Processing image...';

  @override
  String get backgroundRemovalFailed => 'Failed to remove background';
}

/// The translations for English, as used in New Zealand (`en_NZ`).
class AppLocalizationsEnNz extends AppLocalizationsEn {
  AppLocalizationsEnNz() : super('en_NZ');

  @override
  String get openPdf => 'Open PDF';

  @override
  String get selectPdf => 'Open File';

  @override
  String get untitledDocument => 'Untitled.pdf';

  @override
  String get recentFiles => 'Recent Files';

  @override
  String get removeFromList => 'Remove from list';

  @override
  String get openedNow => 'Opened just now';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutes',
      one: 'minute',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hours',
      one: 'hour',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String get openedYesterday => 'Opened yesterday';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String get fileNotFound => 'File not found';

  @override
  String get fileAccessDenied => 'Access denied';

  @override
  String get clearRecentFiles => 'Clear recent files';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get error => 'Error';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Open...';

  @override
  String get menuOpenRecent => 'Open Recent';

  @override
  String get menuNoRecentFiles => 'No Recent Files';

  @override
  String get menuClearMenu => 'Clear Menu';

  @override
  String get menuSave => 'Save';

  @override
  String get menuSaveAs => 'Save As...';

  @override
  String get menuSaveAll => 'Save All';

  @override
  String get menuShare => 'Share...';

  @override
  String get menuCloseWindow => 'Close Window';

  @override
  String get menuCloseAll => 'Close All';

  @override
  String get menuQuit => 'Quit PDFSign';

  @override
  String get closeAllDialogTitle => 'Save Changes?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Do you want to save changes in $count documents before closing?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Do you want to save changes in 1 document before closing?';

  @override
  String get closeAllDialogSaveAll => 'Save All';

  @override
  String get closeAllDialogDontSave => 'Don\'t Save';

  @override
  String get closeAllDialogCancel => 'Cancel';

  @override
  String get saveFailedDialogTitle => 'Save Failed';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Failed to save $count document(s). Close anyway?';
  }

  @override
  String get saveFailedDialogClose => 'Close Anyway';

  @override
  String get saveChangesTitle => 'Save Changes?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Do you want to save changes to \"$fileName\" before closing?';
  }

  @override
  String get saveButton => 'Save';

  @override
  String get discardButton => 'Discard';

  @override
  String get documentEdited => 'Edited';

  @override
  String get documentSaved => 'Saved';

  @override
  String get menuSettings => 'Settings...';

  @override
  String get menuWindow => 'Window';

  @override
  String get menuMinimize => 'Minimise';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Bring All to Front';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'System Default';

  @override
  String get settingsUnits => 'Units';

  @override
  String get settingsUnitsCentimeters => 'Centimetres';

  @override
  String get settingsUnitsInches => 'Inches';

  @override
  String get settingsUnitsDefault => 'Default (by region)';

  @override
  String get settingsSearchLanguages => 'Search languages...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Add Image';

  @override
  String get selectImages => 'Select Images';

  @override
  String get zoomFitWidth => 'Fit Width';

  @override
  String get zoomIn => 'Zoom In';

  @override
  String get zoomOut => 'Zoom Out';

  @override
  String get selectZoomLevel => 'Select zoom level';

  @override
  String get goToPage => 'Go to Page';

  @override
  String get go => 'Go';

  @override
  String get savePdfAs => 'Save PDF As';

  @override
  String get incorrectPassword => 'Incorrect password';

  @override
  String get saveFailed => 'Save failed';

  @override
  String savedTo(String path) {
    return 'Saved to: $path';
  }

  @override
  String get noOriginalPdfStored => 'No original PDF stored';

  @override
  String get waitingForFolderPermission =>
      'Waiting for folder access permission...';

  @override
  String get emptyRecentFiles => 'Open a file to get started';

  @override
  String get imagesTitle => 'Images';

  @override
  String get noImagesYet => 'No images yet';

  @override
  String get noImagesHint => 'Tap + to add your first stamp or signature';

  @override
  String get done => 'Done';

  @override
  String get menuEdit => 'Edit';

  @override
  String get chooseFromFiles => 'Choose from Files';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get imageTooBig => 'Image is too large (max 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Image resolution is too high (max 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Unsupported image format';

  @override
  String get deleteTooltip => 'Delete';

  @override
  String get shareTooltip => 'Share';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Page $currentPage of $totalPages';
  }

  @override
  String get noDocumentLoaded => 'No document loaded';

  @override
  String get failedToLoadPdf => 'Failed to load PDF';

  @override
  String get passwordRequired => 'Password Required';

  @override
  String get pdfPasswordProtected => 'This PDF is password protected.';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get unsavedChangesTitle => 'Unsaved Changes';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Do you want to save changes to \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Tap to open a PDF document';

  @override
  String get onboardingSwipeUp => 'Swipe up to add signatures and stamps';

  @override
  String get onboardingAddImage => 'Tap to add your first signature or stamp';

  @override
  String get onboardingDragImage => 'Drag onto PDF to place it';

  @override
  String get onboardingResizeObject => 'Tap to select. Drag corners to resize.';

  @override
  String get onboardingDeleteImage => 'Tap to delete the selected image';

  @override
  String get onboardingTapToContinue => 'Tap anywhere to continue';

  @override
  String get imageConversionFailed => 'Failed to convert image to PDF';

  @override
  String get saveDocumentTitle => 'Save Document';

  @override
  String get fileNameLabel => 'File name';

  @override
  String get defaultFileName => 'Document';

  @override
  String get onlyOnePdfAllowed => 'Only one PDF can be opened at a time';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF files were ignored. Converting images only.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images',
      one: 'image',
    );
    return 'Converting $count $_temp0...';
  }

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get removeBackgroundTitle => 'Remove Background?';

  @override
  String get removeBackgroundMessage =>
      'A uniform background was detected. Would you like to make it transparent?';

  @override
  String get removeBackground => 'Remove';

  @override
  String get keepOriginal => 'Keep';

  @override
  String get processingImage => 'Processing image...';

  @override
  String get backgroundRemovalFailed => 'Failed to remove background';
}

/// The translations for English, as used in the United States (`en_US`).
class AppLocalizationsEnUs extends AppLocalizationsEn {
  AppLocalizationsEnUs() : super('en_US');

  @override
  String get openPdf => 'Open PDF';

  @override
  String get selectPdf => 'Open File';

  @override
  String get untitledDocument => 'Untitled.pdf';

  @override
  String get recentFiles => 'Recent Files';

  @override
  String get removeFromList => 'Remove from list';

  @override
  String get openedNow => 'Opened just now';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutes',
      one: 'minute',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hours',
      one: 'hour',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String get openedYesterday => 'Opened yesterday';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String get fileNotFound => 'File not found';

  @override
  String get fileAccessDenied => 'Access denied';

  @override
  String get clearRecentFiles => 'Clear recent files';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get error => 'Error';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Open...';

  @override
  String get menuOpenRecent => 'Open Recent';

  @override
  String get menuNoRecentFiles => 'No Recent Files';

  @override
  String get menuClearMenu => 'Clear Menu';

  @override
  String get menuSave => 'Save';

  @override
  String get menuSaveAs => 'Save As...';

  @override
  String get menuSaveAll => 'Save All';

  @override
  String get menuShare => 'Share...';

  @override
  String get menuCloseWindow => 'Close Window';

  @override
  String get menuCloseAll => 'Close All';

  @override
  String get menuQuit => 'Quit PDFSign';

  @override
  String get closeAllDialogTitle => 'Save Changes?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Do you want to save changes in $count documents before closing?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Do you want to save changes in 1 document before closing?';

  @override
  String get closeAllDialogSaveAll => 'Save All';

  @override
  String get closeAllDialogDontSave => 'Don\'t Save';

  @override
  String get closeAllDialogCancel => 'Cancel';

  @override
  String get saveFailedDialogTitle => 'Save Failed';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Failed to save $count document(s). Close anyway?';
  }

  @override
  String get saveFailedDialogClose => 'Close Anyway';

  @override
  String get saveChangesTitle => 'Save Changes?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Do you want to save changes to \"$fileName\" before closing?';
  }

  @override
  String get saveButton => 'Save';

  @override
  String get discardButton => 'Discard';

  @override
  String get documentEdited => 'Edited';

  @override
  String get documentSaved => 'Saved';

  @override
  String get menuSettings => 'Settings...';

  @override
  String get menuWindow => 'Window';

  @override
  String get menuMinimize => 'Minimize';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Bring All to Front';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'System Default';

  @override
  String get settingsUnits => 'Units';

  @override
  String get settingsUnitsCentimeters => 'Centimeters';

  @override
  String get settingsUnitsInches => 'Inches';

  @override
  String get settingsUnitsDefault => 'Default (by region)';

  @override
  String get settingsSearchLanguages => 'Search languages...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Add Image';

  @override
  String get selectImages => 'Select Images';

  @override
  String get zoomFitWidth => 'Fit Width';

  @override
  String get zoomIn => 'Zoom In';

  @override
  String get zoomOut => 'Zoom Out';

  @override
  String get selectZoomLevel => 'Select zoom level';

  @override
  String get goToPage => 'Go to Page';

  @override
  String get go => 'Go';

  @override
  String get savePdfAs => 'Save PDF As';

  @override
  String get incorrectPassword => 'Incorrect password';

  @override
  String get saveFailed => 'Save failed';

  @override
  String savedTo(String path) {
    return 'Saved to: $path';
  }

  @override
  String get noOriginalPdfStored => 'No original PDF stored';

  @override
  String get waitingForFolderPermission =>
      'Waiting for folder access permission...';

  @override
  String get emptyRecentFiles => 'Open a file to get started';

  @override
  String get imagesTitle => 'Images';

  @override
  String get noImagesYet => 'No images yet';

  @override
  String get noImagesHint => 'Tap + to add your first stamp or signature';

  @override
  String get done => 'Done';

  @override
  String get menuEdit => 'Edit';

  @override
  String get chooseFromFiles => 'Choose from Files';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get imageTooBig => 'Image is too large (max 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Image resolution is too high (max 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Unsupported image format';

  @override
  String get deleteTooltip => 'Delete';

  @override
  String get shareTooltip => 'Share';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Page $currentPage of $totalPages';
  }

  @override
  String get noDocumentLoaded => 'No document loaded';

  @override
  String get failedToLoadPdf => 'Failed to load PDF';

  @override
  String get passwordRequired => 'Password Required';

  @override
  String get pdfPasswordProtected => 'This PDF is password protected.';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get unsavedChangesTitle => 'Unsaved Changes';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Do you want to save changes to \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Tap to open a PDF document';

  @override
  String get onboardingSwipeUp => 'Swipe up to add signatures and stamps';

  @override
  String get onboardingAddImage => 'Tap to add your first signature or stamp';

  @override
  String get onboardingDragImage => 'Drag onto PDF to place it';

  @override
  String get onboardingResizeObject => 'Tap to select. Drag corners to resize.';

  @override
  String get onboardingDeleteImage => 'Tap to delete the selected image';

  @override
  String get onboardingTapToContinue => 'Tap anywhere to continue';

  @override
  String get imageConversionFailed => 'Failed to convert image to PDF';

  @override
  String get saveDocumentTitle => 'Save Document';

  @override
  String get fileNameLabel => 'File name';

  @override
  String get defaultFileName => 'Document';

  @override
  String get onlyOnePdfAllowed => 'Only one PDF can be opened at a time';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF files were ignored. Converting images only.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images',
      one: 'image',
    );
    return 'Converting $count $_temp0...';
  }

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get removeBackgroundTitle => 'Remove Background?';

  @override
  String get removeBackgroundMessage =>
      'A uniform background was detected. Would you like to make it transparent?';

  @override
  String get removeBackground => 'Remove';

  @override
  String get keepOriginal => 'Keep';

  @override
  String get processingImage => 'Processing image...';

  @override
  String get backgroundRemovalFailed => 'Failed to remove background';
}
