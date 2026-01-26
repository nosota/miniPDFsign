// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get openPdf => '打开 PDF';

  @override
  String get selectPdf => '选择 PDF';

  @override
  String get recentFiles => '最近文件';

  @override
  String get removeFromList => '从列表中移除';

  @override
  String get openedNow => '刚刚打开';

  @override
  String openedMinutesAgo(int count) {
    return '$count分钟前打开';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count小时前打开';
  }

  @override
  String get openedYesterday => '昨天打开';

  @override
  String openedDaysAgo(int count) {
    return '$count天前打开';
  }

  @override
  String get fileNotFound => '文件未找到';

  @override
  String get fileAccessDenied => '访问被拒绝';

  @override
  String get clearRecentFiles => '清除最近文件';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get error => '错误';

  @override
  String get ok => '好';

  @override
  String get menuFile => '文件';

  @override
  String get menuOpen => '打开...';

  @override
  String get menuOpenRecent => '打开最近';

  @override
  String get menuNoRecentFiles => '没有最近文件';

  @override
  String get menuClearMenu => '清除菜单';

  @override
  String get menuSave => '保存';

  @override
  String get menuSaveAs => '另存为...';

  @override
  String get menuSaveAll => '全部保存';

  @override
  String get menuShare => '共享...';

  @override
  String get menuCloseWindow => '关闭窗口';

  @override
  String get menuCloseAll => '全部关闭';

  @override
  String get menuQuit => '退出 PDFSign';

  @override
  String get closeAllDialogTitle => '保存更改？';

  @override
  String closeAllDialogMessage(int count) {
    return '关闭前是否要保存对 $count 个文档的更改？';
  }

  @override
  String get closeAllDialogMessageOne => '关闭前是否要保存对 1 个文档的更改？';

  @override
  String get closeAllDialogSaveAll => '全部保存';

  @override
  String get closeAllDialogDontSave => '不保存';

  @override
  String get closeAllDialogCancel => '取消';

  @override
  String get saveFailedDialogTitle => '保存失败';

  @override
  String saveFailedDialogMessage(int count) {
    return '无法保存 $count 个文档。仍然关闭？';
  }

  @override
  String get saveFailedDialogClose => '仍然关闭';

  @override
  String get saveChangesTitle => '保存更改？';

  @override
  String saveChangesMessage(String fileName) {
    return '关闭前是否要保存对「$fileName」的更改？';
  }

  @override
  String get saveButton => '保存';

  @override
  String get discardButton => '不保存';

  @override
  String get documentEdited => '已编辑';

  @override
  String get documentSaved => '已保存';

  @override
  String get menuSettings => '设置...';

  @override
  String get menuWindow => '窗口';

  @override
  String get menuMinimize => '最小化';

  @override
  String get menuZoom => '缩放';

  @override
  String get menuBringAllToFront => '前置全部窗口';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsLanguageSystem => '系统默认';

  @override
  String get settingsUnits => '单位';

  @override
  String get settingsUnitsCentimeters => '厘米';

  @override
  String get settingsUnitsInches => '英寸';

  @override
  String get settingsSearchLanguages => '搜索语言...';

  @override
  String get settingsGeneral => '通用';

  @override
  String get addImage => '添加图片';

  @override
  String get selectImages => '选择图片';

  @override
  String get zoomFitWidth => '适应宽度';

  @override
  String get zoomIn => '放大';

  @override
  String get zoomOut => '缩小';

  @override
  String get selectZoomLevel => '选择缩放级别';

  @override
  String get goToPage => '跳转到页面';

  @override
  String get go => '跳转';

  @override
  String get savePdfAs => 'PDF另存为';

  @override
  String get incorrectPassword => '密码错误';

  @override
  String get saveFailed => '保存失败';

  @override
  String savedTo(String path) {
    return '已保存至：$path';
  }

  @override
  String get noOriginalPdfStored => '未存储原始PDF';

  @override
  String get waitingForFolderPermission => '正在等待文件夹访问权限...';

  @override
  String get emptyRecentFiles => '打开 PDF 开始使用';

  @override
  String get imagesTitle => '图片';

  @override
  String get noImagesYet => '暂无图片';

  @override
  String get noImagesHint => '点击 + 添加您的第一个印章或签名';

  @override
  String get done => '完成';

  @override
  String get menuEdit => '编辑';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get openPdf => '打开 PDF';

  @override
  String get selectPdf => '选择 PDF';

  @override
  String get recentFiles => '最近文件';

  @override
  String get removeFromList => '从列表中移除';

  @override
  String get openedNow => '刚刚打开';

  @override
  String openedMinutesAgo(int count) {
    return '$count分钟前打开';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count小时前打开';
  }

  @override
  String get openedYesterday => '昨天打开';

  @override
  String openedDaysAgo(int count) {
    return '$count天前打开';
  }

  @override
  String get fileNotFound => '文件未找到';

  @override
  String get fileAccessDenied => '访问被拒绝';

  @override
  String get clearRecentFiles => '清除最近文件';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get error => '错误';

  @override
  String get ok => '好';

  @override
  String get menuFile => '文件';

  @override
  String get menuOpen => '打开...';

  @override
  String get menuOpenRecent => '打开最近';

  @override
  String get menuNoRecentFiles => '没有最近文件';

  @override
  String get menuClearMenu => '清除菜单';

  @override
  String get menuSave => '保存';

  @override
  String get menuSaveAs => '另存为...';

  @override
  String get menuSaveAll => '全部保存';

  @override
  String get menuShare => '共享...';

  @override
  String get menuCloseWindow => '关闭窗口';

  @override
  String get menuCloseAll => '全部关闭';

  @override
  String get menuQuit => '退出 PDFSign';

  @override
  String get closeAllDialogTitle => '保存更改？';

  @override
  String closeAllDialogMessage(int count) {
    return '关闭前是否要保存对 $count 个文档的更改？';
  }

  @override
  String get closeAllDialogMessageOne => '关闭前是否要保存对 1 个文档的更改？';

  @override
  String get closeAllDialogSaveAll => '全部保存';

  @override
  String get closeAllDialogDontSave => '不保存';

  @override
  String get closeAllDialogCancel => '取消';

  @override
  String get saveFailedDialogTitle => '保存失败';

  @override
  String saveFailedDialogMessage(int count) {
    return '无法保存 $count 个文档。仍然关闭？';
  }

  @override
  String get saveFailedDialogClose => '仍然关闭';

  @override
  String get saveChangesTitle => '保存更改？';

  @override
  String saveChangesMessage(String fileName) {
    return '关闭前是否要保存对「$fileName」的更改？';
  }

  @override
  String get saveButton => '保存';

  @override
  String get discardButton => '不保存';

  @override
  String get documentEdited => '已编辑';

  @override
  String get documentSaved => '已保存';

  @override
  String get menuSettings => '设置...';

  @override
  String get menuWindow => '窗口';

  @override
  String get menuMinimize => '最小化';

  @override
  String get menuZoom => '缩放';

  @override
  String get menuBringAllToFront => '前置全部窗口';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsLanguageSystem => '系统默认';

  @override
  String get settingsUnits => '单位';

  @override
  String get settingsUnitsCentimeters => '厘米';

  @override
  String get settingsUnitsInches => '英寸';

  @override
  String get settingsSearchLanguages => '搜索语言...';

  @override
  String get settingsGeneral => '通用';

  @override
  String get addImage => '添加图片';

  @override
  String get selectImages => '选择图片';

  @override
  String get zoomFitWidth => '适应宽度';

  @override
  String get zoomIn => '放大';

  @override
  String get zoomOut => '缩小';

  @override
  String get selectZoomLevel => '选择缩放级别';

  @override
  String get goToPage => '跳转到页面';

  @override
  String get go => '跳转';

  @override
  String get savePdfAs => 'PDF另存为';

  @override
  String get incorrectPassword => '密码错误';

  @override
  String get saveFailed => '保存失败';

  @override
  String savedTo(String path) {
    return '已保存至：$path';
  }

  @override
  String get noOriginalPdfStored => '未存储原始PDF';

  @override
  String get waitingForFolderPermission => '正在等待文件夹访问权限...';

  @override
  String get emptyRecentFiles => '打开 PDF 开始使用';

  @override
  String get imagesTitle => '图片';

  @override
  String get noImagesYet => '暂无图片';

  @override
  String get noImagesHint => '点击 + 添加您的第一个印章或签名';

  @override
  String get done => '完成';

  @override
  String get menuEdit => '编辑';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get openPdf => '開啟 PDF';

  @override
  String get selectPdf => '選擇 PDF';

  @override
  String get recentFiles => '最近檔案';

  @override
  String get removeFromList => '從列表中移除';

  @override
  String get openedNow => '剛剛開啟';

  @override
  String openedMinutesAgo(int count) {
    return '$count分鐘前開啟';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count小時前開啟';
  }

  @override
  String get openedYesterday => '昨天開啟';

  @override
  String openedDaysAgo(int count) {
    return '$count天前開啟';
  }

  @override
  String get fileNotFound => '找不到檔案';

  @override
  String get fileAccessDenied => '存取遭拒';

  @override
  String get clearRecentFiles => '清除最近檔案';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '確認';

  @override
  String get error => '錯誤';

  @override
  String get ok => '好';

  @override
  String get menuFile => '檔案';

  @override
  String get menuOpen => '開啟...';

  @override
  String get menuOpenRecent => '開啟最近項目';

  @override
  String get menuNoRecentFiles => '沒有最近檔案';

  @override
  String get menuClearMenu => '清除選單';

  @override
  String get menuSave => '儲存';

  @override
  String get menuSaveAs => '另存新檔...';

  @override
  String get menuSaveAll => '全部保存';

  @override
  String get menuShare => '分享...';

  @override
  String get menuCloseWindow => '關閉視窗';

  @override
  String get menuCloseAll => '全部關閉';

  @override
  String get menuQuit => '結束 PDFSign';

  @override
  String get closeAllDialogTitle => '儲存更動？';

  @override
  String closeAllDialogMessage(int count) {
    return '關閉前是否要儲存對 $count 個文件的更動？';
  }

  @override
  String get closeAllDialogMessageOne => '關閉前是否要儲存對 1 個文件的更動？';

  @override
  String get closeAllDialogSaveAll => '全部儲存';

  @override
  String get closeAllDialogDontSave => '不儲存';

  @override
  String get closeAllDialogCancel => '取消';

  @override
  String get saveFailedDialogTitle => '儲存失敗';

  @override
  String saveFailedDialogMessage(int count) {
    return '無法儲存 $count 個文件。仍然關閉？';
  }

  @override
  String get saveFailedDialogClose => '仍然關閉';

  @override
  String get saveChangesTitle => '儲存更動？';

  @override
  String saveChangesMessage(String fileName) {
    return '關閉前是否要儲存對「$fileName」的更動？';
  }

  @override
  String get saveButton => '儲存';

  @override
  String get discardButton => '不儲存';

  @override
  String get documentEdited => '已編輯';

  @override
  String get documentSaved => '已儲存';

  @override
  String get menuSettings => '設定...';

  @override
  String get menuWindow => '視窗';

  @override
  String get menuMinimize => '縮小';

  @override
  String get menuZoom => '縮放';

  @override
  String get menuBringAllToFront => '將所有視窗移至最前';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsLanguage => '語言';

  @override
  String get settingsLanguageSystem => '系統預設';

  @override
  String get settingsUnits => '單位';

  @override
  String get settingsUnitsCentimeters => '公分';

  @override
  String get settingsUnitsInches => '英吋';

  @override
  String get settingsSearchLanguages => '搜尋語言...';

  @override
  String get settingsGeneral => '一般';

  @override
  String get addImage => '新增圖片';

  @override
  String get selectImages => '選擇圖片';

  @override
  String get zoomFitWidth => '符合寬度';

  @override
  String get zoomIn => '放大';

  @override
  String get zoomOut => '縮小';

  @override
  String get selectZoomLevel => '選擇縮放級別';

  @override
  String get goToPage => '前往頁面';

  @override
  String get go => '前往';

  @override
  String get savePdfAs => 'PDF另存新檔';

  @override
  String get incorrectPassword => '密碼錯誤';

  @override
  String get saveFailed => '儲存失敗';

  @override
  String savedTo(String path) {
    return '已儲存至：$path';
  }

  @override
  String get noOriginalPdfStored => '未儲存原始PDF';

  @override
  String get waitingForFolderPermission => '正在等待資料夾存取權限...';

  @override
  String get emptyRecentFiles => '開啟 PDF 以開始使用';

  @override
  String get imagesTitle => '圖片';

  @override
  String get noImagesYet => '尚無圖片';

  @override
  String get noImagesHint => '點擊 + 新增您的第一個印章或簽名';

  @override
  String get done => '完成';

  @override
  String get menuEdit => '編輯';
}
