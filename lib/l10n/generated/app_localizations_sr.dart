// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get openPdf => 'Отвори PDF';

  @override
  String get selectPdf => 'Отвори датотеку';

  @override
  String get untitledDocument => 'Без наслова.pdf';

  @override
  String get recentFiles => 'Недавне датотеке';

  @override
  String get removeFromList => 'Уклони са листе';

  @override
  String get openedNow => 'Управо отворено';

  @override
  String openedMinutesAgo(int count) {
    return 'Отворено пре $count минута';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Отворено пре $count сати';
  }

  @override
  String get openedYesterday => 'Отворено јуче';

  @override
  String openedDaysAgo(int count) {
    return 'Отворено пре $count дана';
  }

  @override
  String get fileNotFound => 'Датотека није пронађена';

  @override
  String get fileAccessDenied => 'Приступ одбијен';

  @override
  String get clearRecentFiles => 'Обриши недавне датотеке';

  @override
  String get cancel => 'Откажи';

  @override
  String get confirm => 'Потврди';

  @override
  String get error => 'Грешка';

  @override
  String get ok => 'У реду';

  @override
  String get menuFile => 'Датотека';

  @override
  String get menuOpen => 'Отвори...';

  @override
  String get menuOpenRecent => 'Отвори недавне';

  @override
  String get menuNoRecentFiles => 'Нема недавних датотека';

  @override
  String get menuClearMenu => 'Обриши мени';

  @override
  String get menuSave => 'Сачувај';

  @override
  String get menuSaveAs => 'Сачувај као...';

  @override
  String get menuSaveAll => 'Сачувај све';

  @override
  String get menuShare => 'Подели...';

  @override
  String get menuCloseWindow => 'Затвори прозор';

  @override
  String get menuCloseAll => 'Затвори све';

  @override
  String get menuQuit => 'Изађи из PDFSign';

  @override
  String get closeAllDialogTitle => 'Сачувај измене?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Желите ли да сачувате измене у $count документа пре затварања?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Желите ли да сачувате измене у 1 документу пре затварања?';

  @override
  String get closeAllDialogSaveAll => 'Сачувај све';

  @override
  String get closeAllDialogDontSave => 'Не сачувај';

  @override
  String get closeAllDialogCancel => 'Откажи';

  @override
  String get saveFailedDialogTitle => 'Чување није успело';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Није успело чување $count документа. Ипак затворити?';
  }

  @override
  String get saveFailedDialogClose => 'Ипак затвори';

  @override
  String get saveChangesTitle => 'Сачувај измене?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Желите ли да сачувате измене у \"$fileName\" пре затварања?';
  }

  @override
  String get saveButton => 'Сачувај';

  @override
  String get discardButton => 'Не сачувај';

  @override
  String get documentEdited => 'Измењено';

  @override
  String get documentSaved => 'Сачувано';

  @override
  String get menuSettings => 'Подешавања...';

  @override
  String get menuWindow => 'Прозор';

  @override
  String get menuMinimize => 'Минимизуј';

  @override
  String get menuZoom => 'Увећај';

  @override
  String get menuBringAllToFront => 'Стави све напред';

  @override
  String get settingsTitle => 'Подешавања';

  @override
  String get settingsLanguage => 'Језик';

  @override
  String get settingsLanguageSystem => 'Подразумевано система';

  @override
  String get settingsUnits => 'Јединице';

  @override
  String get settingsUnitsCentimeters => 'Центиметри';

  @override
  String get settingsUnitsInches => 'Инчи';

  @override
  String get settingsUnitsDefault => 'Подразумевано (по региону)';

  @override
  String get settingsSearchLanguages => 'Претражи језике...';

  @override
  String get settingsGeneral => 'Опште';

  @override
  String get addImage => 'Додај слику';

  @override
  String get selectImages => 'Изабери слике';

  @override
  String get zoomFitWidth => 'Прилагоди ширини';

  @override
  String get zoomIn => 'Увећај';

  @override
  String get zoomOut => 'Умањи';

  @override
  String get selectZoomLevel => 'Изабери ниво зумирања';

  @override
  String get goToPage => 'Иди на страницу';

  @override
  String get go => 'Иди';

  @override
  String get savePdfAs => 'Сачувај PDF као';

  @override
  String get incorrectPassword => 'Погрешна лозинка';

  @override
  String get saveFailed => 'Чување није успело';

  @override
  String savedTo(String path) {
    return 'Сачувано у: $path';
  }

  @override
  String get noOriginalPdfStored => 'Нема сачуваног оригиналног PDF-а';

  @override
  String get waitingForFolderPermission =>
      'Чекање дозволе за приступ фасцикли...';

  @override
  String get emptyRecentFiles => 'Отворите датотеку да бисте започели';

  @override
  String get imagesTitle => 'Слике';

  @override
  String get noImagesYet => 'Још нема слика';

  @override
  String get noImagesHint => 'Додирните + да додате први печат или потпис';

  @override
  String get done => 'Готово';

  @override
  String get menuEdit => 'Уреди';

  @override
  String get chooseFromFiles => 'Изабери из датотека';

  @override
  String get chooseFromGallery => 'Изабери из галерије';

  @override
  String get imageTooBig => 'Слика је превелика (макс. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Резолуција је превисока (макс. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Неподржани формат слике';

  @override
  String get deleteTooltip => 'Обриши';

  @override
  String get shareTooltip => 'Подели';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Страница $currentPage од $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Документ није учитан';

  @override
  String get failedToLoadPdf => 'Неуспешно учитавање PDF-а';

  @override
  String get passwordRequired => 'Потребна је лозинка';

  @override
  String get pdfPasswordProtected => 'Овај PDF је заштићен лозинком.';

  @override
  String errorWithMessage(String message) {
    return 'Грешка: $message';
  }

  @override
  String get unsavedChangesTitle => 'Несачуване измене';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Желите ли да сачувате измене у \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Додирните да отворите PDF документ';

  @override
  String get onboardingSwipeUp => 'Превуците нагоре да додате потписе и печате';

  @override
  String get onboardingAddImage => 'Додирните да додате први потпис или печат';

  @override
  String get onboardingDragImage => 'Превуците на PDF да поставите';

  @override
  String get onboardingResizeObject =>
      'Додирните за избор. Превуците углове за промену величине.';

  @override
  String get onboardingDeleteImage => 'Додирните да обришете изабрану слику';

  @override
  String get onboardingTapToContinue => 'Додирните било где да наставите';

  @override
  String get imageConversionFailed => 'Није успело претварање слике у PDF';

  @override
  String get saveDocumentTitle => 'Сачувај документ';

  @override
  String get fileNameLabel => 'Назив датотеке';

  @override
  String get defaultFileName => 'Документ';

  @override
  String get onlyOnePdfAllowed => 'Може се отворити само један PDF истовремено';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF датотеке су игнорисане. Конвертују се само слике.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'слика',
      few: 'слике',
      one: 'слике',
    );
    return 'Конвертовање $count $_temp0...';
  }

  @override
  String get takePhoto => 'Сликај';

  @override
  String get removeBackgroundTitle => 'Уклонити позадину?';

  @override
  String get removeBackgroundMessage =>
      'Откривена је једнобојна позадина. Желите ли је учинити провидном?';

  @override
  String get removeBackground => 'Уклони';

  @override
  String get keepOriginal => 'Задржи';

  @override
  String get processingImage => 'Обрада слике...';

  @override
  String get backgroundRemovalFailed => 'Уклањање позадине није успело';
}
