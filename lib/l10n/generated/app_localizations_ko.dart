// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get openPdf => 'PDF 열기';

  @override
  String get selectPdf => 'PDF 선택';

  @override
  String get recentFiles => '최근 파일';

  @override
  String get removeFromList => '목록에서 제거';

  @override
  String get openedNow => '방금 열림';

  @override
  String openedMinutesAgo(int count) {
    return '$count분 전에 열림';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count시간 전에 열림';
  }

  @override
  String get openedYesterday => '어제 열림';

  @override
  String openedDaysAgo(int count) {
    return '$count일 전에 열림';
  }

  @override
  String get fileNotFound => '파일을 찾을 수 없음';

  @override
  String get fileAccessDenied => '접근이 거부됨';

  @override
  String get clearRecentFiles => '최근 파일 지우기';

  @override
  String get cancel => '취소';

  @override
  String get confirm => '확인';

  @override
  String get error => '오류';

  @override
  String get ok => '확인';

  @override
  String get menuFile => '파일';

  @override
  String get menuOpen => '열기...';

  @override
  String get menuOpenRecent => '최근 항목 열기';

  @override
  String get menuNoRecentFiles => '최근 파일 없음';

  @override
  String get menuClearMenu => '메뉴 지우기';

  @override
  String get menuSave => '저장';

  @override
  String get menuSaveAs => '다른 이름으로 저장...';

  @override
  String get menuSaveAll => '모두 저장';

  @override
  String get menuShare => '공유...';

  @override
  String get menuCloseWindow => '윈도우 닫기';

  @override
  String get menuCloseAll => '모두 닫기';

  @override
  String get menuQuit => 'PDFSign 종료';

  @override
  String get closeAllDialogTitle => '변경사항을 저장하시겠습니까?';

  @override
  String closeAllDialogMessage(int count) {
    return '닫기 전에 $count개 문서의 변경사항을 저장하시겠습니까?';
  }

  @override
  String get closeAllDialogMessageOne => '닫기 전에 1개 문서의 변경사항을 저장하시겠습니까?';

  @override
  String get closeAllDialogSaveAll => '모두 저장';

  @override
  String get closeAllDialogDontSave => '저장 안 함';

  @override
  String get closeAllDialogCancel => '취소';

  @override
  String get saveFailedDialogTitle => '저장 실패';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count개 문서를 저장하지 못했습니다. 그래도 닫으시겠습니까?';
  }

  @override
  String get saveFailedDialogClose => '그래도 닫기';

  @override
  String get saveChangesTitle => '변경사항을 저장하시겠습니까?';

  @override
  String saveChangesMessage(String fileName) {
    return '닫기 전에 \"$fileName\"의 변경사항을 저장하시겠습니까?';
  }

  @override
  String get saveButton => '저장';

  @override
  String get discardButton => '저장 안 함';

  @override
  String get documentEdited => '편집됨';

  @override
  String get documentSaved => '저장됨';

  @override
  String get menuSettings => '설정...';

  @override
  String get menuWindow => '윈도우';

  @override
  String get menuMinimize => '최소화';

  @override
  String get menuZoom => '확대/축소';

  @override
  String get menuBringAllToFront => '모두 앞으로 가져오기';

  @override
  String get settingsTitle => '설정';

  @override
  String get settingsLanguage => '언어';

  @override
  String get settingsLanguageSystem => '시스템 기본값';

  @override
  String get settingsUnits => '단위';

  @override
  String get settingsUnitsCentimeters => '센티미터';

  @override
  String get settingsUnitsInches => '인치';

  @override
  String get settingsSearchLanguages => '언어 검색...';

  @override
  String get settingsGeneral => '일반';

  @override
  String get addImage => '이미지 추가';

  @override
  String get selectImages => '이미지 선택';

  @override
  String get zoomFitWidth => '너비에 맞춤';

  @override
  String get zoomIn => '확대';

  @override
  String get zoomOut => '축소';

  @override
  String get selectZoomLevel => '확대/축소 수준 선택';

  @override
  String get goToPage => '페이지로 이동';

  @override
  String get go => '이동';

  @override
  String get savePdfAs => 'PDF 다른 이름으로 저장';

  @override
  String get incorrectPassword => '잘못된 비밀번호';

  @override
  String get saveFailed => '저장 실패';

  @override
  String savedTo(String path) {
    return '저장 위치: $path';
  }

  @override
  String get noOriginalPdfStored => '원본 PDF가 저장되지 않음';

  @override
  String get waitingForFolderPermission => '폴더 접근 권한을 기다리는 중...';

  @override
  String get emptyRecentFiles => '시작하려면 PDF를 여세요';

  @override
  String get imagesTitle => '이미지';

  @override
  String get noImagesYet => '이미지 없음';

  @override
  String get noImagesHint => '+ 를 탭하여 첫 번째 스탬프 또는 서명 추가';

  @override
  String get done => '완료';

  @override
  String get menuEdit => '편집';
}
