// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get openPdf => 'Buka PDF';

  @override
  String get selectPdf => 'Pilih PDF';

  @override
  String get recentFiles => 'Fail terkini';

  @override
  String get removeFromList => 'Alih keluar dari senarai';

  @override
  String get openedNow => 'Baru dibuka';

  @override
  String openedMinutesAgo(int count) {
    return 'Dibuka $count minit lalu';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Dibuka $count jam lalu';
  }

  @override
  String get openedYesterday => 'Dibuka semalam';

  @override
  String openedDaysAgo(int count) {
    return 'Dibuka $count hari lalu';
  }

  @override
  String get fileNotFound => 'Fail tidak dijumpai';

  @override
  String get fileAccessDenied => 'Akses ditolak';

  @override
  String get clearRecentFiles => 'Kosongkan fail terkini';

  @override
  String get cancel => 'Batal';

  @override
  String get confirm => 'Sahkan';

  @override
  String get error => 'Ralat';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fail';

  @override
  String get menuOpen => 'Buka...';

  @override
  String get menuOpenRecent => 'Buka terkini';

  @override
  String get menuNoRecentFiles => 'Tiada fail terkini';

  @override
  String get menuClearMenu => 'Kosongkan menu';

  @override
  String get menuSave => 'Simpan';

  @override
  String get menuSaveAs => 'Simpan sebagai...';

  @override
  String get menuSaveAll => 'Simpan Semua';

  @override
  String get menuShare => 'Kongsi...';

  @override
  String get menuCloseWindow => 'Tutup tetingkap';

  @override
  String get menuCloseAll => 'Tutup semua';

  @override
  String get menuQuit => 'Keluar PDFSign';

  @override
  String get closeAllDialogTitle => 'Simpan perubahan?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Adakah anda ingin menyimpan perubahan dalam $count dokumen sebelum menutup?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Adakah anda ingin menyimpan perubahan dalam 1 dokumen sebelum menutup?';

  @override
  String get closeAllDialogSaveAll => 'Simpan semua';

  @override
  String get closeAllDialogDontSave => 'Jangan simpan';

  @override
  String get closeAllDialogCancel => 'Batal';

  @override
  String get saveFailedDialogTitle => 'Simpan Gagal';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Gagal menyimpan $count dokumen. Tutup juga?';
  }

  @override
  String get saveFailedDialogClose => 'Tutup Juga';

  @override
  String get saveChangesTitle => 'Simpan perubahan?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Adakah anda ingin menyimpan perubahan dalam \"$fileName\" sebelum menutup?';
  }

  @override
  String get saveButton => 'Simpan';

  @override
  String get discardButton => 'Jangan simpan';

  @override
  String get documentEdited => 'Diedit';

  @override
  String get documentSaved => 'Disimpan';

  @override
  String get menuSettings => 'Tetapan...';

  @override
  String get menuWindow => 'Tetingkap';

  @override
  String get menuMinimize => 'Kecilkan';

  @override
  String get menuZoom => 'Zum';

  @override
  String get menuBringAllToFront => 'Bawa Semua ke Hadapan';

  @override
  String get settingsTitle => 'Tetapan';

  @override
  String get settingsLanguage => 'Bahasa';

  @override
  String get settingsLanguageSystem => 'Lalai sistem';

  @override
  String get settingsUnits => 'Unit';

  @override
  String get settingsUnitsCentimeters => 'Sentimeter';

  @override
  String get settingsUnitsInches => 'Inci';

  @override
  String get settingsSearchLanguages => 'Cari bahasa...';

  @override
  String get settingsGeneral => 'Umum';

  @override
  String get addImage => 'Tambah imej';

  @override
  String get selectImages => 'Pilih imej';

  @override
  String get zoomFitWidth => 'Muat lebar';

  @override
  String get zoomIn => 'Zum masuk';

  @override
  String get zoomOut => 'Zum keluar';

  @override
  String get selectZoomLevel => 'Pilih tahap zum';

  @override
  String get goToPage => 'Pergi ke halaman';

  @override
  String get go => 'Pergi';

  @override
  String get savePdfAs => 'Simpan PDF sebagai';

  @override
  String get incorrectPassword => 'Kata laluan salah';

  @override
  String get saveFailed => 'Gagal menyimpan';

  @override
  String savedTo(String path) {
    return 'Disimpan ke: $path';
  }

  @override
  String get noOriginalPdfStored => 'Tiada PDF asal disimpan';

  @override
  String get waitingForFolderPermission => 'Menunggu kebenaran akses folder...';

  @override
  String get emptyRecentFiles => 'Buka PDF untuk bermula';

  @override
  String get imagesTitle => 'Imej';

  @override
  String get noImagesYet => 'Tiada imej lagi';

  @override
  String get noImagesHint =>
      'Ketik + untuk menambah cop atau tandatangan pertama anda';

  @override
  String get done => 'Selesai';

  @override
  String get menuEdit => 'Edit';

  @override
  String get chooseFromFiles => 'Pilih dari fail';

  @override
  String get chooseFromGallery => 'Pilih dari galeri';

  @override
  String get imageTooBig => 'Imej terlalu besar (maks. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Resolusi terlalu tinggi (maks. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Format imej tidak disokong';
}
