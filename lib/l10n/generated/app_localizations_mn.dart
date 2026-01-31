// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Mongolian (`mn`).
class AppLocalizationsMn extends AppLocalizations {
  AppLocalizationsMn([String locale = 'mn']) : super(locale);

  @override
  String get openPdf => 'PDF neekh';

  @override
  String get selectPdf => 'Файл нээх';

  @override
  String get untitledDocument => 'Нэргүй.pdf';

  @override
  String get recentFiles => 'Suuliin failuud';

  @override
  String get removeFromList => 'Jisneesee ustgakh';

  @override
  String get openedNow => 'Doorond neegdsen';

  @override
  String openedMinutesAgo(int count) {
    return '$count minut umnuh neegdsen';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count tsag umnuh neegdsen';
  }

  @override
  String get openedYesterday => 'Uchidar neegdsen';

  @override
  String openedDaysAgo(int count) {
    return '$count udur umnuh neegdsen';
  }

  @override
  String get fileNotFound => 'Fail oldsongui';

  @override
  String get fileAccessDenied => 'Nevtrekh khorigdson';

  @override
  String get clearRecentFiles => 'Suuliin failuudig tsooglokh';

  @override
  String get cancel => 'Tsooglokh';

  @override
  String get confirm => 'Batalgaajulakh';

  @override
  String get error => 'Aldaa';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fail';

  @override
  String get menuOpen => 'Neekh...';

  @override
  String get menuOpenRecent => 'Suuliiniig neekh';

  @override
  String get menuNoRecentFiles => 'Suuliin failuud baihgui';

  @override
  String get menuClearMenu => 'Tsesiig tsooglokh';

  @override
  String get menuSave => 'Khadgalakh';

  @override
  String get menuSaveAs => 'Uur nereeer khadgalakh...';

  @override
  String get menuSaveAll => 'Бүгдийг хадгалах';

  @override
  String get menuShare => 'Khuvaaltsakh...';

  @override
  String get menuCloseWindow => 'Tsonkhig khakh';

  @override
  String get menuCloseAll => 'Бүгдийг хаах';

  @override
  String get menuQuit => 'PDFSign-аас гарах';

  @override
  String get closeAllDialogTitle => 'Өөрчлөлтүүдийг хадгалах уу?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Хаахаас өмнө $count баримт бичигт өөрчлөлтүүдийг хадгалах уу?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Хаахаас өмнө 1 баримт бичигт өөрчлөлтүүдийг хадгалах уу?';

  @override
  String get closeAllDialogSaveAll => 'Бүгдийг хадгалах';

  @override
  String get closeAllDialogDontSave => 'Хадгалахгүй';

  @override
  String get closeAllDialogCancel => 'Цуцлах';

