// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get openPdf => 'PDF Aç';

  @override
  String get selectPdf => 'Dosya Aç';

  @override
  String get untitledDocument => 'İsimsiz.pdf';

  @override
  String get recentFiles => 'Son dosyalar';

  @override
  String get removeFromList => 'Listeden kaldır';

  @override
  String get openedNow => 'Az önce açıldı';

  @override
  String openedMinutesAgo(int count) {
    return '$count dakika önce açıldı';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count saat önce açıldı';
  }

  @override
  String get openedYesterday => 'Dün açıldı';

  @override
  String openedDaysAgo(int count) {
    return '$count gün önce açıldı';
  }

  @override
  String get fileNotFound => 'Dosya bulunamadı';

  @override
  String get fileAccessDenied => 'Erişim reddedildi';

  @override
  String get clearRecentFiles => 'Son dosyaları temizle';

  @override
  String get cancel => 'İptal';

  @override
  String get confirm => 'Onayla';

  @override
  String get error => 'Hata';

  @override
  String get ok => 'Tamam';

  @override
  String get menuFile => 'Dosya';

  @override
  String get menuOpen => 'Aç...';

  @override
  String get menuOpenRecent => 'Son Kullanılanları Aç';

  @override
  String get menuNoRecentFiles => 'Son dosya yok';

  @override
  String get menuClearMenu => 'Menüyü Temizle';

  @override
  String get menuSave => 'Kaydet';

  @override
  String get menuSaveAs => 'Farklı Kaydet...';

  @override
  String get menuSaveAll => 'Tümünü Kaydet';

  @override
  String get menuShare => 'Paylaş...';

  @override
  String get menuCloseWindow => 'Pencereyi Kapat';

  @override
  String get menuCloseAll => 'Tümünü Kapat';

  @override
  String get menuQuit => 'PDFSign\'dan Çık';

  @override
  String get closeAllDialogTitle => 'Değişiklikler kaydedilsin mi?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Kapatmadan önce $count belgedeki değişiklikleri kaydetmek istiyor musunuz?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Kapatmadan önce 1 belgedeki değişiklikleri kaydetmek istiyor musunuz?';

  @override
  String get closeAllDialogSaveAll => 'Tümünü Kaydet';

  @override
  String get closeAllDialogDontSave => 'Kaydetme';

  @override
  String get closeAllDialogCancel => 'İptal';

  @override
  String get saveFailedDialogTitle => 'Kaydetme başarısız';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count belge kaydedilemedi. Yine de kapatılsın mı?';
  }

  @override
  String get saveFailedDialogClose => 'Yine de Kapat';

  @override
  String get saveChangesTitle => 'Değişiklikler kaydedilsin mi?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Kapatmadan önce \"$fileName\" dosyasındaki değişiklikleri kaydetmek istiyor musunuz?';
  }

  @override
  String get saveButton => 'Kaydet';

  @override
  String get discardButton => 'Kaydetme';

  @override
  String get documentEdited => 'Düzenlendi';

  @override
  String get documentSaved => 'Kaydedildi';

  @override
  String get menuSettings => 'Ayarlar...';

  @override
  String get menuWindow => 'Pencere';

  @override
  String get menuMinimize => 'Simge Durumuna Küçült';

  @override
  String get menuZoom => 'Büyüt/Küçült';

  @override
  String get menuBringAllToFront => 'Tümünü Öne Getir';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsLanguageSystem => 'Sistem varsayılanı';

  @override
  String get settingsUnits => 'Birimler';

  @override
  String get settingsUnitsCentimeters => 'Santimetre';

  @override
  String get settingsUnitsInches => 'İnç';

  @override
  String get settingsUnitsDefault => 'Varsayılan (bölgeye göre)';

  @override
  String get settingsSearchLanguages => 'Dil ara...';

  @override
  String get settingsGeneral => 'Genel';

  @override
  String get addImage => 'Resim ekle';

  @override
  String get selectImages => 'Resimleri seç';

  @override
  String get zoomFitWidth => 'Genişliğe sığdır';

  @override
  String get zoomIn => 'Yakınlaştır';

  @override
  String get zoomOut => 'Uzaklaştır';

  @override
  String get selectZoomLevel => 'Yakınlaştırma seviyesi seç';

  @override
  String get goToPage => 'Sayfaya git';

  @override
  String get go => 'Git';

  @override
  String get savePdfAs => 'PDF olarak kaydet';

  @override
  String get incorrectPassword => 'Hatalı şifre';

  @override
  String get saveFailed => 'Kaydetme başarısız';

  @override
  String savedTo(String path) {
    return 'Kaydedildi: $path';
  }

  @override
  String get noOriginalPdfStored => 'Orijinal PDF kaydedilmedi';

  @override
  String get waitingForFolderPermission => 'Klasör erişim izni bekleniyor...';

  @override
  String get emptyRecentFiles => 'Başlamak için bir dosya açın';

  @override
  String get imagesTitle => 'Resimler';

  @override
  String get noImagesYet => 'Henüz resim yok';

  @override
  String get noImagesHint =>
      'İlk damga veya imzanızı eklemek için + simgesine dokunun';

  @override
  String get done => 'Bitti';

  @override
  String get menuEdit => 'Düzenle';

  @override
  String get chooseFromFiles => 'Dosyalardan seç';

  @override
  String get chooseFromGallery => 'Galeriden seç';

  @override
  String get imageTooBig => 'Resim çok büyük (maks. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Çözünürlük çok yüksek (maks. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Desteklenmeyen resim formatı';

  @override
  String get deleteTooltip => 'Sil';

  @override
  String get shareTooltip => 'Paylaş';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Sayfa $currentPage / $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Belge yüklenmedi';

  @override
  String get failedToLoadPdf => 'PDF yüklenemedi';

  @override
  String get passwordRequired => 'Şifre Gerekli';

  @override
  String get pdfPasswordProtected => 'Bu PDF şifre korumalıdır.';

  @override
  String errorWithMessage(String message) {
    return 'Hata: $message';
  }

  @override
  String get unsavedChangesTitle => 'Kaydedilmemiş Değişiklikler';

  @override
  String unsavedChangesMessage(String fileName) {
    return '\"$fileName\" dosyasındaki değişiklikleri kaydetmek istiyor musunuz?';
  }

  @override
  String get onboardingOpenPdf => 'Bir PDF belgesi açmak için dokunun';

  @override
  String get onboardingSwipeUp => 'İmza ve damga eklemek için yukarı kaydırın';

  @override
  String get onboardingAddImage =>
      'İlk imzanızı veya damganızı eklemek için dokunun';

  @override
  String get onboardingDragImage => 'Yerleştirmek için PDF üzerine sürükleyin';

  @override
  String get onboardingResizeObject =>
      'Seçmek için dokunun. Boyutlandırmak için köşeleri sürükleyin.';

  @override
  String get onboardingDeleteImage => 'Seçili resmi silmek için dokunun';

  @override
  String get onboardingTapToContinue =>
      'Devam etmek için herhangi bir yere dokunun';

  @override
  String get imageConversionFailed => 'Görsel PDF\'ye dönüştürülemedi';

  @override
  String get saveDocumentTitle => 'Belgeyi kaydet';

  @override
  String get fileNameLabel => 'Dosya adı';

  @override
  String get defaultFileName => 'Belge';

  @override
  String get onlyOnePdfAllowed => 'Aynı anda yalnızca bir PDF açılabilir';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'PDF dosyaları yok sayıldı. Yalnızca resimler dönüştürülüyor.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'görsel',
      one: 'görsel',
    );
    return '$count $_temp0 dönüştürülüyor...';
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
