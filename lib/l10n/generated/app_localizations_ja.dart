// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get openPdf => 'PDFを開く';

  @override
  String get selectPdf => 'ファイルを開く';

  @override
  String get untitledDocument => '名称未設定.pdf';

  @override
  String get recentFiles => '最近使ったファイル';

  @override
  String get removeFromList => 'リストから削除';

  @override
  String get openedNow => '今開いた';

  @override
  String openedMinutesAgo(int count) {
    return '$count分前に開いた';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count時間前に開いた';
  }

  @override
  String get openedYesterday => '昨日開いた';

  @override
  String openedDaysAgo(int count) {
    return '$count日前に開いた';
  }

  @override
  String get fileNotFound => 'ファイルが見つかりません';

  @override
  String get fileAccessDenied => 'アクセスが拒否されました';

  @override
  String get clearRecentFiles => '最近使ったファイルを消去';

  @override
  String get cancel => 'キャンセル';

  @override
  String get confirm => '確認';

  @override
  String get error => 'エラー';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'ファイル';

  @override
  String get menuOpen => '開く...';

  @override
  String get menuOpenRecent => '最近使った項目を開く';

  @override
  String get menuNoRecentFiles => '最近使ったファイルはありません';

  @override
  String get menuClearMenu => 'メニューを消去';

  @override
  String get menuSave => '保存';

  @override
  String get menuSaveAs => '別名で保存...';

  @override
  String get menuSaveAll => 'すべて保存';

  @override
  String get menuShare => '共有...';

  @override
  String get menuCloseWindow => 'ウインドウを閉じる';

  @override
  String get menuCloseAll => 'すべて閉じる';

  @override
  String get menuQuit => 'PDFSignを終了';

  @override
  String get closeAllDialogTitle => '変更を保存しますか？';

  @override
  String closeAllDialogMessage(int count) {
    return '閉じる前に$count個のドキュメントの変更を保存しますか？';
  }

  @override
  String get closeAllDialogMessageOne => '閉じる前に1個のドキュメントの変更を保存しますか？';

  @override
  String get closeAllDialogSaveAll => 'すべて保存';

  @override
  String get closeAllDialogDontSave => '保存しない';

  @override
  String get closeAllDialogCancel => 'キャンセル';

  @override
  String get saveFailedDialogTitle => '保存に失敗しました';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count件のドキュメントの保存に失敗しました。それでも閉じますか？';
  }

  @override
  String get saveFailedDialogClose => 'それでも閉じる';

  @override
  String get saveChangesTitle => '変更を保存しますか？';

  @override
  String saveChangesMessage(String fileName) {
    return '閉じる前に\"$fileName\"への変更を保存しますか？';
  }

  @override
  String get saveButton => '保存';

  @override
  String get discardButton => '保存しない';

  @override
  String get documentEdited => '編集済み';

  @override
  String get documentSaved => '保存済み';

  @override
  String get menuSettings => '設定...';

  @override
  String get menuWindow => 'ウインドウ';

  @override
  String get menuMinimize => 'しまう';

  @override
  String get menuZoom => '拡大/縮小';

  @override
  String get menuBringAllToFront => 'すべてを手前に移動';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsLanguage => '言語';

  @override
  String get settingsLanguageSystem => 'システムデフォルト';

  @override
  String get settingsUnits => '単位';

  @override
  String get settingsUnitsCentimeters => 'センチメートル';

  @override
  String get settingsUnitsInches => 'インチ';

  @override
  String get settingsUnitsDefault => 'デフォルト（地域別）';

  @override
  String get settingsSearchLanguages => '言語を検索...';

  @override
  String get settingsGeneral => '一般';

  @override
  String get addImage => '画像を追加';

  @override
  String get selectImages => '画像を選択';

  @override
  String get zoomFitWidth => '幅に合わせる';

  @override
  String get zoomIn => '拡大';

  @override
  String get zoomOut => '縮小';

  @override
  String get selectZoomLevel => 'ズームレベルを選択';

  @override
  String get goToPage => 'ページに移動';

  @override
  String get go => '移動';

  @override
  String get savePdfAs => 'PDFを別名で保存';

  @override
  String get incorrectPassword => 'パスワードが正しくありません';

  @override
  String get saveFailed => '保存に失敗しました';

  @override
  String savedTo(String path) {
    return '保存先: $path';
  }

  @override
  String get noOriginalPdfStored => '元のPDFが保存されていません';

  @override
  String get waitingForFolderPermission => 'フォルダアクセス許可を待っています...';

  @override
  String get emptyRecentFiles => 'ファイルを開いて始めましょう';

  @override
  String get imagesTitle => '画像';

  @override
  String get noImagesYet => '画像がありません';

  @override
  String get noImagesHint => '+ をタップして最初のスタンプまたは署名を追加';

  @override
  String get done => '完了';

  @override
  String get menuEdit => '編集';

  @override
  String get chooseFromFiles => 'ファイルから選択';

  @override
  String get chooseFromGallery => 'ギャラリーから選択';

  @override
  String get imageTooBig => '画像が大きすぎます（最大50 MB）';

  @override
  String get imageResolutionTooHigh => '解像度が高すぎます（最大4096×4096）';

  @override
  String get unsupportedImageFormat => 'サポートされていない画像形式';

  @override
  String get deleteTooltip => '削除';

  @override
  String get shareTooltip => '共有';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'ページ $currentPage / $totalPages';
  }

  @override
  String get noDocumentLoaded => 'ドキュメントが読み込まれていません';

  @override
  String get failedToLoadPdf => 'PDFの読み込みに失敗しました';

  @override
  String get passwordRequired => 'パスワードが必要です';

  @override
  String get pdfPasswordProtected => 'このPDFはパスワードで保護されています。';

  @override
  String errorWithMessage(String message) {
    return 'エラー: $message';
  }

  @override
  String get unsavedChangesTitle => '未保存の変更';

  @override
  String unsavedChangesMessage(String fileName) {
    return '「$fileName」への変更を保存しますか？';
  }

  @override
  String get onboardingOpenPdf => 'タップしてPDFドキュメントを開く';

  @override
  String get onboardingSwipeUp => '上にスワイプして署名やスタンプを追加';

  @override
  String get onboardingAddImage => 'タップして最初の署名またはスタンプを追加';

  @override
  String get onboardingDragImage => 'PDFにドラッグして配置';

  @override
  String get onboardingResizeObject => 'タップして選択。角をドラッグしてサイズ変更。';

  @override
  String get onboardingDeleteImage => 'タップして選択した画像を削除';

  @override
  String get onboardingTapToContinue => 'どこかをタップして続行';

  @override
  String get imageConversionFailed => '画像をPDFに変換できませんでした';

  @override
  String get saveDocumentTitle => 'ドキュメントを保存';

  @override
  String get fileNameLabel => 'ファイル名';

  @override
  String get defaultFileName => 'ドキュメント';

  @override
  String get onlyOnePdfAllowed => '一度に開けるPDFは1つだけです';

  @override
  String get pdfsIgnoredInMixedSelection => 'PDFファイルは無視されました。画像のみ変換します。';

  @override
  String convertingImages(int count) {
    return '$count枚の画像を変換中...';
  }

  @override
  String get takePhoto => '写真を撮る';

  @override
  String get removeBackgroundTitle => '背景を削除しますか？';

  @override
  String get removeBackgroundMessage => '背景を削除して透明にしますか？';

  @override
  String get removeBackground => '削除';

  @override
  String get keepOriginal => '保持';

  @override
  String get processingImage => '画像を処理中...';

  @override
  String get backgroundRemovalFailed => '背景の削除に失敗しました';

  @override
  String get passwordLabel => 'パスワード';

  @override
  String get unlockButton => 'ロック解除';

  @override
  String get pasteFromClipboard => 'クリップボードから貼り付け';

  @override
  String get noImageInClipboard => 'クリップボードに画像がありません。先に画像をコピーしてください。';

  @override
  String get imageDuplicated => '画像を複製しました';
}
