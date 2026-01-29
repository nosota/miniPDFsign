// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class AppLocalizationsLv extends AppLocalizations {
  AppLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get openPdf => 'Avert PDF';

  @override
  String get selectPdf => 'Izvelieties PDF';

  @override
  String get recentFiles => 'Nesenie faili';

  @override
  String get removeFromList => 'Nonemt no saraksta';

  @override
  String get openedNow => 'Tikko atverts';

  @override
  String openedMinutesAgo(int count) {
    return 'Atverts pirms $count minutem';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Atverts pirms $count stundam';
  }

  @override
  String get openedYesterday => 'Atverts vakar';

  @override
  String openedDaysAgo(int count) {
    return 'Atverts pirms $count dienam';
  }

  @override
  String get fileNotFound => 'Fails nav atrasts';

  @override
  String get fileAccessDenied => 'Pieklave liegta';

  @override
  String get clearRecentFiles => 'Notiret nesenos failus';

  @override
  String get cancel => 'Atcelt';

  @override
  String get confirm => 'Apstiprinat';

  @override
  String get error => 'Kluda';

  @override
  String get ok => 'Labi';

  @override
  String get menuFile => 'Fails';

  @override
  String get menuOpen => 'Avert...';

  @override
  String get menuOpenRecent => 'Avert nesenos';

  @override
  String get menuNoRecentFiles => 'Nav neseno failu';

  @override
  String get menuClearMenu => 'Notiret izvēlni';

  @override
  String get menuSave => 'Saglabat';

  @override
  String get menuSaveAs => 'Saglabat ka...';

  @override
  String get menuSaveAll => 'Saglabāt visu';

  @override
  String get menuShare => 'Dalieties...';

  @override
  String get menuCloseWindow => 'Aizvert logu';

  @override
  String get menuCloseAll => 'Aizvērt visu';

  @override
  String get menuQuit => 'Iziet no PDFSign';

  @override
  String get closeAllDialogTitle => 'Saglabāt izmaiņas?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Vai vēlaties saglabāt izmaiņas $count dokumentos pirms aizvēršanas?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Vai vēlaties saglabāt izmaiņas 1 dokumentā pirms aizvēršanas?';

  @override
  String get closeAllDialogSaveAll => 'Saglabāt visu';

  @override
  String get closeAllDialogDontSave => 'Nesaglabāt';

  @override
  String get closeAllDialogCancel => 'Atcelt';

  @override
  String get saveFailedDialogTitle => 'Saglabāšana neizdevās';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Neizdevās saglabāt $count dokumentu(s). Aizvērt tik un tā?';
  }

  @override
  String get saveFailedDialogClose => 'Aizvērt tik un tā';

  @override
  String get saveChangesTitle => 'Saglabat izmainas?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Vai velaties saglabat izmainas faila \"$fileName\" pirms aizvershanas?';
  }

  @override
  String get saveButton => 'Saglabat';

  @override
  String get discardButton => 'Nesaglabat';

  @override
  String get documentEdited => 'Redigets';

  @override
  String get documentSaved => 'Saglabats';

  @override
  String get menuSettings => 'Iestatijumi...';

  @override
  String get menuWindow => 'Logs';

  @override
  String get menuMinimize => 'Minimizēt';

  @override
  String get menuZoom => 'Tālummaiņa';

  @override
  String get menuBringAllToFront => 'Pārvietot visu priekšplānā';

  @override
  String get settingsTitle => 'Iestatijumi';

  @override
  String get settingsLanguage => 'Valoda';

  @override
  String get settingsLanguageSystem => 'Sistemas noklusejums';

  @override
  String get settingsUnits => 'Mervienibas';

  @override
  String get settingsUnitsCentimeters => 'Centimetri';

  @override
  String get settingsUnitsInches => 'Collas';

  @override
  String get settingsSearchLanguages => 'Meklēt valodas...';

  @override
  String get settingsGeneral => 'Vispārīgi';

  @override
  String get addImage => 'Pievienot attēlu';

  @override
  String get selectImages => 'Izvēlieties attēlus';

  @override
  String get zoomFitWidth => 'Pielāgot platumam';

  @override
  String get zoomIn => 'Pietuvināt';

  @override
  String get zoomOut => 'Attālināt';

  @override
  String get selectZoomLevel => 'Izvēlieties tālummaiņas līmeni';

  @override
  String get goToPage => 'Doties uz lapu';

  @override
  String get go => 'Doties';

  @override
  String get savePdfAs => 'Saglabāt PDF kā';

  @override
  String get incorrectPassword => 'Nepareiza parole';

  @override
  String get saveFailed => 'Saglabāšana neizdevās';

  @override
  String savedTo(String path) {
    return 'Saglabāts: $path';
  }

  @override
  String get noOriginalPdfStored => 'Nav saglabāts oriģinālais PDF';

  @override
  String get waitingForFolderPermission => 'Gaida mapes piekļuves atļauju...';

  @override
  String get emptyRecentFiles => 'Atveriet PDF, lai sāktu';

  @override
  String get imagesTitle => 'Attēli';

  @override
  String get noImagesYet => 'Vēl nav attēlu';

  @override
  String get noImagesHint =>
      'Pieskarieties +, lai pievienotu pirmo zīmogu vai parakstu';

  @override
  String get done => 'Gatavs';

  @override
  String get menuEdit => 'Rediģēt';

  @override
  String get chooseFromFiles => 'Izvēlēties no failiem';

  @override
  String get chooseFromGallery => 'Izvēlēties no galerijas';

  @override
  String get imageTooBig => 'Attēls ir pārāk liels (maks. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Izšķirtspēja ir pārāk augsta (maks. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Neatbalstīts attēla formāts';

  @override
  String get deleteTooltip => 'Dzēst';

  @override
  String get shareTooltip => 'Dalīties';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Lapa $currentPage no $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Nav ielādēts dokuments';

  @override
  String get failedToLoadPdf => 'Neizdevās ielādēt PDF';

  @override
  String get passwordRequired => 'Nepieciešama parole';

  @override
  String get pdfPasswordProtected => 'Šis PDF ir aizsargāts ar paroli.';

  @override
  String errorWithMessage(String message) {
    return 'Kļūda: $message';
  }

  @override
  String get unsavedChangesTitle => 'Nesaglabātas izmaiņas';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Vai vēlaties saglabāt izmaiņas failā \"$fileName\"?';
  }
}
