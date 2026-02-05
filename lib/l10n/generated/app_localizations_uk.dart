// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get openPdf => 'Відкрити PDF';

  @override
  String get selectPdf => 'Відкрити файл';

  @override
  String get untitledDocument => 'Без назви.pdf';

  @override
  String get recentFiles => 'Нещодавні файли';

  @override
  String get removeFromList => 'Видалити зі списку';

  @override
  String get openedNow => 'Щойно відкрито';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'хвилин',
      many: 'хвилин',
      few: 'хвилини',
      one: 'хвилину',
    );
    return 'Відкрито $count $_temp0 тому';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'годин',
      many: 'годин',
      few: 'години',
      one: 'годину',
    );
    return 'Відкрито $count $_temp0 тому';
  }

  @override
  String get openedYesterday => 'Відкрито вчора';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'днів',
      many: 'днів',
      few: 'дні',
      one: 'день',
    );
    return 'Відкрито $count $_temp0 тому';
  }

  @override
  String get fileNotFound => 'Файл не знайдено';

  @override
  String get fileAccessDenied => 'Доступ заборонено';

  @override
  String get clearRecentFiles => 'Очистити нещодавні файли';

  @override
  String get cancel => 'Скасувати';

  @override
  String get confirm => 'Підтвердити';

  @override
  String get error => 'Помилка';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Файл';

  @override
  String get menuOpen => 'Відкрити...';

  @override
  String get menuOpenRecent => 'Відкрити нещодавні';

  @override
  String get menuNoRecentFiles => 'Немає нещодавніх файлів';

  @override
  String get menuClearMenu => 'Очистити меню';

  @override
  String get menuSave => 'Зберегти';

  @override
  String get menuSaveAs => 'Зберегти як...';

  @override
  String get menuSaveAll => 'Зберегти все';

  @override
  String get menuShare => 'Поділитися...';

  @override
  String get menuCloseWindow => 'Закрити вікно';

  @override
  String get menuCloseAll => 'Закрити все';

  @override
  String get menuQuit => 'Вийти з PDFSign';

  @override
  String get closeAllDialogTitle => 'Зберегти зміни?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Бажаєте зберегти зміни у $count документах перед закриттям?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Бажаєте зберегти зміни у 1 документі перед закриттям?';

  @override
  String get closeAllDialogSaveAll => 'Зберегти все';

  @override
  String get closeAllDialogDontSave => 'Не зберігати';

  @override
  String get closeAllDialogCancel => 'Скасувати';

  @override
  String get saveFailedDialogTitle => 'Помилка збереження';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Не вдалося зберегти $count документ(ів). Все одно закрити?';
  }

  @override
  String get saveFailedDialogClose => 'Все одно закрити';

  @override
  String get saveChangesTitle => 'Зберегти зміни?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Бажаєте зберегти зміни у \"$fileName\" перед закриттям?';
  }

  @override
  String get saveButton => 'Зберегти';

  @override
  String get discardButton => 'Не зберігати';

  @override
  String get documentEdited => 'Змінено';

  @override
  String get documentSaved => 'Збережено';

  @override
  String get menuSettings => 'Налаштування...';

  @override
  String get menuWindow => 'Вікно';

  @override
  String get menuMinimize => 'Згорнути';

  @override
  String get menuZoom => 'Масштаб';

  @override
  String get menuBringAllToFront => 'Усі вікна наперед';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get settingsLanguage => 'Мова';

  @override
  String get settingsLanguageSystem => 'Системна за замовчуванням';

  @override
  String get settingsUnits => 'Одиниці';

  @override
  String get settingsUnitsCentimeters => 'Сантиметри';

  @override
  String get settingsUnitsInches => 'Дюйми';

  @override
  String get settingsUnitsDefault => 'За замовчуванням (за регіоном)';

  @override
  String get settingsSearchLanguages => 'Пошук мов...';

  @override
  String get settingsGeneral => 'Загальні';

  @override
  String get addImage => 'Додати зображення';

  @override
  String get selectImages => 'Вибрати зображення';

  @override
  String get zoomFitWidth => 'За шириною';

  @override
  String get zoomIn => 'Збільшити';

  @override
  String get zoomOut => 'Зменшити';

  @override
  String get selectZoomLevel => 'Вибрати масштаб';

  @override
  String get goToPage => 'Перейти до сторінки';

  @override
  String get go => 'Перейти';

  @override
  String get savePdfAs => 'Зберегти PDF як';

  @override
  String get incorrectPassword => 'Невірний пароль';

  @override
  String get saveFailed => 'Помилка збереження';

  @override
  String savedTo(String path) {
    return 'Збережено: $path';
  }

  @override
  String get noOriginalPdfStored => 'Оригінальний PDF не знайдено';

  @override
  String get waitingForFolderPermission =>
      'Очікування дозволу на доступ до папки...';

  @override
  String get emptyRecentFiles => 'Відкрийте файл, щоб почати';

  @override
  String get imagesTitle => 'Зображення';

  @override
  String get noImagesYet => 'Зображень поки немає';

  @override
  String get noImagesHint => 'Натисніть +, щоб додати перший штамп або підпис';

  @override
  String get done => 'Готово';

  @override
  String get menuEdit => 'Редагувати';

  @override
  String get chooseFromFiles => 'Вибрати з файлів';

  @override
  String get chooseFromGallery => 'Вибрати з галереї';

  @override
  String get imageTooBig => 'Зображення занадто велике (макс. 50 МБ)';

  @override
  String get imageResolutionTooHigh =>
      'Роздільність занадто висока (макс. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Непідтримуваний формат зображення';

  @override
  String get deleteTooltip => 'Видалити';

  @override
  String get shareTooltip => 'Поділитися';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Сторінка $currentPage з $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Документ не завантажено';

  @override
  String get failedToLoadPdf => 'Не вдалося завантажити PDF';

  @override
  String get passwordRequired => 'Потрібен пароль';

  @override
  String get pdfPasswordProtected => 'Цей PDF захищений паролем.';

  @override
  String errorWithMessage(String message) {
    return 'Помилка: $message';
  }

  @override
  String get unsavedChangesTitle => 'Незбережені зміни';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Зберегти зміни у \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Натисніть, щоб відкрити PDF-документ';

  @override
  String get onboardingSwipeUp =>
      'Проведіть вгору, щоб додати підписи та штампи';

  @override
  String get onboardingAddImage =>
      'Натисніть, щоб додати перший підпис або штамп';

  @override
  String get onboardingDragImage => 'Перетягніть на PDF, щоб розмістити';

  @override
  String get onboardingResizeObject =>
      'Натисніть для вибору. Перетягніть кути для зміни розміру.';

  @override
  String get onboardingDeleteImage =>
      'Торкніться, щоб видалити вибране зображення';

  @override
  String get onboardingTapToContinue => 'Натисніть будь-де, щоб продовжити';

  @override
  String get imageConversionFailed =>
      'Не вдалося перетворити зображення на PDF';

  @override
  String get saveDocumentTitle => 'Зберегти документ';

  @override
  String get fileNameLabel => 'Назва файлу';

  @override
  String get defaultFileName => 'Документ';

  @override
  String get onlyOnePdfAllowed => 'Можна відкрити лише один PDF-файл одночасно';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF-файли пропущено. Конвертуються лише зображення.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'зображення',
      many: 'зображень',
      few: 'зображень',
      one: 'зображення',
    );
    return 'Конвертація $count $_temp0...';
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
