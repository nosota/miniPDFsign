import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_az.dart';
import 'app_localizations_be.dart';
import 'app_localizations_bg.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_ca.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_eo.dart';
import 'app_localizations_es.dart';
import 'app_localizations_et.dart';
import 'app_localizations_eu.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fil.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_hr.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_hy.dart';
import 'app_localizations_id.dart';
import 'app_localizations_is.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ka.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_km.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_lt.dart';
import 'app_localizations_lv.dart';
import 'app_localizations_mn.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_my.dart';
import 'app_localizations_nb.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sk.dart';
import 'app_localizations_sl.dart';
import 'app_localizations_sq.dart';
import 'app_localizations_sr.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_uz.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('az'),
    Locale('be'),
    Locale('bg'),
    Locale('bn'),
    Locale('ca'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('en', 'AU'),
    Locale('en', 'GB'),
    Locale('en', 'NZ'),
    Locale('en', 'US'),
    Locale('eo'),
    Locale('es'),
    Locale('es', 'AR'),
    Locale('es', 'ES'),
    Locale('es', 'MX'),
    Locale('et'),
    Locale('eu'),
    Locale('fa'),
    Locale('fi'),
    Locale('fil'),
    Locale('fr'),
    Locale('he'),
    Locale('hi'),
    Locale('hr'),
    Locale('hu'),
    Locale('hy'),
    Locale('id'),
    Locale('is'),
    Locale('it'),
    Locale('ja'),
    Locale('ka'),
    Locale('kk'),
    Locale('km'),
    Locale('ko'),
    Locale('lt'),
    Locale('lv'),
    Locale('mn'),
    Locale('ms'),
    Locale('my'),
    Locale('nb'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('pt', 'PT'),
    Locale('ro'),
    Locale('ru'),
    Locale('sk'),
    Locale('sl'),
    Locale('sq'),
    Locale('sr'),
    Locale('sv'),
    Locale('ta'),
    Locale('th'),
    Locale('tr'),
    Locale('uk'),
    Locale('uz'),
    Locale('vi'),
    Locale('zh'),
    Locale('zh', 'CN'),
    Locale('zh', 'TW')
  ];

  /// Button label for opening a PDF file on desktop
  ///
  /// In en, this message translates to:
  /// **'Open PDF'**
  String get openPdf;

  /// Button label for opening a PDF or image file on mobile
  ///
  /// In en, this message translates to:
  /// **'Open File'**
  String get selectPdf;

  /// Default name for unsaved documents created from images
  ///
  /// In en, this message translates to:
  /// **'Untitled.pdf'**
  String get untitledDocument;

  /// Section header for recent files list
  ///
  /// In en, this message translates to:
  /// **'Recent Files'**
  String get recentFiles;

  /// Tooltip for remove button in recent files
  ///
  /// In en, this message translates to:
  /// **'Remove from list'**
  String get removeFromList;

  /// Time indicator for files opened less than a minute ago
  ///
  /// In en, this message translates to:
  /// **'Opened just now'**
  String get openedNow;

  /// Time indicator for files opened minutes ago
  ///
  /// In en, this message translates to:
  /// **'Opened {count} {count, plural, one{minute} other{minutes}} ago'**
  String openedMinutesAgo(int count);

  /// Time indicator for files opened hours ago
  ///
  /// In en, this message translates to:
  /// **'Opened {count} {count, plural, one{hour} other{hours}} ago'**
  String openedHoursAgo(int count);

  /// Time indicator for files opened yesterday
  ///
  /// In en, this message translates to:
  /// **'Opened yesterday'**
  String get openedYesterday;

  /// Time indicator for files opened days ago
  ///
  /// In en, this message translates to:
  /// **'Opened {count} {count, plural, one{day} other{days}} ago'**
  String openedDaysAgo(int count);

  /// Error message when file doesn't exist
  ///
  /// In en, this message translates to:
  /// **'File not found'**
  String get fileNotFound;

  /// Error message when file access is denied
  ///
  /// In en, this message translates to:
  /// **'Access denied'**
  String get fileAccessDenied;

  /// Button to clear all recent files
  ///
  /// In en, this message translates to:
  /// **'Clear recent files'**
  String get clearRecentFiles;

  /// Cancel button label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Confirm button label
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Generic error title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// OK button label
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// File menu label
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get menuFile;

  /// Open menu item
  ///
  /// In en, this message translates to:
  /// **'Open...'**
  String get menuOpen;

  /// Open Recent submenu label
  ///
  /// In en, this message translates to:
  /// **'Open Recent'**
  String get menuOpenRecent;

  /// Shown when no recent files available
  ///
  /// In en, this message translates to:
  /// **'No Recent Files'**
  String get menuNoRecentFiles;

  /// Clear recent files menu item
  ///
  /// In en, this message translates to:
  /// **'Clear Menu'**
  String get menuClearMenu;

  /// Save menu item
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get menuSave;

  /// Save As menu item
  ///
  /// In en, this message translates to:
  /// **'Save As...'**
  String get menuSaveAs;

  /// Save All menu item - saves all open documents with unsaved changes
  ///
  /// In en, this message translates to:
  /// **'Save All'**
  String get menuSaveAll;

  /// Share menu item
  ///
  /// In en, this message translates to:
  /// **'Share...'**
  String get menuShare;

  /// Close Window menu item
  ///
  /// In en, this message translates to:
  /// **'Close Window'**
  String get menuCloseWindow;

  /// Close All menu item - closes all open PDF windows
  ///
  /// In en, this message translates to:
  /// **'Close All'**
  String get menuCloseAll;

  /// Quit application menu item
  ///
  /// In en, this message translates to:
  /// **'Quit PDFSign'**
  String get menuQuit;

  /// Title for close all dialog
  ///
  /// In en, this message translates to:
  /// **'Save Changes?'**
  String get closeAllDialogTitle;

  /// Message for close all dialog with multiple documents
  ///
  /// In en, this message translates to:
  /// **'Do you want to save changes to {count} documents before closing?'**
  String closeAllDialogMessage(int count);

  /// Message for close all dialog with single document
  ///
  /// In en, this message translates to:
  /// **'Do you want to save changes to 1 document before closing?'**
  String get closeAllDialogMessageOne;

  /// Save All button in close all dialog
  ///
  /// In en, this message translates to:
  /// **'Save All'**
  String get closeAllDialogSaveAll;

  /// Don't Save button in close all dialog
  ///
  /// In en, this message translates to:
  /// **'Don\'t Save'**
  String get closeAllDialogDontSave;

  /// Cancel button in close all dialog
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get closeAllDialogCancel;

  /// Title for save failed dialog
  ///
  /// In en, this message translates to:
  /// **'Save Failed'**
  String get saveFailedDialogTitle;

  /// Message for save failed dialog
  ///
  /// In en, this message translates to:
  /// **'Failed to save {count} {count, plural, one{document} other{documents}}. Close anyway?'**
  String saveFailedDialogMessage(int count);

  /// Close anyway button in save failed dialog
  ///
  /// In en, this message translates to:
  /// **'Close Anyway'**
  String get saveFailedDialogClose;

  /// Title for save changes dialog
  ///
  /// In en, this message translates to:
  /// **'Save Changes?'**
  String get saveChangesTitle;

  /// Message for save changes dialog
  ///
  /// In en, this message translates to:
  /// **'Do you want to save changes to \"{fileName}\" before closing?'**
  String saveChangesMessage(String fileName);

  /// Save button in dialog
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// Discard button in dialog
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discardButton;

  /// Window title suffix when document has unsaved changes
  ///
  /// In en, this message translates to:
  /// **'Edited'**
  String get documentEdited;

  /// Window title suffix when document is saved
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get documentSaved;

  /// Settings menu item
  ///
  /// In en, this message translates to:
  /// **'Settings...'**
  String get menuSettings;

  /// Window menu label
  ///
  /// In en, this message translates to:
  /// **'Window'**
  String get menuWindow;

  /// Minimize window menu item
  ///
  /// In en, this message translates to:
  /// **'Minimize'**
  String get menuMinimize;

  /// Zoom (maximize/restore) window menu item
  ///
  /// In en, this message translates to:
  /// **'Zoom'**
  String get menuZoom;

  /// Bring all windows to front menu item
  ///
  /// In en, this message translates to:
  /// **'Bring All to Front'**
  String get menuBringAllToFront;

  /// Settings dialog title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Language setting label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// System default language option
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get settingsLanguageSystem;

  /// Units setting label
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get settingsUnits;

  /// Centimeters unit option
  ///
  /// In en, this message translates to:
  /// **'Centimeters'**
  String get settingsUnitsCentimeters;

  /// Inches unit option
  ///
  /// In en, this message translates to:
  /// **'Inches'**
  String get settingsUnitsInches;

  /// Placeholder text for language search field
  ///
  /// In en, this message translates to:
  /// **'Search languages...'**
  String get settingsSearchLanguages;

  /// General settings section in sidebar
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingsGeneral;

  /// Button label for adding an image
  ///
  /// In en, this message translates to:
  /// **'Add Image'**
  String get addImage;

  /// File picker dialog title for selecting images
  ///
  /// In en, this message translates to:
  /// **'Select Images'**
  String get selectImages;

  /// Zoom preset for fitting document width
  ///
  /// In en, this message translates to:
  /// **'Fit Width'**
  String get zoomFitWidth;

  /// Zoom in button tooltip
  ///
  /// In en, this message translates to:
  /// **'Zoom In'**
  String get zoomIn;

  /// Zoom out button tooltip
  ///
  /// In en, this message translates to:
  /// **'Zoom Out'**
  String get zoomOut;

  /// Tooltip for zoom dropdown
  ///
  /// In en, this message translates to:
  /// **'Select zoom level'**
  String get selectZoomLevel;

  /// Dialog title for go to page
  ///
  /// In en, this message translates to:
  /// **'Go to Page'**
  String get goToPage;

  /// Go button label
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get go;

  /// File picker dialog title for Save As
  ///
  /// In en, this message translates to:
  /// **'Save PDF As'**
  String get savePdfAs;

  /// Error message when PDF password is wrong
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get incorrectPassword;

  /// Save operation failed message prefix
  ///
  /// In en, this message translates to:
  /// **'Save failed'**
  String get saveFailed;

  /// Success message after saving file
  ///
  /// In en, this message translates to:
  /// **'Saved to: {path}'**
  String savedTo(String path);

  /// Error when original PDF data is not available
  ///
  /// In en, this message translates to:
  /// **'No original PDF stored'**
  String get noOriginalPdfStored;

  /// Message shown while waiting for user to grant folder access permission on macOS
  ///
  /// In en, this message translates to:
  /// **'Waiting for folder access permission...'**
  String get waitingForFolderPermission;

  /// Message shown when no recent files exist
  ///
  /// In en, this message translates to:
  /// **'Open a file to get started'**
  String get emptyRecentFiles;

  /// Title for the image library section
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get imagesTitle;

  /// Empty state title when no images in library
  ///
  /// In en, this message translates to:
  /// **'No images yet'**
  String get noImagesYet;

  /// Empty state hint text
  ///
  /// In en, this message translates to:
  /// **'Tap + to add your first stamp or signature'**
  String get noImagesHint;

  /// Done button label
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Edit button label
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get menuEdit;

  /// Action sheet option to pick images from file system
  ///
  /// In en, this message translates to:
  /// **'Choose from Files'**
  String get chooseFromFiles;

  /// Action sheet option to pick images from photo gallery
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// Error message when image file size exceeds limit
  ///
  /// In en, this message translates to:
  /// **'Image is too large (max 50 MB)'**
  String get imageTooBig;

  /// Error message when image resolution exceeds limit
  ///
  /// In en, this message translates to:
  /// **'Image resolution is too high (max 4096x4096)'**
  String get imageResolutionTooHigh;

  /// Error message when image format is not supported
  ///
  /// In en, this message translates to:
  /// **'Unsupported image format'**
  String get unsupportedImageFormat;

  /// Tooltip for delete button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteTooltip;

  /// Tooltip for share button
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareTooltip;

  /// Page indicator showing current page and total pages
  ///
  /// In en, this message translates to:
  /// **'Page {currentPage} of {totalPages}'**
  String pageIndicator(int currentPage, int totalPages);

  /// Message shown when no PDF document is loaded
  ///
  /// In en, this message translates to:
  /// **'No document loaded'**
  String get noDocumentLoaded;

  /// Error title when PDF fails to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load PDF'**
  String get failedToLoadPdf;

  /// Title shown when PDF requires password
  ///
  /// In en, this message translates to:
  /// **'Password Required'**
  String get passwordRequired;

  /// Message explaining that PDF is password protected
  ///
  /// In en, this message translates to:
  /// **'This PDF is password protected.'**
  String get pdfPasswordProtected;

  /// Generic error message with details
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorWithMessage(String message);

  /// Title for unsaved changes dialog
  ///
  /// In en, this message translates to:
  /// **'Unsaved Changes'**
  String get unsavedChangesTitle;

  /// Message asking to save changes before closing
  ///
  /// In en, this message translates to:
  /// **'Do you want to save changes to \"{fileName}\"?'**
  String unsavedChangesMessage(String fileName);

  /// Onboarding hint for Open PDF button
  ///
  /// In en, this message translates to:
  /// **'Tap to open a PDF document'**
  String get onboardingOpenPdf;

  /// Onboarding hint for image library sheet
  ///
  /// In en, this message translates to:
  /// **'Swipe up to add signatures and stamps'**
  String get onboardingSwipeUp;

  /// Onboarding hint for add image button
  ///
  /// In en, this message translates to:
  /// **'Tap to add your first signature or stamp'**
  String get onboardingAddImage;

  /// Onboarding hint for dragging image to PDF
  ///
  /// In en, this message translates to:
  /// **'Drag onto PDF to place it'**
  String get onboardingDragImage;

  /// Onboarding hint for placed object interaction
  ///
  /// In en, this message translates to:
  /// **'Tap to select. Drag corners to resize.'**
  String get onboardingResizeObject;

  /// Onboarding hint for delete button
  ///
  /// In en, this message translates to:
  /// **'Tap to delete the selected image'**
  String get onboardingDeleteImage;

  /// Instruction to dismiss onboarding hint
  ///
  /// In en, this message translates to:
  /// **'Tap anywhere to continue'**
  String get onboardingTapToContinue;

  /// Error message when image to PDF conversion fails
  ///
  /// In en, this message translates to:
  /// **'Failed to convert image to PDF'**
  String get imageConversionFailed;

  /// Title for save document dialog
  ///
  /// In en, this message translates to:
  /// **'Save Document'**
  String get saveDocumentTitle;

  /// Label for filename input field
  ///
  /// In en, this message translates to:
  /// **'File name'**
  String get fileNameLabel;

  /// Default suggested filename when saving a new document
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get defaultFileName;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'az',
        'be',
        'bg',
        'bn',
        'ca',
        'cs',
        'da',
        'de',
        'el',
        'en',
        'eo',
        'es',
        'et',
        'eu',
        'fa',
        'fi',
        'fil',
        'fr',
        'he',
        'hi',
        'hr',
        'hu',
        'hy',
        'id',
        'is',
        'it',
        'ja',
        'ka',
        'kk',
        'km',
        'ko',
        'lt',
        'lv',
        'mn',
        'ms',
        'my',
        'nb',
        'nl',
        'pl',
        'pt',
        'ro',
        'ru',
        'sk',
        'sl',
        'sq',
        'sr',
        'sv',
        'ta',
        'th',
        'tr',
        'uk',
        'uz',
        'vi',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'en':
      {
        switch (locale.countryCode) {
          case 'AU':
            return AppLocalizationsEnAu();
          case 'GB':
            return AppLocalizationsEnGb();
          case 'NZ':
            return AppLocalizationsEnNz();
          case 'US':
            return AppLocalizationsEnUs();
        }
        break;
      }
    case 'es':
      {
        switch (locale.countryCode) {
          case 'AR':
            return AppLocalizationsEsAr();
          case 'ES':
            return AppLocalizationsEsEs();
          case 'MX':
            return AppLocalizationsEsMx();
        }
        break;
      }
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
          case 'PT':
            return AppLocalizationsPtPt();
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return AppLocalizationsZhCn();
          case 'TW':
            return AppLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'az':
      return AppLocalizationsAz();
    case 'be':
      return AppLocalizationsBe();
    case 'bg':
      return AppLocalizationsBg();
    case 'bn':
      return AppLocalizationsBn();
    case 'ca':
      return AppLocalizationsCa();
    case 'cs':
      return AppLocalizationsCs();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'eo':
      return AppLocalizationsEo();
    case 'es':
      return AppLocalizationsEs();
    case 'et':
      return AppLocalizationsEt();
    case 'eu':
      return AppLocalizationsEu();
    case 'fa':
      return AppLocalizationsFa();
    case 'fi':
      return AppLocalizationsFi();
    case 'fil':
      return AppLocalizationsFil();
    case 'fr':
      return AppLocalizationsFr();
    case 'he':
      return AppLocalizationsHe();
    case 'hi':
      return AppLocalizationsHi();
    case 'hr':
      return AppLocalizationsHr();
    case 'hu':
      return AppLocalizationsHu();
    case 'hy':
      return AppLocalizationsHy();
    case 'id':
      return AppLocalizationsId();
    case 'is':
      return AppLocalizationsIs();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ka':
      return AppLocalizationsKa();
    case 'kk':
      return AppLocalizationsKk();
    case 'km':
      return AppLocalizationsKm();
    case 'ko':
      return AppLocalizationsKo();
    case 'lt':
      return AppLocalizationsLt();
    case 'lv':
      return AppLocalizationsLv();
    case 'mn':
      return AppLocalizationsMn();
    case 'ms':
      return AppLocalizationsMs();
    case 'my':
      return AppLocalizationsMy();
    case 'nb':
      return AppLocalizationsNb();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'sk':
      return AppLocalizationsSk();
    case 'sl':
      return AppLocalizationsSl();
    case 'sq':
      return AppLocalizationsSq();
    case 'sr':
      return AppLocalizationsSr();
    case 'sv':
      return AppLocalizationsSv();
    case 'ta':
      return AppLocalizationsTa();
    case 'th':
      return AppLocalizationsTh();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'uz':
      return AppLocalizationsUz();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
