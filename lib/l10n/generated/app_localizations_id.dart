// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get openPdf => 'Buka PDF';

  @override
  String get selectPdf => 'Buka file';

  @override
  String get untitledDocument => 'Tanpa judul.pdf';

  @override
  String get recentFiles => 'File terbaru';

  @override
  String get removeFromList => 'Hapus dari daftar';

  @override
  String get openedNow => 'Baru dibuka';

  @override
  String openedMinutesAgo(int count) {
    return 'Dibuka $count menit yang lalu';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Dibuka $count jam yang lalu';
  }

  @override
  String get openedYesterday => 'Dibuka kemarin';

  @override
  String openedDaysAgo(int count) {
    return 'Dibuka $count hari yang lalu';
  }

  @override
  String get fileNotFound => 'File tidak ditemukan';

  @override
  String get fileAccessDenied => 'Akses ditolak';

  @override
  String get clearRecentFiles => 'Hapus file terbaru';

  @override
  String get cancel => 'Batal';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get error => 'Kesalahan';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Buka...';

  @override
  String get menuOpenRecent => 'Buka terbaru';

  @override
  String get menuNoRecentFiles => 'Tidak ada file terbaru';

  @override
  String get menuClearMenu => 'Hapus menu';

  @override
  String get menuSave => 'Simpan';

  @override
  String get menuSaveAs => 'Simpan sebagai...';

  @override
  String get menuSaveAll => 'Simpan Semua';

  @override
  String get menuShare => 'Bagikan...';

  @override
  String get menuCloseWindow => 'Tutup jendela';

  @override
  String get menuCloseAll => 'Tutup semua';

  @override
  String get menuQuit => 'Keluar dari PDFSign';

  @override
  String get closeAllDialogTitle => 'Simpan perubahan?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Apakah Anda ingin menyimpan perubahan di $count dokumen sebelum menutup?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Apakah Anda ingin menyimpan perubahan di 1 dokumen sebelum menutup?';

  @override
  String get closeAllDialogSaveAll => 'Simpan semua';

  @override
  String get closeAllDialogDontSave => 'Jangan simpan';

  @override
  String get closeAllDialogCancel => 'Batal';

  @override
  String get saveFailedDialogTitle => 'Penyimpanan Gagal';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Gagal menyimpan $count dokumen. Tetap tutup?';
  }

  @override
  String get saveFailedDialogClose => 'Tetap Tutup';

  @override
  String get saveChangesTitle => 'Simpan perubahan?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Apakah Anda ingin menyimpan perubahan di \"$fileName\" sebelum menutup?';
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
  String get menuSettings => 'Pengaturan...';

  @override
  String get menuWindow => 'Jendela';

  @override
  String get menuMinimize => 'Perkecil';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Bawa Semua ke Depan';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get settingsLanguage => 'Bahasa';

  @override
  String get settingsLanguageSystem => 'Default sistem';

  @override
  String get settingsUnits => 'Satuan';

  @override
  String get settingsUnitsCentimeters => 'Sentimeter';

  @override
  String get settingsUnitsInches => 'Inci';

  @override
  String get settingsUnitsDefault => 'Default (berdasarkan wilayah)';

  @override
  String get settingsSearchLanguages => 'Cari bahasa...';

  @override
  String get settingsGeneral => 'Umum';

  @override
  String get addImage => 'Tambah gambar';

  @override
  String get selectImages => 'Pilih gambar';

  @override
  String get zoomFitWidth => 'Sesuaikan lebar';

  @override
  String get zoomIn => 'Perbesar';

  @override
  String get zoomOut => 'Perkecil';

  @override
  String get selectZoomLevel => 'Pilih tingkat zoom';

  @override
  String get goToPage => 'Pergi ke halaman';

  @override
  String get go => 'Pergi';

  @override
  String get savePdfAs => 'Simpan PDF sebagai';

  @override
  String get incorrectPassword => 'Kata sandi salah';

  @override
  String get saveFailed => 'Gagal menyimpan';

  @override
  String savedTo(String path) {
    return 'Disimpan ke: $path';
  }

  @override
  String get noOriginalPdfStored => 'Tidak ada PDF asli tersimpan';

  @override
  String get waitingForFolderPermission => 'Menunggu izin akses folder...';

  @override
  String get emptyRecentFiles => 'Buka file untuk memulai';

  @override
  String get imagesTitle => 'Gambar';

  @override
  String get noImagesYet => 'Belum ada gambar';

  @override
  String get noImagesHint =>
      'Ketuk + untuk menambahkan stempel atau tanda tangan pertama Anda';

  @override
  String get done => 'Selesai';

  @override
  String get menuEdit => 'Edit';

  @override
  String get chooseFromFiles => 'Pilih dari file';

  @override
  String get chooseFromGallery => 'Pilih dari galeri';

  @override
  String get imageTooBig => 'Gambar terlalu besar (maks. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Resolusi terlalu tinggi (maks. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Format gambar tidak didukung';

  @override
  String get deleteTooltip => 'Hapus';

  @override
  String get shareTooltip => 'Bagikan';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Halaman $currentPage dari $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Tidak ada dokumen yang dimuat';

  @override
  String get failedToLoadPdf => 'Gagal memuat PDF';

  @override
  String get passwordRequired => 'Kata Sandi Diperlukan';

  @override
  String get pdfPasswordProtected => 'PDF ini dilindungi kata sandi.';

  @override
  String errorWithMessage(String message) {
    return 'Kesalahan: $message';
  }

  @override
  String get unsavedChangesTitle => 'Perubahan Belum Disimpan';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Apakah Anda ingin menyimpan perubahan ke \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Ketuk untuk membuka dokumen PDF';

  @override
  String get onboardingSwipeUp =>
      'Geser ke atas untuk menambahkan tanda tangan dan stempel';

  @override
  String get onboardingAddImage =>
      'Ketuk untuk menambahkan tanda tangan atau stempel pertama Anda';

  @override
  String get onboardingDragImage => 'Seret ke PDF untuk menempatkan';

  @override
  String get onboardingResizeObject =>
      'Ketuk untuk memilih. Seret sudut untuk mengubah ukuran.';

  @override
  String get onboardingDeleteImage =>
      'Ketuk untuk menghapus gambar yang dipilih';

  @override
  String get onboardingTapToContinue => 'Ketuk di mana saja untuk melanjutkan';

  @override
  String get imageConversionFailed => 'Gagal mengonversi gambar ke PDF';

  @override
  String get saveDocumentTitle => 'Simpan Dokumen';

  @override
  String get fileNameLabel => 'Nama file';

  @override
  String get defaultFileName => 'Dokumen';

  @override
  String get onlyOnePdfAllowed => 'Hanya satu PDF yang dapat dibuka sekaligus';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'File PDF diabaikan. Hanya gambar yang dikonversi.';

  @override
  String convertingImages(int count) {
    return 'Mengonversi $count gambar...';
  }

  @override
  String get takePhoto => 'Ambil foto';

  @override
  String get removeBackgroundTitle => 'Hapus latar belakang?';

  @override
  String get removeBackgroundMessage =>
      'Apakah Anda ingin menghapus latar belakang dan membuatnya transparan?';

  @override
  String get removeBackground => 'Hapus';

  @override
  String get keepOriginal => 'Simpan';

  @override
  String get processingImage => 'Memproses gambar...';

  @override
  String get backgroundRemovalFailed => 'Gagal menghapus latar belakang';

  @override
  String get passwordLabel => 'Kata sandi';

  @override
  String get unlockButton => 'Buka kunci';

  @override
  String get pasteFromClipboard => 'Tempel dari papan klip';

  @override
  String get noImageInClipboard =>
      'Tidak ada gambar di papan klip. Salin gambar terlebih dahulu.';

  @override
  String get imageDuplicated => 'Gambar diduplikasi';
}
