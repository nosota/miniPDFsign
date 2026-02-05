// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get openPdf => 'Отвори PDF';

  @override
  String get selectPdf => 'Отвори файл';

  @override
  String get untitledDocument => 'Без име.pdf';

  @override
  String get recentFiles => 'Скорошни файлове';

  @override
  String get removeFromList => 'Премахни от списъка';

  @override
  String get openedNow => 'Току-що отворен';

  @override
  String openedMinutesAgo(int count) {
    return 'Отворен преди $count минути';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Отворен преди $count часа';
  }

  @override
  String get openedYesterday => 'Отворен вчера';

  @override
  String openedDaysAgo(int count) {
    return 'Отворен преди $count дни';
  }

  @override
  String get fileNotFound => 'Файлът не е намерен';

  @override
  String get fileAccessDenied => 'Достъпът е отказан';

  @override
  String get clearRecentFiles => 'Изчисти скорошните файлове';

  @override
  String get cancel => 'Отказ';

  @override
  String get confirm => 'Потвърди';

  @override
  String get error => 'Грешка';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Файл';

  @override
  String get menuOpen => 'Отвори...';

  @override
  String get menuOpenRecent => 'Отвори скорошни';

  @override
  String get menuNoRecentFiles => 'Няма скорошни файлове';

  @override
  String get menuClearMenu => 'Изчисти менюто';

  @override
  String get menuSave => 'Запази';

  @override
  String get menuSaveAs => 'Запази като...';

  @override
  String get menuSaveAll => 'Запази всички';

  @override
  String get menuShare => 'Сподели...';

  @override
  String get menuCloseWindow => 'Затвори прозореца';

  @override
  String get menuCloseAll => 'Затвори всички';

  @override
  String get menuQuit => 'Изход от PDFSign';

  @override
  String get closeAllDialogTitle => 'Запази промените?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Искате ли да запазите промените в $count документа преди затваряне?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Искате ли да запазите промените в 1 документ преди затваряне?';

  @override
  String get closeAllDialogSaveAll => 'Запази всички';

  @override
  String get closeAllDialogDontSave => 'Не запазвай';

  @override
  String get closeAllDialogCancel => 'Отказ';

  @override
  String get saveFailedDialogTitle => 'Неуспешно запазване';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Неуспешно запазване на $count документ(а). Да се затвори въпреки това?';
  }

  @override
  String get saveFailedDialogClose => 'Затвори въпреки това';

  @override
  String get saveChangesTitle => 'Запази промените?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Искате ли да запазите промените в \"$fileName\" преди затваряне?';
  }

  @override
  String get saveButton => 'Запази';

  @override
  String get discardButton => 'Не запазвай';

  @override
  String get documentEdited => 'Редактиран';

  @override
  String get documentSaved => 'Запазен';

  @override
  String get menuSettings => 'Настройки...';

  @override
  String get menuWindow => 'Прозорец';

  @override
  String get menuMinimize => 'Минимизирай';

  @override
  String get menuZoom => 'Увеличи';

  @override
  String get menuBringAllToFront => 'Покажи всички отпред';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsLanguage => 'Език';

  @override
  String get settingsLanguageSystem => 'Системен по подразбиране';

  @override
  String get settingsUnits => 'Единици';

  @override
  String get settingsUnitsCentimeters => 'Сантиметри';

  @override
  String get settingsUnitsInches => 'Инчове';

  @override
  String get settingsUnitsDefault => 'По подразбиране (по регион)';

  @override
  String get settingsSearchLanguages => 'Търсене на езици...';

  @override
  String get settingsGeneral => 'Общи';

  @override
  String get addImage => 'Добави изображение';

  @override
  String get selectImages => 'Избери изображения';

  @override
  String get zoomFitWidth => 'По ширина';

  @override
  String get zoomIn => 'Увеличи';

  @override
  String get zoomOut => 'Намали';

  @override
  String get selectZoomLevel => 'Избери ниво на мащабиране';

  @override
  String get goToPage => 'Отиди на страница';

  @override
  String get go => 'Отиди';

  @override
  String get savePdfAs => 'Запази PDF като';

  @override
  String get incorrectPassword => 'Грешна парола';

  @override
  String get saveFailed => 'Неуспешно запазване';

  @override
  String savedTo(String path) {
    return 'Запазено в: $path';
  }

  @override
  String get noOriginalPdfStored => 'Няма запазен оригинален PDF';

  @override
  String get waitingForFolderPermission =>
      'Изчакване на разрешение за достъп до папката...';

  @override
  String get emptyRecentFiles => 'Отворете файл, за да започнете';

  @override
  String get imagesTitle => 'Изображения';

  @override
  String get noImagesYet => 'Все още няма изображения';

  @override
  String get noImagesHint =>
      'Докоснете +, за да добавите първия си печат или подпис';

  @override
  String get done => 'Готово';

  @override
  String get menuEdit => 'Редактиране';

  @override
  String get chooseFromFiles => 'Избери от файлове';

  @override
  String get chooseFromGallery => 'Избери от галерия';

  @override
  String get imageTooBig => 'Изображението е твърде голямо (макс. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Резолюцията е твърде висока (макс. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Неподдържан формат на изображение';

  @override
  String get deleteTooltip => 'Изтрий';

  @override
  String get shareTooltip => 'Сподели';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Страница $currentPage от $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Няма зареден документ';

  @override
  String get failedToLoadPdf => 'Неуспешно зареждане на PDF';

  @override
  String get passwordRequired => 'Изисква се парола';

  @override
  String get pdfPasswordProtected => 'Този PDF е защитен с парола.';

  @override
  String errorWithMessage(String message) {
    return 'Грешка: $message';
  }

  @override
  String get unsavedChangesTitle => 'Незапазени промени';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Искате ли да запазите промените в \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Докоснете, за да отворите PDF документ';

  @override
  String get onboardingSwipeUp =>
      'Плъзнете нагоре, за да добавите подписи и печати';

  @override
  String get onboardingAddImage =>
      'Докоснете, за да добавите първия подпис или печат';

  @override
  String get onboardingDragImage => 'Плъзнете върху PDF, за да поставите';

  @override
  String get onboardingResizeObject =>
      'Докоснете за избор. Плъзнете ъглите за промяна на размера.';

  @override
  String get onboardingDeleteImage =>
      'Докоснете, за да изтриете избраното изображение';

  @override
  String get onboardingTapToContinue => 'Докоснете някъде, за да продължите';

  @override
  String get imageConversionFailed =>
      'Неуспешно конвертиране на изображението в PDF';

  @override
  String get saveDocumentTitle => 'Запазване на документ';

  @override
  String get fileNameLabel => 'Име на файла';

  @override
  String get defaultFileName => 'Документ';

  @override
  String get onlyOnePdfAllowed =>
      'Може да се отвори само един PDF файл наведнъж';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF файловете бяха игнорирани. Конвертират се само изображенията.';

  @override
  String convertingImages(int count) {
    return 'Конвертиране на $count изображения...';
  }

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get removeBackgroundTitle => 'Remove Background?';

  @override
  String get removeBackgroundMessage =>
      'A uniform background was detected. Would you like to make it transparent?';

  @override
  String get removeBackground => 'Remove Background';

  @override
  String get keepOriginal => 'Keep Original';

  @override
  String get processingImage => 'Processing image...';

  @override
  String get backgroundRemovalFailed => 'Failed to remove background';
}
