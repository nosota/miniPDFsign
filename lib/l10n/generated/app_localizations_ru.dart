// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get openPdf => 'Открыть PDF';

  @override
  String get selectPdf => 'Открыть файл';

  @override
  String get untitledDocument => 'Без названия.pdf';

  @override
  String get recentFiles => 'Недавние файлы';

  @override
  String get removeFromList => 'Удалить из списка';

  @override
  String get openedNow => 'Открыт только что';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'минут',
      many: 'минут',
      few: 'минуты',
      one: 'минуту',
    );
    return 'Открыт $count $_temp0 назад';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'часа',
      many: 'часов',
      few: 'часа',
      one: 'час',
    );
    return 'Открыт $count $_temp0 назад';
  }

  @override
  String get openedYesterday => 'Открыт вчера';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'дней',
      many: 'дней',
      few: 'дня',
      one: 'день',
    );
    return 'Открыт $count $_temp0 назад';
  }

  @override
  String get fileNotFound => 'Файл не найден';

  @override
  String get fileAccessDenied => 'Доступ запрещён';

  @override
  String get clearRecentFiles => 'Очистить недавние файлы';

  @override
  String get cancel => 'Отмена';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get error => 'Ошибка';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Файл';

  @override
  String get menuOpen => 'Открыть...';

  @override
  String get menuOpenRecent => 'Открыть недавние';

  @override
  String get menuNoRecentFiles => 'Нет недавних файлов';

  @override
  String get menuClearMenu => 'Очистить меню';

  @override
  String get menuSave => 'Сохранить';

  @override
  String get menuSaveAs => 'Сохранить как...';

  @override
  String get menuSaveAll => 'Сохранить все';

  @override
  String get menuShare => 'Поделиться...';

  @override
  String get menuCloseWindow => 'Закрыть окно';

  @override
  String get menuCloseAll => 'Закрыть все';

  @override
  String get menuQuit => 'Выход из PDFSign';

  @override
  String get closeAllDialogTitle => 'Сохранить изменения?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Хотите сохранить изменения в $count документах перед закрытием?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Хотите сохранить изменения в 1 документе перед закрытием?';

  @override
  String get closeAllDialogSaveAll => 'Сохранить все';

  @override
  String get closeAllDialogDontSave => 'Не сохранять';

  @override
  String get closeAllDialogCancel => 'Отмена';

  @override
  String get saveFailedDialogTitle => 'Ошибка сохранения';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Не удалось сохранить $count документ(ов). Всё равно закрыть?';
  }

  @override
  String get saveFailedDialogClose => 'Всё равно закрыть';

  @override
  String get saveChangesTitle => 'Сохранить изменения?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Сохранить изменения в «$fileName» перед закрытием?';
  }

  @override
  String get saveButton => 'Сохранить';

  @override
  String get discardButton => 'Не сохранять';

  @override
  String get documentEdited => 'Изменён';

  @override
  String get documentSaved => 'Сохранён';

  @override
  String get menuSettings => 'Настройки...';

  @override
  String get menuWindow => 'Окно';

  @override
  String get menuMinimize => 'Свернуть';

  @override
  String get menuZoom => 'Изменить масштаб';

  @override
  String get menuBringAllToFront => 'Все окна — на передний план';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsLanguageSystem => 'Системный по умолчанию';

  @override
  String get settingsUnits => 'Единицы';

  @override
  String get settingsUnitsCentimeters => 'Сантиметры';

  @override
  String get settingsUnitsInches => 'Дюймы';

  @override
  String get settingsSearchLanguages => 'Поиск языков...';

  @override
  String get settingsGeneral => 'Основные';

  @override
  String get addImage => 'Добавить изображение';

  @override
  String get selectImages => 'Выбрать изображения';

  @override
  String get zoomFitWidth => 'По ширине';

  @override
  String get zoomIn => 'Увеличить';

  @override
  String get zoomOut => 'Уменьшить';

  @override
  String get selectZoomLevel => 'Выбрать масштаб';

  @override
  String get goToPage => 'Перейти к странице';

  @override
  String get go => 'Перейти';

  @override
  String get savePdfAs => 'Сохранить PDF как';

  @override
  String get incorrectPassword => 'Неверный пароль';

  @override
  String get saveFailed => 'Ошибка сохранения';

  @override
  String savedTo(String path) {
    return 'Сохранено: $path';
  }

  @override
  String get noOriginalPdfStored => 'Исходный PDF не найден';

  @override
  String get waitingForFolderPermission =>
      'Ожидание разрешения на доступ к папке...';

  @override
  String get emptyRecentFiles => 'Откройте файл, чтобы начать';

  @override
  String get imagesTitle => 'Изображения';

  @override
  String get noImagesYet => 'Пока нет изображений';

  @override
  String get noImagesHint =>
      'Нажмите +, чтобы добавить первый штамп или подпись';

  @override
  String get done => 'Готово';

  @override
  String get menuEdit => 'Редактировать';

  @override
  String get chooseFromFiles => 'Выбрать из файлов';

  @override
  String get chooseFromGallery => 'Выбрать из галереи';

  @override
  String get imageTooBig => 'Изображение слишком большое (макс. 50 МБ)';

  @override
  String get imageResolutionTooHigh =>
      'Разрешение слишком высокое (макс. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Неподдерживаемый формат изображения';

  @override
  String get deleteTooltip => 'Удалить';

  @override
  String get shareTooltip => 'Поделиться';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Страница $currentPage из $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Документ не загружен';

  @override
  String get failedToLoadPdf => 'Не удалось загрузить PDF';

  @override
  String get passwordRequired => 'Требуется пароль';

  @override
  String get pdfPasswordProtected => 'Этот PDF защищён паролем.';

  @override
  String errorWithMessage(String message) {
    return 'Ошибка: $message';
  }

  @override
  String get unsavedChangesTitle => 'Несохранённые изменения';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Сохранить изменения в \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Нажмите, чтобы открыть PDF-документ';

  @override
  String get onboardingSwipeUp =>
      'Проведите вверх, чтобы добавить подписи и штампы';

  @override
  String get onboardingAddImage =>
      'Нажмите, чтобы добавить первую подпись или штамп';

  @override
  String get onboardingDragImage => 'Перетащите на PDF, чтобы разместить';

  @override
  String get onboardingResizeObject =>
      'Нажмите для выбора. Перетащите углы для изменения размера.';

  @override
  String get onboardingDeleteImage =>
      'Нажмите, чтобы удалить выбранное изображение';

  @override
  String get onboardingTapToContinue =>
      'Нажмите в любом месте, чтобы продолжить';

  @override
  String get imageConversionFailed =>
      'Не удалось преобразовать изображение в PDF';

  @override
  String get saveDocumentTitle => 'Сохранить документ';

  @override
  String get fileNameLabel => 'Имя файла';

  @override
  String get defaultFileName => 'Документ';

  @override
  String get onlyOnePdfAllowed => 'Можно открыть только один PDF-файл';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF-файлы пропущены. Конвертируются только изображения.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'изображения',
      many: 'изображений',
      few: 'изображений',
      one: 'изображения',
    );
    return 'Конвертация $count $_temp0...';
  }
}
