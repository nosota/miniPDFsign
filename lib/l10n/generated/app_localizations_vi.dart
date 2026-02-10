// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get openPdf => 'Mo PDF';

  @override
  String get selectPdf => 'Mở tệp';

  @override
  String get untitledDocument => 'Chưa đặt tên.pdf';

  @override
  String get recentFiles => 'Tap tin gan day';

  @override
  String get removeFromList => 'Xoa khoi danh sach';

  @override
  String get openedNow => 'Vua mo';

  @override
  String openedMinutesAgo(int count) {
    return 'Da mo $count phut truoc';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Da mo $count gio truoc';
  }

  @override
  String get openedYesterday => 'Da mo hom qua';

  @override
  String openedDaysAgo(int count) {
    return 'Da mo $count ngay truoc';
  }

  @override
  String get fileNotFound => 'Khong tim thay tap tin';

  @override
  String get fileAccessDenied => 'Truy cap bi tu choi';

  @override
  String get clearRecentFiles => 'Xoa tap tin gan day';

  @override
  String get cancel => 'Huy';

  @override
  String get confirm => 'Xac nhan';

  @override
  String get error => 'Loi';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Tap tin';

  @override
  String get menuOpen => 'Mo...';

  @override
  String get menuOpenRecent => 'Mo gan day';

  @override
  String get menuNoRecentFiles => 'Khong co tap tin gan day';

  @override
  String get menuClearMenu => 'Xoa menu';

  @override
  String get menuSave => 'Luu';

  @override
  String get menuSaveAs => 'Luu nhu...';

  @override
  String get menuSaveAll => 'Lưu Tất Cả';

  @override
  String get menuShare => 'Chia se...';

  @override
  String get menuCloseWindow => 'Dong cua so';

  @override
  String get menuCloseAll => 'Đóng tất cả';

  @override
  String get menuQuit => 'Thoát PDFSign';

  @override
  String get closeAllDialogTitle => 'Lưu thay đổi?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Bạn có muốn lưu thay đổi trong $count tài liệu trước khi đóng không?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Bạn có muốn lưu thay đổi trong 1 tài liệu trước khi đóng không?';

  @override
  String get closeAllDialogSaveAll => 'Lưu tất cả';

  @override
  String get closeAllDialogDontSave => 'Không lưu';

  @override
  String get closeAllDialogCancel => 'Hủy';

  @override
  String get saveFailedDialogTitle => 'Lưu thất bại';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Không thể lưu $count tài liệu. Vẫn đóng?';
  }

  @override
  String get saveFailedDialogClose => 'Vẫn Đóng';

  @override
  String get saveChangesTitle => 'Luu thay doi?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Ban co muon luu thay doi trong \"$fileName\" truoc khi dong?';
  }

  @override
  String get saveButton => 'Luu';

  @override
  String get discardButton => 'Khong luu';

  @override
  String get documentEdited => 'Da chinh sua';

  @override
  String get documentSaved => 'Da luu';

  @override
  String get menuSettings => 'Cai dat...';

  @override
  String get menuWindow => 'Cửa sổ';

  @override
  String get menuMinimize => 'Thu nhỏ';

  @override
  String get menuZoom => 'Phóng to';

  @override
  String get menuBringAllToFront => 'Đưa tất cả ra phía trước';

  @override
  String get settingsTitle => 'Cai dat';

  @override
  String get settingsLanguage => 'Ngon ngu';

  @override
  String get settingsLanguageSystem => 'Mac dinh he thong';

  @override
  String get settingsUnits => 'Don vi';

  @override
  String get settingsUnitsCentimeters => 'Centimet';

  @override
  String get settingsUnitsInches => 'Inch';

  @override
  String get settingsUnitsDefault => 'Mặc định (theo vùng)';

  @override
  String get settingsSearchLanguages => 'Tìm kiếm ngôn ngữ...';

  @override
  String get settingsGeneral => 'Chung';

  @override
  String get addImage => 'Thêm hình ảnh';

  @override
  String get selectImages => 'Chọn hình ảnh';

  @override
  String get zoomFitWidth => 'Vừa chiều rộng';

  @override
  String get zoomIn => 'Phóng to';

  @override
  String get zoomOut => 'Thu nhỏ';

  @override
  String get selectZoomLevel => 'Chọn mức thu phóng';

  @override
  String get goToPage => 'Đi đến trang';

  @override
  String get go => 'Đi';

  @override
  String get savePdfAs => 'Lưu PDF thành';

  @override
  String get incorrectPassword => 'Mật khẩu không đúng';

  @override
  String get saveFailed => 'Lưu thất bại';

  @override
  String savedTo(String path) {
    return 'Đã lưu tại: $path';
  }

  @override
  String get noOriginalPdfStored => 'Không có PDF gốc được lưu';

  @override
  String get waitingForFolderPermission => 'Đang chờ quyền truy cập thư mục...';

  @override
  String get emptyRecentFiles => 'Mở tệp để bắt đầu';

  @override
  String get imagesTitle => 'Hình ảnh';

  @override
  String get noImagesYet => 'Chưa có hình ảnh';

  @override
  String get noImagesHint => 'Nhấn + để thêm con dấu hoặc chữ ký đầu tiên';

  @override
  String get done => 'Xong';

  @override
  String get menuEdit => 'Chỉnh sửa';

  @override
  String get chooseFromFiles => 'Chọn từ tệp';

  @override
  String get chooseFromGallery => 'Chọn từ thư viện';

  @override
  String get imageTooBig => 'Hình ảnh quá lớn (tối đa 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Độ phân giải quá cao (tối đa 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Định dạng hình ảnh không được hỗ trợ';

  @override
  String get deleteTooltip => 'Xóa';

  @override
  String get shareTooltip => 'Chia sẻ';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Trang $currentPage / $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Chưa tải tài liệu';

  @override
  String get failedToLoadPdf => 'Không thể tải PDF';

  @override
  String get passwordRequired => 'Yêu cầu mật khẩu';

  @override
  String get pdfPasswordProtected => 'PDF này được bảo vệ bằng mật khẩu.';

  @override
  String errorWithMessage(String message) {
    return 'Lỗi: $message';
  }

  @override
  String get unsavedChangesTitle => 'Thay đổi chưa lưu';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Bạn có muốn lưu thay đổi vào \"$fileName\" không?';
  }

  @override
  String get onboardingOpenPdf => 'Nhấn để mở tài liệu PDF';

  @override
  String get onboardingSwipeUp => 'Vuốt lên để thêm chữ ký và con dấu';

  @override
  String get onboardingAddImage => 'Nhấn để thêm chữ ký hoặc con dấu đầu tiên';

  @override
  String get onboardingDragImage => 'Kéo vào PDF để đặt vị trí';

  @override
  String get onboardingResizeObject =>
      'Nhấn để chọn. Kéo góc để thay đổi kích thước.';

  @override
  String get onboardingDeleteImage => 'Nhấn để xóa hình ảnh đã chọn';

  @override
  String get onboardingTapToContinue => 'Nhấn vào bất kỳ đâu để tiếp tục';

  @override
  String get imageConversionFailed => 'Không thể chuyển đổi hình ảnh sang PDF';

  @override
  String get saveDocumentTitle => 'Lưu tài liệu';

  @override
  String get fileNameLabel => 'Tên tệp';

  @override
  String get defaultFileName => 'Tài liệu';

  @override
  String get onlyOnePdfAllowed => 'Chỉ có thể mở một tệp PDF tại một thời điểm';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'Các tệp PDF đã bị bỏ qua. Chỉ chuyển đổi hình ảnh.';

  @override
  String convertingImages(int count) {
    return 'Đang chuyển đổi $count hình ảnh...';
  }

  @override
  String get takePhoto => 'Chụp ảnh';

  @override
  String get removeBackgroundTitle => 'Xóa nền?';

  @override
  String get removeBackgroundMessage =>
      'Bạn có muốn xóa nền và làm cho nó trong suốt không?';

  @override
  String get removeBackground => 'Xóa';

  @override
  String get keepOriginal => 'Giữ';

  @override
  String get processingImage => 'Đang xử lý hình ảnh...';

  @override
  String get backgroundRemovalFailed => 'Xóa nền thất bại';

  @override
  String get passwordLabel => 'Mật khẩu';

  @override
  String get unlockButton => 'Mở khóa';

  @override
  String get pasteFromClipboard => 'Dán từ bộ nhớ tạm';

  @override
  String get noImageInClipboard =>
      'Không có hình ảnh trong bộ nhớ tạm. Hãy sao chép hình ảnh trước.';
}
