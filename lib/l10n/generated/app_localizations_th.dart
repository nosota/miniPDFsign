// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get openPdf => 'เปิด PDF';

  @override
  String get selectPdf => 'เปิดไฟล์';

  @override
  String get untitledDocument => 'ไม่มีชื่อ.pdf';

  @override
  String get recentFiles => 'ไฟล์ล่าสุด';

  @override
  String get removeFromList => 'ลบออกจากรายการ';

  @override
  String get openedNow => 'เพิ่งเปิด';

  @override
  String openedMinutesAgo(int count) {
    return 'เปิดเมื่อ $count นาทีที่แล้ว';
  }

  @override
  String openedHoursAgo(int count) {
    return 'เปิดเมื่อ $count ชั่วโมงที่แล้ว';
  }

  @override
  String get openedYesterday => 'เปิดเมื่อวานนี้';

  @override
  String openedDaysAgo(int count) {
    return 'เปิดเมื่อ $count วันที่แล้ว';
  }

  @override
  String get fileNotFound => 'ไม่พบไฟล์';

  @override
  String get fileAccessDenied => 'การเข้าถึงถูกปฏิเสธ';

  @override
  String get clearRecentFiles => 'ล้างไฟล์ล่าสุด';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get confirm => 'ยืนยัน';

  @override
  String get error => 'ข้อผิดพลาด';

  @override
  String get ok => 'ตกลง';

  @override
  String get menuFile => 'ไฟล์';

  @override
  String get menuOpen => 'เปิด...';

  @override
  String get menuOpenRecent => 'เปิดล่าสุด';

  @override
  String get menuNoRecentFiles => 'ไม่มีไฟล์ล่าสุด';

  @override
  String get menuClearMenu => 'ล้างเมนู';

  @override
  String get menuSave => 'บันทึก';

  @override
  String get menuSaveAs => 'บันทึกเป็น...';

  @override
  String get menuSaveAll => 'บันทึกทั้งหมด';

  @override
  String get menuShare => 'แชร์...';

  @override
  String get menuCloseWindow => 'ปิดหน้าต่าง';

  @override
  String get menuCloseAll => 'ปิดทั้งหมด';

  @override
  String get menuQuit => 'ออกจาก PDFSign';

  @override
  String get closeAllDialogTitle => 'บันทึกการเปลี่ยนแปลง?';

  @override
  String closeAllDialogMessage(int count) {
    return 'คุณต้องการบันทึกการเปลี่ยนแปลงใน $count เอกสารก่อนปิดหรือไม่?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'คุณต้องการบันทึกการเปลี่ยนแปลงใน 1 เอกสารก่อนปิดหรือไม่?';

  @override
  String get closeAllDialogSaveAll => 'บันทึกทั้งหมด';

  @override
  String get closeAllDialogDontSave => 'ไม่บันทึก';

  @override
  String get closeAllDialogCancel => 'ยกเลิก';

  @override
  String get saveFailedDialogTitle => 'บันทึกล้มเหลว';

  @override
  String saveFailedDialogMessage(int count) {
    return 'บันทึก $count เอกสารไม่สำเร็จ ปิดต่อไปหรือไม่?';
  }

  @override
  String get saveFailedDialogClose => 'ปิดต่อไป';

  @override
  String get saveChangesTitle => 'บันทึกการเปลี่ยนแปลง?';

  @override
  String saveChangesMessage(String fileName) {
    return 'คุณต้องการบันทึกการเปลี่ยนแปลงใน \"$fileName\" ก่อนปิดหรือไม่?';
  }

  @override
  String get saveButton => 'บันทึก';

  @override
  String get discardButton => 'ไม่บันทึก';

  @override
  String get documentEdited => 'แก้ไขแล้ว';

  @override
  String get documentSaved => 'บันทึกแล้ว';

  @override
  String get menuSettings => 'การตั้งค่า...';

  @override
  String get menuWindow => 'หน้าต่าง';

  @override
  String get menuMinimize => 'ย่อเล็กสุด';

  @override
  String get menuZoom => 'ซูม';

  @override
  String get menuBringAllToFront => 'นำทั้งหมดมาข้างหน้า';

  @override
  String get settingsTitle => 'การตั้งค่า';

  @override
  String get settingsLanguage => 'ภาษา';

  @override
  String get settingsLanguageSystem => 'ค่าเริ่มต้นของระบบ';

  @override
  String get settingsUnits => 'หน่วย';

  @override
  String get settingsUnitsCentimeters => 'เซนติเมตร';

  @override
  String get settingsUnitsInches => 'นิ้ว';

  @override
  String get settingsSearchLanguages => 'ค้นหาภาษา...';

  @override
  String get settingsGeneral => 'ทั่วไป';

  @override
  String get addImage => 'เพิ่มรูปภาพ';

  @override
  String get selectImages => 'เลือกรูปภาพ';

  @override
  String get zoomFitWidth => 'พอดีความกว้าง';

  @override
  String get zoomIn => 'ซูมเข้า';

  @override
  String get zoomOut => 'ซูมออก';

  @override
  String get selectZoomLevel => 'เลือกระดับการซูม';

  @override
  String get goToPage => 'ไปที่หน้า';

  @override
  String get go => 'ไป';

  @override
  String get savePdfAs => 'บันทึก PDF เป็น';

  @override
  String get incorrectPassword => 'รหัสผ่านไม่ถูกต้อง';

  @override
  String get saveFailed => 'บันทึกล้มเหลว';

  @override
  String savedTo(String path) {
    return 'บันทึกที่: $path';
  }

  @override
  String get noOriginalPdfStored => 'ไม่มี PDF ต้นฉบับถูกจัดเก็บ';

  @override
  String get waitingForFolderPermission => 'กำลังรอสิทธิ์การเข้าถึงโฟลเดอร์...';

  @override
  String get emptyRecentFiles => 'เปิดไฟล์เพื่อเริ่มต้น';

  @override
  String get imagesTitle => 'รูปภาพ';

  @override
  String get noImagesYet => 'ยังไม่มีรูปภาพ';

  @override
  String get noImagesHint => 'แตะ + เพื่อเพิ่มตราประทับหรือลายเซ็นแรกของคุณ';

  @override
  String get done => 'เสร็จสิ้น';

  @override
  String get menuEdit => 'แก้ไข';

  @override
  String get chooseFromFiles => 'เลือกจากไฟล์';

  @override
  String get chooseFromGallery => 'เลือกจากแกลเลอรี';

  @override
  String get imageTooBig => 'รูปภาพใหญ่เกินไป (สูงสุด 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'ความละเอียดสูงเกินไป (สูงสุด 4096×4096)';

  @override
  String get unsupportedImageFormat => 'รูปแบบรูปภาพไม่รองรับ';

  @override
  String get deleteTooltip => 'ลบ';

  @override
  String get shareTooltip => 'แชร์';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'หน้า $currentPage จาก $totalPages';
  }

  @override
  String get noDocumentLoaded => 'ไม่มีเอกสารที่โหลด';

  @override
  String get failedToLoadPdf => 'โหลด PDF ล้มเหลว';

  @override
  String get passwordRequired => 'ต้องใช้รหัสผ่าน';

  @override
  String get pdfPasswordProtected => 'PDF นี้ถูกป้องกันด้วยรหัสผ่าน';

  @override
  String errorWithMessage(String message) {
    return 'ข้อผิดพลาด: $message';
  }

  @override
  String get unsavedChangesTitle => 'การเปลี่ยนแปลงที่ยังไม่ได้บันทึก';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'คุณต้องการบันทึกการเปลี่ยนแปลงใน \"$fileName\" หรือไม่?';
  }

  @override
  String get onboardingOpenPdf => 'แตะเพื่อเปิดเอกสาร PDF';

  @override
  String get onboardingSwipeUp => 'ปัดขึ้นเพื่อเพิ่มลายเซ็นและตราประทับ';

  @override
  String get onboardingAddImage => 'แตะเพื่อเพิ่มลายเซ็นหรือตราประทับแรกของคุณ';

  @override
  String get onboardingDragImage => 'ลากไปวางบน PDF';

  @override
  String get onboardingResizeObject => 'แตะเพื่อเลือก ลากมุมเพื่อปรับขนาด';

  @override
  String get onboardingDeleteImage => 'แตะเพื่อลบรูปภาพที่เลือก';

  @override
  String get onboardingTapToContinue => 'แตะที่ใดก็ได้เพื่อดำเนินการต่อ';

  @override
  String get imageConversionFailed => 'ไม่สามารถแปลงรูปภาพเป็น PDF ได้';

  @override
  String get saveDocumentTitle => 'บันทึกเอกสาร';

  @override
  String get fileNameLabel => 'ชื่อไฟล์';

  @override
  String get defaultFileName => 'เอกสาร';

  @override
  String get onlyOnePdfAllowed =>
      'สามารถเปิดไฟล์ PDF ได้ครั้งละหนึ่งไฟล์เท่านั้น';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'ไฟล์ PDF ถูกละเว้น แปลงเฉพาะรูปภาพเท่านั้น';

  @override
  String convertingImages(int count) {
    return 'กำลังแปลง $count รูปภาพ...';
  }
}
