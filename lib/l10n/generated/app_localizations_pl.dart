// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get openPdf => 'Otwórz PDF';

  @override
  String get selectPdf => 'Otwórz plik';

  @override
  String get untitledDocument => 'Bez tytułu.pdf';

  @override
  String get recentFiles => 'Ostatnie pliki';

  @override
  String get removeFromList => 'Usuń z listy';

  @override
  String get openedNow => 'Właśnie otwarty';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minut',
      many: 'minut',
      few: 'minuty',
      one: 'minutę',
    );
    return 'Otwarty $count $_temp0 temu';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'godzin',
      many: 'godzin',
      few: 'godziny',
      one: 'godzinę',
    );
    return 'Otwarty $count $_temp0 temu';
  }

  @override
  String get openedYesterday => 'Otwarty wczoraj';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dni',
      many: 'dni',
      few: 'dni',
      one: 'dzień',
    );
    return 'Otwarty $count $_temp0 temu';
  }

  @override
  String get fileNotFound => 'Plik nie znaleziony';

  @override
  String get fileAccessDenied => 'Odmowa dostępu';

  @override
  String get clearRecentFiles => 'Wyczyść ostatnie pliki';

  @override
  String get cancel => 'Anuluj';

  @override
  String get confirm => 'Potwierdź';

  @override
  String get error => 'Błąd';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Plik';

  @override
  String get menuOpen => 'Otwórz...';

  @override
  String get menuOpenRecent => 'Otwórz ostatnie';

  @override
  String get menuNoRecentFiles => 'Brak ostatnich plików';

  @override
  String get menuClearMenu => 'Wyczyść menu';

  @override
  String get menuSave => 'Zapisz';

  @override
  String get menuSaveAs => 'Zapisz jako...';

  @override
  String get menuSaveAll => 'Zapisz wszystko';

  @override
  String get menuShare => 'Udostępnij...';

  @override
  String get menuCloseWindow => 'Zamknij okno';

  @override
  String get menuCloseAll => 'Zamknij wszystkie';

  @override
  String get menuQuit => 'Zakończ PDFSign';

  @override
  String get closeAllDialogTitle => 'Zapisać zmiany?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Czy chcesz zapisać zmiany w $count dokumentach przed zamknięciem?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Czy chcesz zapisać zmiany w 1 dokumencie przed zamknięciem?';

  @override
  String get closeAllDialogSaveAll => 'Zapisz wszystkie';

  @override
  String get closeAllDialogDontSave => 'Nie zapisuj';

  @override
  String get closeAllDialogCancel => 'Anuluj';

  @override
  String get saveFailedDialogTitle => 'Zapisywanie nie powiodło się';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Nie udało się zapisać $count dokumentu(ów). Zamknąć mimo to?';
  }

  @override
  String get saveFailedDialogClose => 'Zamknij mimo to';

  @override
  String get saveChangesTitle => 'Zapisać zmiany?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Czy chcesz zapisać zmiany w \"$fileName\" przed zamknięciem?';
  }

  @override
  String get saveButton => 'Zapisz';

  @override
  String get discardButton => 'Nie zapisuj';

  @override
  String get documentEdited => 'Edytowany';

  @override
  String get documentSaved => 'Zapisany';

  @override
  String get menuSettings => 'Ustawienia...';

  @override
  String get menuWindow => 'Okno';

  @override
  String get menuMinimize => 'Minimalizuj';

  @override
  String get menuZoom => 'Powiększ';

  @override
  String get menuBringAllToFront => 'Przenieś wszystkie na wierzch';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get settingsLanguage => 'Język';

  @override
  String get settingsLanguageSystem => 'Domyślny systemowy';

  @override
  String get settingsUnits => 'Jednostki';

  @override
  String get settingsUnitsCentimeters => 'Centymetry';

  @override
  String get settingsUnitsInches => 'Cale';

  @override
  String get settingsSearchLanguages => 'Szukaj języków...';

  @override
  String get settingsGeneral => 'Ogólne';

  @override
  String get addImage => 'Dodaj obraz';

  @override
  String get selectImages => 'Wybierz obrazy';

  @override
  String get zoomFitWidth => 'Dopasuj do szerokości';

  @override
  String get zoomIn => 'Powiększ';

  @override
  String get zoomOut => 'Pomniejsz';

  @override
  String get selectZoomLevel => 'Wybierz poziom powiększenia';

  @override
  String get goToPage => 'Przejdź do strony';

  @override
  String get go => 'Przejdź';

  @override
  String get savePdfAs => 'Zapisz PDF jako';

  @override
  String get incorrectPassword => 'Nieprawidłowe hasło';

  @override
  String get saveFailed => 'Zapisywanie nie powiodło się';

  @override
  String savedTo(String path) {
    return 'Zapisano w: $path';
  }

  @override
  String get noOriginalPdfStored => 'Brak oryginalnego PDF';

  @override
  String get waitingForFolderPermission =>
      'Oczekiwanie na uprawnienia dostępu do folderu...';

  @override
  String get emptyRecentFiles => 'Otwórz plik, aby rozpocząć';

  @override
  String get imagesTitle => 'Obrazy';

  @override
  String get noImagesYet => 'Brak obrazów';

  @override
  String get noImagesHint =>
      'Dotknij +, aby dodać pierwszą pieczątkę lub podpis';

  @override
  String get done => 'Gotowe';

  @override
  String get menuEdit => 'Edytuj';

  @override
  String get chooseFromFiles => 'Wybierz z plików';

  @override
  String get chooseFromGallery => 'Wybierz z galerii';

  @override
  String get imageTooBig => 'Obraz jest za duży (maks. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Rozdzielczość jest za wysoka (maks. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Nieobsługiwany format obrazu';

  @override
  String get deleteTooltip => 'Usuń';

  @override
  String get shareTooltip => 'Udostępnij';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Strona $currentPage z $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Nie załadowano dokumentu';

  @override
  String get failedToLoadPdf => 'Nie udało się załadować pliku PDF';

  @override
  String get passwordRequired => 'Wymagane hasło';

  @override
  String get pdfPasswordProtected => 'Ten plik PDF jest chroniony hasłem.';

  @override
  String errorWithMessage(String message) {
    return 'Błąd: $message';
  }

  @override
  String get unsavedChangesTitle => 'Niezapisane zmiany';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Czy chcesz zapisać zmiany w \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Dotknij, aby otworzyć dokument PDF';

  @override
  String get onboardingSwipeUp =>
      'Przesuń w górę, aby dodać podpisy i pieczątki';

  @override
  String get onboardingAddImage =>
      'Dotknij, aby dodać pierwszy podpis lub pieczątkę';

  @override
  String get onboardingDragImage => 'Przeciągnij na PDF, aby umieścić';

  @override
  String get onboardingResizeObject =>
      'Dotknij, aby wybrać. Przeciągnij rogi, aby zmienić rozmiar.';

  @override
  String get onboardingDeleteImage => 'Stuknij, aby usunąć wybrany obraz';

  @override
  String get onboardingTapToContinue =>
      'Dotknij w dowolnym miejscu, aby kontynuować';

  @override
  String get imageConversionFailed =>
      'Nie udało się przekonwertować obrazu na PDF';

  @override
  String get saveDocumentTitle => 'Zapisz dokument';

  @override
  String get fileNameLabel => 'Nazwa pliku';

  @override
  String get defaultFileName => 'Dokument';
}
