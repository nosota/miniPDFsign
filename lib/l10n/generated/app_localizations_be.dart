// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Belarusian (`be`).
class AppLocalizationsBe extends AppLocalizations {
  AppLocalizationsBe([String locale = 'be']) : super(locale);

  @override
  String get openPdf => 'Адкрыць PDF';

  @override
  String get selectPdf => 'Адкрыць файл';

  @override
  String get untitledDocument => 'Без назвы.pdf';

  @override
  String get recentFiles => 'Нядаўнія файлы';

  @override
  String get removeFromList => 'Выдаліць са спісу';

  @override
  String get openedNow => 'Толькі што адкрыта';

  @override
  String openedMinutesAgo(int count) {
    return 'Адкрыта $count хвілін таму';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Адкрыта $count гадзін таму';
  }

  @override
  String get openedYesterday => 'Адкрыта ўчора';

  @override
  String openedDaysAgo(int count) {
    return 'Адкрыта $count дзён таму';
  }

  @override
  String get fileNotFound => 'Файл не знойдзены';

  @override
  String get fileAccessDenied => 'Доступ забаронены';

  @override
  String get clearRecentFiles => 'Ачысціць нядаўнія файлы';

  @override
  String get cancel => 'Скасаваць';

  @override
  String get confirm => 'Пацвердзіць';

  @override
  String get error => 'Памылка';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Файл';

  @override
  String get menuOpen => 'Адкрыць...';

  @override
  String get menuOpenRecent => 'Адкрыць нядаўнія';

  @override
  String get menuNoRecentFiles => 'Няма нядаўніх файлаў';

  @override
  String get menuClearMenu => 'Ачысціць меню';

  @override
  String get menuSave => 'Захаваць';

  @override
  String get menuSaveAs => 'Захаваць як...';

  @override
  String get menuSaveAll => 'Захаваць усё';

  @override
  String get menuShare => 'Падзяліцца...';

  @override
  String get menuCloseWindow => 'Закрыць акно';

  @override
  String get menuCloseAll => 'Закрыць усе';

  @override
  String get menuQuit => 'Выхад з PDFSign';

  @override
  String get closeAllDialogTitle => 'Захаваць змены?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Хочаце захаваць змены ў $count дакументах перад закрыццём?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Хочаце захаваць змены ў 1 дакуменце перад закрыццём?';

  @override
  String get closeAllDialogSaveAll => 'Захаваць усе';

  @override
  String get closeAllDialogDontSave => 'Не захоўваць';

  @override
  String get closeAllDialogCancel => 'Скасаваць';

