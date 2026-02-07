// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get openPdf => 'Anoigma PDF';

  @override
  String get selectPdf => 'Άνοιγμα αρχείου';

  @override
  String get untitledDocument => 'Χωρίς τίτλο.pdf';

  @override
  String get recentFiles => 'Prosfata archeia';

  @override
  String get removeFromList => 'Afairesi apo ti lista';

  @override
  String get openedNow => 'Molis anoixe';

  @override
  String openedMinutesAgo(int count) {
    return 'Anoixe prin apo $count lepta';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Anoixe prin apo $count ores';
  }

  @override
  String get openedYesterday => 'Anoixe chthes';

  @override
  String openedDaysAgo(int count) {
    return 'Anoixe prin apo $count imeres';
  }

  @override
  String get fileNotFound => 'To archeio den vrethike';

  @override
  String get fileAccessDenied => 'Den epitrepetai i prosvasi';

  @override
  String get clearRecentFiles => 'Ekkatharisi prosfaton archeion';

  @override
  String get cancel => 'Akyrosi';

  @override
  String get confirm => 'Epivevaiosi';

  @override
  String get error => 'Sfalma';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Archeio';

  @override
  String get menuOpen => 'Anoigma...';

  @override
  String get menuOpenRecent => 'Anoigma prosfaton';

  @override
  String get menuNoRecentFiles => 'Den yparxoun prosfata archeia';

  @override
  String get menuClearMenu => 'Ekkatharisi menou';

  @override
  String get menuSave => 'Apothikefsi';

  @override
  String get menuSaveAs => 'Apothikefsi os...';

  @override
  String get menuSaveAll => 'Αποθήκευση όλων';

  @override
  String get menuShare => 'Koinopoiisi...';

  @override
  String get menuCloseWindow => 'Kleisimo parathyrou';

  @override
  String get menuCloseAll => 'Κλείσιμο όλων';

  @override
  String get menuQuit => 'Τερματισμός PDFSign';

  @override
  String get closeAllDialogTitle => 'Αποθήκευση αλλαγών;';

  @override
  String closeAllDialogMessage(int count) {
    return 'Θέλετε να αποθηκεύσετε τις αλλαγές σε $count έγγραφα πριν το κλείσιμο;';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Θέλετε να αποθηκεύσετε τις αλλαγές σε 1 έγγραφο πριν το κλείσιμο;';

  @override
  String get closeAllDialogSaveAll => 'Αποθήκευση όλων';

  @override
  String get closeAllDialogDontSave => 'Να μην αποθηκευτεί';

  @override
  String get closeAllDialogCancel => 'Ακύρωση';

  @override
  String get saveFailedDialogTitle => 'Αποτυχία αποθήκευσης';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Αποτυχία αποθήκευσης $count εγγράφου(ων). Κλείσιμο ούτως ή άλλως;';
  }

  @override
  String get saveFailedDialogClose => 'Κλείσιμο ούτως ή άλλως';

  @override
  String get saveChangesTitle => 'Apothikefsi allagon?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Thelete na apothikefthoun oi allages sto \"$fileName\" prin to kleisimo?';
  }

  @override
  String get saveButton => 'Apothikefsi';

  @override
  String get discardButton => 'Aporripsi';

  @override
  String get documentEdited => 'Epexergasmeno';

  @override
  String get documentSaved => 'Apothikeftike';

  @override
  String get menuSettings => 'Rythmiseis...';

  @override
  String get menuWindow => 'Παράθυρο';

  @override
  String get menuMinimize => 'Ελαχιστοποίηση';

  @override
  String get menuZoom => 'Ζουμ';

  @override
  String get menuBringAllToFront => 'Όλα στο προσκήνιο';

  @override
  String get settingsTitle => 'Rythmiseis';

  @override
  String get settingsLanguage => 'Glossa';

  @override
  String get settingsLanguageSystem => 'Proepilogi systimatos';

  @override
  String get settingsUnits => 'Monades';

  @override
  String get settingsUnitsCentimeters => 'Ekatosta';

  @override
  String get settingsUnitsInches => 'Intses';

  @override
  String get settingsUnitsDefault => 'Προεπιλογή (ανά περιοχή)';

  @override
  String get settingsSearchLanguages => 'Αναζήτηση γλωσσών...';

  @override
  String get settingsGeneral => 'Γενικά';

  @override
  String get addImage => 'Προσθήκη εικόνας';

  @override
  String get selectImages => 'Επιλογή εικόνων';

  @override
  String get zoomFitWidth => 'Προσαρμογή πλάτους';

  @override
  String get zoomIn => 'Μεγέθυνση';

  @override
  String get zoomOut => 'Σμίκρυνση';

  @override
  String get selectZoomLevel => 'Επιλογή επιπέδου ζουμ';

  @override
  String get goToPage => 'Μετάβαση σε σελίδα';

  @override
  String get go => 'Μετάβαση';

  @override
  String get savePdfAs => 'Αποθήκευση PDF ως';

  @override
  String get incorrectPassword => 'Λάθος κωδικός';

  @override
  String get saveFailed => 'Αποτυχία αποθήκευσης';

  @override
  String savedTo(String path) {
    return 'Αποθηκεύτηκε σε: $path';
  }

  @override
  String get noOriginalPdfStored => 'Δεν αποθηκεύτηκε αρχικό PDF';

  @override
  String get waitingForFolderPermission =>
      'Αναμονή για άδεια πρόσβασης φακέλου...';

  @override
  String get emptyRecentFiles => 'Ανοίξτε ένα αρχείο για να ξεκινήσετε';

  @override
  String get imagesTitle => 'Εικόνες';

  @override
  String get noImagesYet => 'Δεν υπάρχουν εικόνες ακόμα';

  @override
  String get noImagesHint =>
      'Πατήστε + για να προσθέσετε την πρώτη σας σφραγίδα ή υπογραφή';

  @override
  String get done => 'Τέλος';

  @override
  String get menuEdit => 'Επεξεργασία';

  @override
  String get chooseFromFiles => 'Επιλογή από αρχεία';

  @override
  String get chooseFromGallery => 'Επιλογή από συλλογή';

  @override
  String get imageTooBig => 'Η εικόνα είναι πολύ μεγάλη (μέγ. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'Η ανάλυση είναι πολύ υψηλή (μέγ. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Μη υποστηριζόμενη μορφή εικόνας';

  @override
  String get deleteTooltip => 'Διαγραφή';

  @override
  String get shareTooltip => 'Κοινοποίηση';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Σελίδα $currentPage από $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Δεν έχει φορτωθεί έγγραφο';

  @override
  String get failedToLoadPdf => 'Αποτυχία φόρτωσης PDF';

  @override
  String get passwordRequired => 'Απαιτείται κωδικός πρόσβασης';

  @override
  String get pdfPasswordProtected =>
      'Αυτό το PDF προστατεύεται με κωδικό πρόσβασης.';

  @override
  String errorWithMessage(String message) {
    return 'Σφάλμα: $message';
  }

  @override
  String get unsavedChangesTitle => 'Μη αποθηκευμένες αλλαγές';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Θέλετε να αποθηκεύσετε τις αλλαγές στο \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Πατήστε για να ανοίξετε ένα έγγραφο PDF';

  @override
  String get onboardingSwipeUp =>
      'Σύρετε προς τα πάνω για να προσθέσετε υπογραφές και σφραγίδες';

  @override
  String get onboardingAddImage =>
      'Πατήστε για να προσθέσετε την πρώτη σας υπογραφή ή σφραγίδα';

  @override
  String get onboardingDragImage => 'Σύρετε στο PDF για να το τοποθετήσετε';

  @override
  String get onboardingResizeObject =>
      'Πατήστε για επιλογή. Σύρετε τις γωνίες για αλλαγή μεγέθους.';

  @override
  String get onboardingDeleteImage =>
      'Πατήστε για να διαγράψετε την επιλεγμένη εικόνα';

  @override
  String get onboardingTapToContinue => 'Πατήστε οπουδήποτε για να συνεχίσετε';

  @override
  String get imageConversionFailed => 'Αποτυχία μετατροπής εικόνας σε PDF';

  @override
  String get saveDocumentTitle => 'Αποθήκευση εγγράφου';

  @override
  String get fileNameLabel => 'Όνομα αρχείου';

  @override
  String get defaultFileName => 'Έγγραφο';

  @override
  String get onlyOnePdfAllowed => 'Μπορεί να ανοίξει μόνο ένα PDF τη φορά';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'Τα αρχεία PDF αγνοήθηκαν. Μετατρέπονται μόνο οι εικόνες.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'εικόνων',
      one: 'εικόνας',
    );
    return 'Μετατροπή $count $_temp0...';
  }

  @override
  String get takePhoto => 'Λήψη φωτογραφίας';

  @override
  String get removeBackgroundTitle => 'Αφαίρεση φόντου;';

  @override
  String get removeBackgroundMessage =>
      'Θέλετε να αφαιρέσετε το φόντο και να το κάνετε διαφανές;';

  @override
  String get removeBackground => 'Αφαίρεση';

  @override
  String get keepOriginal => 'Διατήρηση';

  @override
  String get processingImage => 'Επεξεργασία εικόνας...';

  @override
  String get backgroundRemovalFailed => 'Η αφαίρεση φόντου απέτυχε';

  @override
  String get passwordLabel => 'Κωδικός πρόσβασης';

  @override
  String get unlockButton => 'Ξεκλείδωμα';
}