  @override
  String get saveFailedDialogTitle => 'Хадгалах амжилтгүй';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count баримт бичгийг хадгалж чадсангүй. Гэсэн хэдий ч хаах уу?';
  }

  @override
  String get saveFailedDialogClose => 'Гэсэн хэдий ч хаах';

  @override
  String get saveChangesTitle => 'Uurchlultiig khadgalakh uu?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Ta \"$fileName\" failliin uurchlultiig khakhaskhan umnuh khadgalakh uu?';
  }

  @override
  String get saveButton => 'Khadgalakh';

  @override
  String get discardButton => 'Ustgakh';

  @override
  String get documentEdited => 'Uurchilsen';

  @override
  String get documentSaved => 'Khadgalagdsan';

  @override
  String get menuSettings => 'Tohirgoo...';

  @override
  String get menuWindow => 'Цонх';

  @override
  String get menuMinimize => 'Багасгах';

  @override
  String get menuZoom => 'Масштаб';

  @override
  String get menuBringAllToFront => 'Бүгдийг урд авчрах';

  @override
  String get settingsTitle => 'Tohirgoo';

  @override
  String get settingsLanguage => 'Khel';

  @override
  String get settingsLanguageSystem => 'Sistemiin suuri';

  @override
  String get settingsUnits => 'Khemjeekh neghj';

  @override
  String get settingsUnitsCentimeters => 'Santimetr';

  @override
  String get settingsUnitsInches => 'Inch';

  @override
  String get settingsSearchLanguages => 'Хэл хайх...';

  @override
  String get settingsGeneral => 'Ерөнхий';

  @override
  String get addImage => 'Зураг нэмэх';

  @override
  String get selectImages => 'Зураг сонгох';

  @override
  String get zoomFitWidth => 'Өргөнд тохируулах';

  @override
  String get zoomIn => 'Томруулах';

  @override
  String get zoomOut => 'Жижигрүүлэх';

  @override
  String get selectZoomLevel => 'Томруулах түвшин сонгох';

  @override
  String get goToPage => 'Хуудас руу очих';

  @override
  String get go => 'Очих';

  @override
  String get savePdfAs => 'PDF болгон хадгалах';

  @override
  String get incorrectPassword => 'Буруу нууц үг';

  @override
  String get saveFailed => 'Хадгалалт амжилтгүй';

  @override
  String savedTo(String path) {
    return 'Хадгалагдсан: $path';
  }

  @override
  String get noOriginalPdfStored => 'Эх PDF хадгалагдаагүй';

  @override
  String get waitingForFolderPermission =>
      'Хавтас руу нэвтрэх зөвшөөрөл хүлээж байна...';

  @override
  String get emptyRecentFiles => 'Эхлэхийн тулд файл нээх';

  @override
  String get imagesTitle => 'Зургууд';

  @override
  String get noImagesYet => 'Зураг байхгүй байна';

  @override
  String get noImagesHint =>
      'Анхны тамга эсвэл гарын үсгээ нэмэхийн тулд + дээр дарна уу';

  @override
  String get done => 'Дууссан';

  @override
  String get menuEdit => 'Засах';

  @override
  String get chooseFromFiles => 'Файлуудаас сонгох';

  @override
  String get chooseFromGallery => 'Галерейгаас сонгох';

  @override
  String get imageTooBig => 'Зураг хэт том байна (хамгийн ихдээ 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Нягтрал хэт өндөр байна (хамгийн ихдээ 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Дэмжигдээгүй зургийн формат';

  @override
  String get deleteTooltip => 'Устгах';

  @override
  String get shareTooltip => 'Хуваалцах';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Хуудас $currentPage / $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Баримт бичиг ачаалагдаагүй';

  @override
  String get failedToLoadPdf => 'PDF ачаалж чадсангүй';

  @override
  String get passwordRequired => 'Нууц үг шаардлагатай';

  @override
  String get pdfPasswordProtected => 'Энэ PDF нууц үгээр хамгаалагдсан.';

  @override
  String errorWithMessage(String message) {
    return 'Алдаа: $message';
  }

  @override
  String get unsavedChangesTitle => 'Хадгалаагүй өөрчлөлтүүд';

  @override
  String unsavedChangesMessage(String fileName) {
    return '\"$fileName\" дахь өөрчлөлтүүдийг хадгалах уу?';
  }

  @override
  String get onboardingOpenPdf => 'PDF баримт бичгийг нээхийн тулд дарна уу';

  @override
  String get onboardingSwipeUp =>
      'Гарын үсэг болон тамга нэмэхийн тулд дээш шударна уу';

  @override
  String get onboardingAddImage =>
      'Анхны гарын үсэг эсвэл тамгаа нэмэхийн тулд дарна уу';

  @override
  String get onboardingDragImage => 'Байрлуулахын тулд PDF руу чирнэ үү';

  @override
  String get onboardingResizeObject =>
      'Сонгохын тулд дарна уу. Хэмжээг өөрчлөхийн тулд булангуудыг чирнэ үү.';

  @override
  String get onboardingDeleteImage => 'Сонгосон зургийг устгахын тулд дарна уу';

  @override
  String get onboardingTapToContinue => 'Үргэлжлүүлэхийн тулд хаана ч дарна уу';

  @override
  String get imageConversionFailed => 'Зургийг PDF болгон хөрвүүлж чадсангүй';

  @override
  String get saveDocumentTitle => 'Баримт бичиг хадгалах';

  @override
  String get fileNameLabel => 'Файлын нэр';

  @override
  String get defaultFileName => 'Баримт бичиг';

  @override
  String get onlyOnePdfAllowed => 'Нэг удаад зөвхөн нэг PDF нээх боломжтой';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF файлуудыг үл хэрэгссэн. Зөвхөн зургуудыг хөрвүүлнэ.';
}