  @override
  String get saveFailedDialogTitle => 'Памылка захавання';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Не ўдалося захаваць $count дакумент(аў). Усё роўна закрыць?';
  }

  @override
  String get saveFailedDialogClose => 'Усё роўна закрыць';

  @override
  String get saveChangesTitle => 'Захаваць змены?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Хочаце захаваць змены ў \"$fileName\" перад закрыццём?';
  }

  @override
  String get saveButton => 'Захаваць';

  @override
  String get discardButton => 'Не захоўваць';

  @override
  String get documentEdited => 'Зменены';

  @override
  String get documentSaved => 'Захаваны';

  @override
  String get menuSettings => 'Налады...';

  @override
  String get menuWindow => 'Акно';

  @override
  String get menuMinimize => 'Згарнуць';

  @override
  String get menuZoom => 'Маштабаванне';

  @override
  String get menuBringAllToFront => 'Усе акны наперад';

  @override
  String get settingsTitle => 'Налады';

  @override
  String get settingsLanguage => 'Мова';

  @override
  String get settingsLanguageSystem => 'Сістэмная па змаўчанні';

  @override
  String get settingsUnits => 'Адзінкі';

  @override
  String get settingsUnitsCentimeters => 'Сантыметры';

  @override
  String get settingsUnitsInches => 'Цалі';

  @override
  String get settingsUnitsDefault => 'Па змаўчанні (па рэгіёне)';

  @override
  String get settingsSearchLanguages => 'Пошук моў...';

  @override
  String get settingsGeneral => 'Агульныя';

  @override
  String get addImage => 'Дадаць выяву';

  @override
  String get selectImages => 'Выбраць выявы';

  @override
  String get zoomFitWidth => 'Па шырыні';

  @override
  String get zoomIn => 'Павялічыць';

  @override
  String get zoomOut => 'Паменшыць';

  @override
  String get selectZoomLevel => 'Выбраць маштаб';

  @override
  String get goToPage => 'Перайсці да старонкі';

  @override
  String get go => 'Перайсці';

  @override
  String get savePdfAs => 'Захаваць PDF як';

  @override
  String get incorrectPassword => 'Няправільны пароль';

  @override
  String get saveFailed => 'Памылка захавання';

  @override
  String savedTo(String path) {
    return 'Захавана: $path';
  }

  @override
  String get noOriginalPdfStored => 'Арыгінальны PDF не знойдзены';

  @override
  String get waitingForFolderPermission =>
      'Чаканне дазволу на доступ да папкі...';

  @override
  String get emptyRecentFiles => 'Адкрыйце файл, каб пачаць';

  @override
  String get imagesTitle => 'Выявы';

  @override
  String get noImagesYet => 'Пакуль няма выяў';

  @override
  String get noImagesHint => 'Націсніце +, каб дадаць першы штамп або подпіс';

  @override
  String get done => 'Гатова';

  @override
  String get menuEdit => 'Рэдагаваць';

  @override
  String get chooseFromFiles => 'Выбраць з файлаў';

  @override
  String get chooseFromGallery => 'Выбраць з галерэі';

  @override
  String get imageTooBig => 'Выява занадта вялікая (макс. 50 МБ)';

  @override
  String get imageResolutionTooHigh =>
      'Разрозненне выявы занадта высокае (макс. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Непадтрымліваемы фармат выявы';

  @override
  String get deleteTooltip => 'Выдаліць';

  @override
  String get shareTooltip => 'Падзяліцца';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Старонка $currentPage з $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Дакумент не загружаны';

  @override
  String get failedToLoadPdf => 'Не ўдалося загрузіць PDF';

  @override
  String get passwordRequired => 'Патрабуецца пароль';

  @override
  String get pdfPasswordProtected => 'Гэты PDF абаронены паролем.';

  @override
  String errorWithMessage(String message) {
    return 'Памылка: $message';
  }

  @override
  String get unsavedChangesTitle => 'Незахаваныя змены';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Захаваць змены ў \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Націсніце, каб адкрыць PDF-дакумент';

  @override
  String get onboardingSwipeUp =>
      'Правядзіце ўверх, каб дадаць подпісы і штампы';

  @override
  String get onboardingAddImage =>
      'Націсніце, каб дадаць першы подпіс або штамп';

  @override
  String get onboardingDragImage => 'Перацягніце на PDF, каб размясціць';

  @override
  String get onboardingResizeObject =>
      'Націсніце для выбару. Перацягніце куты для змены памеру.';

  @override
  String get onboardingDeleteImage => 'Націсніце, каб выдаліць выбраны малюнак';

  @override
  String get onboardingTapToContinue =>
      'Націсніце ў любым месцы, каб працягнуць';

  @override
  String get imageConversionFailed => 'Не атрымалася пераўтварыць выяву ў PDF';

  @override
  String get saveDocumentTitle => 'Захаваць дакумент';

  @override
  String get fileNameLabel => 'Імя файла';

  @override
  String get defaultFileName => 'Дакумент';

  @override
  String get onlyOnePdfAllowed =>
      'Адначасова можна адкрыць толькі адзін PDF-файл';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF-файлы прапушчаны. Канвертуюцца толькі выявы.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'выявы',
      many: 'выяў',
      few: 'выяў',
      one: 'выявы',
    );
    return 'Канвертацыя $count $_temp0...';
  }

  @override
  String get takePhoto => 'Зрабіць фота';

  @override
  String get removeBackgroundTitle => 'Выдаліць фон?';

  @override
  String get removeBackgroundMessage =>
      'Хочаце выдаліць фон і зрабіць яго празрыстым?';

  @override
  String get removeBackground => 'Выдаліць';

  @override
  String get keepOriginal => 'Пакінуць';

  @override
  String get processingImage => 'Апрацоўка выявы...';

  @override
  String get backgroundRemovalFailed => 'Не атрымалася выдаліць фон';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get unlockButton => 'Разблакіраваць';
}
