// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class AppLocalizationsAz extends AppLocalizations {
  AppLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get openPdf => 'PDF ac';

  @override
  String get selectPdf => 'Fayl aç';

  @override
  String get untitledDocument => 'Adsız.pdf';

  @override
  String get recentFiles => 'Son fayllar';

  @override
  String get removeFromList => 'Siyahidan sil';

  @override
  String get openedNow => 'Indi acildi';

  @override
  String openedMinutesAgo(int count) {
    return '$count deqiqe evvel acildi';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count saat evvel acildi';
  }

  @override
  String get openedYesterday => 'Dunen acildi';

  @override
  String openedDaysAgo(int count) {
    return '$count gun evvel acildi';
  }

  @override
  String get fileNotFound => 'Fayl tapilmadi';

  @override
  String get fileAccessDenied => 'Giris qadagandir';

  @override
  String get clearRecentFiles => 'Son fayllari temizle';

  @override
  String get cancel => 'Legv et';

  @override
  String get confirm => 'Tesdiqle';

  @override
  String get error => 'Xeta';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fayl';

  @override
  String get menuOpen => 'Ac...';

  @override
  String get menuOpenRecent => 'Sonlari ac';

  @override
  String get menuNoRecentFiles => 'Son fayllar yoxdur';

  @override
  String get menuClearMenu => 'Menyunu temizle';

  @override
  String get menuSave => 'Yadda saxla';

  @override
  String get menuSaveAs => 'Ferqli yadda saxla...';

  @override
  String get menuSaveAll => 'Hamısını saxla';

  @override
  String get menuShare => 'Payla...';

  @override
  String get menuCloseWindow => 'Pencerani bagla';

  @override
  String get menuCloseAll => 'Hamısını bağla';

  @override
  String get menuQuit => 'PDFSign-dan çıx';

  @override
  String get closeAllDialogTitle => 'Dəyişikliklər saxlanılsın?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Bağlamadan əvvəl $count sənəddəki dəyişiklikləri saxlamaq istəyirsiniz?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Bağlamadan əvvəl 1 sənəddəki dəyişiklikləri saxlamaq istəyirsiniz?';

  @override
  String get closeAllDialogSaveAll => 'Hamısını saxla';

  @override
  String get closeAllDialogDontSave => 'Saxlama';

  @override
  String get closeAllDialogCancel => 'Ləğv et';

  @override
  String get saveFailedDialogTitle => 'Saxlama uğursuz oldu';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count sənədi saxlamaq alınmadı. Yenə də bağlansın?';
  }

  @override
  String get saveFailedDialogClose => 'Yenə də bağla';

  @override
  String get saveChangesTitle => 'Deyisiklikleri yadda saxla?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Baglamadan evvel \"$fileName\" faylindaki deyisiklikleri yadda saxlamaq istersiniz?';
  }

  @override
  String get saveButton => 'Yadda saxla';

  @override
  String get discardButton => 'Legv et';

  @override
  String get documentEdited => 'Deyisdirildi';

  @override
  String get documentSaved => 'Yadda saxlanildi';

  @override
  String get menuSettings => 'Parametrler...';

  @override
  String get menuWindow => 'Pəncərə';

  @override
  String get menuMinimize => 'Kiçilt';

  @override
  String get menuZoom => 'Böyüt/Kiçilt';

  @override
  String get menuBringAllToFront => 'Hamısını öndə göstər';

  @override
  String get settingsTitle => 'Parametrler';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsLanguageSystem => 'Sistem defolt';

  @override
  String get settingsUnits => 'Olcu vahidleri';

  @override
  String get settingsUnitsCentimeters => 'Santimetr';

  @override
  String get settingsUnitsInches => 'Duym';

  @override
  String get settingsSearchLanguages => 'Dil axtar...';

  @override
  String get settingsGeneral => 'Ümumi';

  @override
  String get addImage => 'Şəkil əlavə et';

  @override
  String get selectImages => 'Şəkilləri seç';

  @override
  String get zoomFitWidth => 'Enə sığdır';

  @override
  String get zoomIn => 'Yaxınlaşdır';

  @override
  String get zoomOut => 'Uzaqlaşdır';

  @override
  String get selectZoomLevel => 'Böyütmə səviyyəsini seç';

  @override
  String get goToPage => 'Səhifəyə keç';

  @override
  String get go => 'Keç';

  @override
  String get savePdfAs => 'PDF olaraq saxla';

  @override
  String get incorrectPassword => 'Yanlış şifrə';

  @override
  String get saveFailed => 'Saxlama uğursuz';

  @override
  String savedTo(String path) {
    return 'Saxlanıldı: $path';
  }

  @override
  String get noOriginalPdfStored => 'Orijinal PDF saxlanılmayıb';

  @override
  String get waitingForFolderPermission =>
      'Qovluğa giriş icazəsi gözlənilir...';

  @override
  String get emptyRecentFiles => 'Başlamaq üçün fayl açın';

  @override
  String get imagesTitle => 'Şəkillər';

  @override
  String get noImagesYet => 'Hələ şəkil yoxdur';

  @override
  String get noImagesHint =>
      'İlk möhür və ya imzanızı əlavə etmək üçün + vurun';

  @override
  String get done => 'Hazır';

  @override
  String get menuEdit => 'Redaktə et';

  @override
  String get chooseFromFiles => 'Fayllardan seç';

  @override
  String get chooseFromGallery => 'Qalereyadan seç';

  @override
  String get imageTooBig => 'Şəkil çox böyükdür (maks. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Həlletmə çox yüksəkdir (maks. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Dəstəklənməyən şəkil formatı';

  @override
  String get deleteTooltip => 'Sil';

  @override
  String get shareTooltip => 'Paylaş';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Səhifə $currentPage / $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Sənəd yüklənməyib';

  @override
  String get failedToLoadPdf => 'PDF yükləmək alınmadı';

  @override
  String get passwordRequired => 'Şifrə tələb olunur';

  @override
  String get pdfPasswordProtected => 'Bu PDF şifrə ilə qorunur.';

  @override
  String errorWithMessage(String message) {
    return 'Xəta: $message';
  }

  @override
  String get unsavedChangesTitle => 'Saxlanılmamış dəyişikliklər';

  @override
  String unsavedChangesMessage(String fileName) {
    return '\"$fileName\" faylındakı dəyişiklikləri saxlamaq istəyirsiniz?';
  }

  @override
  String get onboardingOpenPdf => 'PDF sənədini açmaq üçün toxunun';

  @override
  String get onboardingSwipeUp =>
      'İmza və möhürlər əlavə etmək üçün yuxarı sürüşdürün';

  @override
  String get onboardingAddImage =>
      'İlk imzanızı və ya möhürünüzü əlavə etmək üçün toxunun';

  @override
  String get onboardingDragImage => 'Yerləşdirmək üçün PDF üzərinə sürükləyin';

  @override
  String get onboardingResizeObject =>
      'Seçmək üçün toxunun. Ölçüsünü dəyişmək üçün künclərini sürükləyin.';

  @override
  String get onboardingDeleteImage => 'Tap to delete the selected image';

  @override
  String get onboardingTapToContinue =>
      'Davam etmək üçün istənilən yerə toxunun';

  @override
  String get imageConversionFailed => 'Şəkli PDF-ə çevirmək alınmadı';
}
