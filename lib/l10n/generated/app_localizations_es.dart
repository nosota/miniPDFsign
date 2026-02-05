// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get selectPdf => 'Abrir archivo';

  @override
  String get untitledDocument => 'Sin título.pdf';

  @override
  String get recentFiles => 'Archivos recientes';

  @override
  String get removeFromList => 'Eliminar de la lista';

  @override
  String get openedNow => 'Abierto ahora';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutos',
      one: 'minuto',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'horas',
      one: 'hora',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String get openedYesterday => 'Abierto ayer';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'días',
      one: 'día',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String get fileNotFound => 'Archivo no encontrado';

  @override
  String get fileAccessDenied => 'Acceso denegado';

  @override
  String get clearRecentFiles => 'Borrar archivos recientes';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get error => 'Error';

  @override
  String get ok => 'Aceptar';

  @override
  String get menuFile => 'Archivo';

  @override
  String get menuOpen => 'Abrir...';

  @override
  String get menuOpenRecent => 'Abrir reciente';

  @override
  String get menuNoRecentFiles => 'No hay archivos recientes';

  @override
  String get menuClearMenu => 'Limpiar menú';

  @override
  String get menuSave => 'Guardar';

  @override
  String get menuSaveAs => 'Guardar como...';

  @override
  String get menuSaveAll => 'Guardar todo';

  @override
  String get menuShare => 'Compartir...';

  @override
  String get menuCloseWindow => 'Cerrar ventana';

  @override
  String get menuCloseAll => 'Cerrar todo';

  @override
  String get menuQuit => 'Salir de PDFSign';

  @override
  String get closeAllDialogTitle => '¿Guardar cambios?';

  @override
  String closeAllDialogMessage(int count) {
    return '¿Desea guardar los cambios en $count documentos antes de cerrar?';
  }

  @override
  String get closeAllDialogMessageOne =>
      '¿Desea guardar los cambios en 1 documento antes de cerrar?';

  @override
  String get closeAllDialogSaveAll => 'Guardar todo';

  @override
  String get closeAllDialogDontSave => 'No guardar';

  @override
  String get closeAllDialogCancel => 'Cancelar';

  @override
  String get saveFailedDialogTitle => 'Error al guardar';

  @override
  String saveFailedDialogMessage(int count) {
    return 'No se pudieron guardar $count documento(s). ¿Cerrar de todos modos?';
  }

  @override
  String get saveFailedDialogClose => 'Cerrar de todos modos';

  @override
  String get saveChangesTitle => '¿Guardar cambios?';

  @override
  String saveChangesMessage(String fileName) {
    return '¿Deseas guardar los cambios en \"$fileName\" antes de cerrar?';
  }

  @override
  String get saveButton => 'Guardar';

  @override
  String get discardButton => 'No guardar';

  @override
  String get documentEdited => 'Editado';

  @override
  String get documentSaved => 'Guardado';

  @override
  String get menuSettings => 'Configuración...';

  @override
  String get menuWindow => 'Ventana';

  @override
  String get menuMinimize => 'Minimizar';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Traer todo al frente';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Predeterminado del sistema';

  @override
  String get settingsUnits => 'Unidades';

  @override
  String get settingsUnitsCentimeters => 'Centímetros';

  @override
  String get settingsUnitsInches => 'Pulgadas';

  @override
  String get settingsUnitsDefault => 'Predeterminado (por región)';

  @override
  String get settingsSearchLanguages => 'Buscar idiomas...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Añadir imagen';

  @override
  String get selectImages => 'Seleccionar imágenes';

  @override
  String get zoomFitWidth => 'Ajustar ancho';

  @override
  String get zoomIn => 'Acercar';

  @override
  String get zoomOut => 'Alejar';

  @override
  String get selectZoomLevel => 'Seleccionar nivel de zoom';

  @override
  String get goToPage => 'Ir a página';

  @override
  String get go => 'Ir';

  @override
  String get savePdfAs => 'Guardar PDF como';

  @override
  String get incorrectPassword => 'Contraseña incorrecta';

  @override
  String get saveFailed => 'Error al guardar';

  @override
  String savedTo(String path) {
    return 'Guardado en: $path';
  }

  @override
  String get noOriginalPdfStored => 'No hay PDF original almacenado';

  @override
  String get waitingForFolderPermission =>
      'Esperando permiso de acceso a la carpeta...';

  @override
  String get emptyRecentFiles => 'Abre un archivo para empezar';

  @override
  String get imagesTitle => 'Imágenes';

  @override
  String get noImagesYet => 'Sin imágenes';

  @override
  String get noImagesHint => 'Toca + para agregar tu primer sello o firma';

  @override
  String get done => 'Listo';

  @override
  String get menuEdit => 'Editar';

  @override
  String get chooseFromFiles => 'Elegir de archivos';

  @override
  String get chooseFromGallery => 'Elegir de galería';

  @override
  String get imageTooBig => 'La imagen es demasiado grande (máx. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'La resolución es demasiado alta (máx. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Formato de imagen no compatible';

  @override
  String get deleteTooltip => 'Eliminar';

  @override
  String get shareTooltip => 'Compartir';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Página $currentPage de $totalPages';
  }

  @override
  String get noDocumentLoaded => 'No hay documento cargado';

  @override
  String get failedToLoadPdf => 'Error al cargar el PDF';

  @override
  String get passwordRequired => 'Contraseña requerida';

  @override
  String get pdfPasswordProtected => 'Este PDF está protegido con contraseña.';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get unsavedChangesTitle => 'Cambios sin guardar';

  @override
  String unsavedChangesMessage(String fileName) {
    return '¿Desea guardar los cambios en \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Toca para abrir un documento PDF';

  @override
  String get onboardingSwipeUp =>
      'Desliza hacia arriba para añadir firmas y sellos';

  @override
  String get onboardingAddImage => 'Toca para añadir tu primera firma o sello';

  @override
  String get onboardingDragImage => 'Arrastra al PDF para colocarlo';

  @override
  String get onboardingResizeObject =>
      'Toca para seleccionar. Arrastra las esquinas para redimensionar.';

  @override
  String get onboardingDeleteImage =>
      'Toca para eliminar la imagen seleccionada';

  @override
  String get onboardingTapToContinue =>
      'Toca en cualquier lugar para continuar';

  @override
  String get imageConversionFailed => 'Error al convertir la imagen a PDF';

  @override
  String get saveDocumentTitle => 'Guardar documento';

  @override
  String get fileNameLabel => 'Nombre del archivo';

  @override
  String get defaultFileName => 'Documento';

  @override
  String get onlyOnePdfAllowed => 'Solo se puede abrir un PDF a la vez';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'Se ignoraron los archivos PDF. Solo se convierten las imágenes.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imágenes',
      one: 'imagen',
    );
    return 'Convirtiendo $count $_temp0...';
  }

  @override
  String get takePhoto => 'Tomar foto';

  @override
  String get removeBackgroundTitle => '¿Eliminar fondo?';

  @override
  String get removeBackgroundMessage =>
      'Se detectó un fondo uniforme. ¿Desea hacerlo transparente?';

  @override
  String get removeBackground => 'Eliminar';

  @override
  String get keepOriginal => 'Conservar';

  @override
  String get processingImage => 'Procesando imagen...';

  @override
  String get backgroundRemovalFailed => 'Error al eliminar el fondo';
}

/// The translations for Spanish Castilian, as used in Argentina (`es_AR`).
class AppLocalizationsEsAr extends AppLocalizationsEs {
  AppLocalizationsEsAr() : super('es_AR');

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get selectPdf => 'Abrir archivo';

  @override
  String get untitledDocument => 'Sin título.pdf';

  @override
  String get recentFiles => 'Archivos recientes';

  @override
  String get removeFromList => 'Eliminar de la lista';

  @override
  String get openedNow => 'Abierto ahora';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutos',
      one: 'minuto',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'horas',
      one: 'hora',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String get openedYesterday => 'Abierto ayer';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'días',
      one: 'día',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String get fileNotFound => 'Archivo no encontrado';

  @override
  String get fileAccessDenied => 'Acceso denegado';

  @override
  String get clearRecentFiles => 'Borrar archivos recientes';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get error => 'Error';

  @override
  String get ok => 'Aceptar';

  @override
  String get menuFile => 'Archivo';

  @override
  String get menuOpen => 'Abrir...';

  @override
  String get menuOpenRecent => 'Abrir reciente';

  @override
  String get menuNoRecentFiles => 'No hay archivos recientes';

  @override
  String get menuClearMenu => 'Limpiar menú';

  @override
  String get menuSave => 'Guardar';

  @override
  String get menuSaveAs => 'Guardar como...';

  @override
  String get menuSaveAll => 'Guardar todo';

  @override
  String get menuShare => 'Compartir...';

  @override
  String get menuCloseWindow => 'Cerrar ventana';

  @override
  String get menuCloseAll => 'Cerrar todo';

  @override
  String get menuQuit => 'Salir de PDFSign';

  @override
  String get closeAllDialogTitle => '¿Guardar cambios?';

  @override
  String closeAllDialogMessage(int count) {
    return '¿Desea guardar los cambios en $count documentos antes de cerrar?';
  }

  @override
  String get closeAllDialogMessageOne =>
      '¿Desea guardar los cambios en 1 documento antes de cerrar?';

  @override
  String get closeAllDialogSaveAll => 'Guardar todo';

  @override
  String get closeAllDialogDontSave => 'No guardar';

  @override
  String get closeAllDialogCancel => 'Cancelar';

  @override
  String get saveFailedDialogTitle => 'Error al guardar';

  @override
  String saveFailedDialogMessage(int count) {
    return 'No se pudieron guardar $count documento(s). ¿Cerrar de todos modos?';
  }

  @override
  String get saveFailedDialogClose => 'Cerrar de todos modos';

  @override
  String get saveChangesTitle => '¿Guardar cambios?';

  @override
  String saveChangesMessage(String fileName) {
    return '¿Deseás guardar los cambios en \"$fileName\" antes de cerrar?';
  }

  @override
  String get saveButton => 'Guardar';

  @override
  String get discardButton => 'No guardar';

  @override
  String get documentEdited => 'Editado';

  @override
  String get documentSaved => 'Guardado';

  @override
  String get menuSettings => 'Configuración...';

  @override
  String get menuWindow => 'Ventana';

  @override
  String get menuMinimize => 'Minimizar';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Traer todo al frente';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Predeterminado del sistema';

  @override
  String get settingsUnits => 'Unidades';

  @override
  String get settingsUnitsCentimeters => 'Centímetros';

  @override
  String get settingsUnitsInches => 'Pulgadas';

  @override
  String get settingsUnitsDefault => 'Predeterminado (por región)';

  @override
  String get settingsSearchLanguages => 'Buscar idiomas...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Agregar imagen';

  @override
  String get selectImages => 'Seleccionar imágenes';

  @override
  String get zoomFitWidth => 'Ajustar ancho';

  @override
  String get zoomIn => 'Acercar';

  @override
  String get zoomOut => 'Alejar';

  @override
  String get selectZoomLevel => 'Seleccionar nivel de zoom';

  @override
  String get goToPage => 'Ir a página';

  @override
  String get go => 'Ir';

  @override
  String get savePdfAs => 'Guardar PDF como';

  @override
  String get incorrectPassword => 'Contraseña incorrecta';

  @override
  String get saveFailed => 'Error al guardar';

  @override
  String savedTo(String path) {
    return 'Guardado en: $path';
  }

  @override
  String get noOriginalPdfStored => 'No hay PDF original almacenado';

  @override
  String get waitingForFolderPermission =>
      'Esperando permiso de acceso a la carpeta...';

  @override
  String get emptyRecentFiles => 'Abrí un archivo para empezar';

  @override
  String get imagesTitle => 'Imágenes';

  @override
  String get noImagesYet => 'Sin imágenes';

  @override
  String get noImagesHint => 'Tocá + para agregar tu primer sello o firma';

  @override
  String get done => 'Listo';

  @override
  String get menuEdit => 'Editar';

  @override
  String get chooseFromFiles => 'Elegir de archivos';

  @override
  String get chooseFromGallery => 'Elegir de galería';

  @override
  String get imageTooBig => 'La imagen es demasiado grande (máx. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'La resolución es demasiado alta (máx. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Formato de imagen no compatible';

  @override
  String get deleteTooltip => 'Eliminar';

  @override
  String get shareTooltip => 'Compartir';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Página $currentPage de $totalPages';
  }

  @override
  String get noDocumentLoaded => 'No hay documento cargado';

  @override
  String get failedToLoadPdf => 'No se pudo cargar el PDF';

  @override
  String get passwordRequired => 'Contraseña requerida';

  @override
  String get pdfPasswordProtected => 'Este PDF está protegido con contraseña.';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get unsavedChangesTitle => 'Cambios sin guardar';

  @override
  String unsavedChangesMessage(String fileName) {
    return '¿Querés guardar los cambios en \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Tocá para abrir un documento PDF';

  @override
  String get onboardingSwipeUp =>
      'Deslizá hacia arriba para agregar firmas y sellos';

  @override
  String get onboardingAddImage => 'Tocá para agregar tu primera firma o sello';

  @override
  String get onboardingDragImage => 'Arrastrá sobre el PDF para colocarlo';

  @override
  String get onboardingResizeObject =>
      'Tocá para seleccionar. Arrastrá las esquinas para redimensionar.';

  @override
  String get onboardingDeleteImage =>
      'Tocá para eliminar la imagen seleccionada';

  @override
  String get onboardingTapToContinue =>
      'Tocá en cualquier lugar para continuar';

  @override
  String get imageConversionFailed => 'Error al convertir la imagen a PDF';

  @override
  String get saveDocumentTitle => 'Guardar documento';

  @override
  String get fileNameLabel => 'Nombre del archivo';

  @override
  String get defaultFileName => 'Documento';

  @override
  String get onlyOnePdfAllowed => 'Solo se puede abrir un PDF a la vez';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'Se ignoraron los archivos PDF. Solo se convierten las imágenes.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imágenes',
      one: 'imagen',
    );
    return 'Convirtiendo $count $_temp0...';
  }

  @override
  String get takePhoto => 'Sacar foto';

  @override
  String get removeBackgroundTitle => '¿Eliminar fondo?';

  @override
  String get removeBackgroundMessage =>
      'Se detectó un fondo uniforme. ¿Querés hacerlo transparente?';

  @override
  String get removeBackground => 'Eliminar';

  @override
  String get keepOriginal => 'Conservar';

  @override
  String get processingImage => 'Procesando imagen...';

  @override
  String get backgroundRemovalFailed => 'Error al eliminar el fondo';
}

/// The translations for Spanish Castilian, as used in Spain (`es_ES`).
class AppLocalizationsEsEs extends AppLocalizationsEs {
  AppLocalizationsEsEs() : super('es_ES');

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get selectPdf => 'Abrir archivo';

  @override
  String get untitledDocument => 'Sin título.pdf';

  @override
  String get recentFiles => 'Archivos recientes';

  @override
  String get removeFromList => 'Eliminar de la lista';

  @override
  String get openedNow => 'Abierto ahora';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutos',
      one: 'minuto',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'horas',
      one: 'hora',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String get openedYesterday => 'Abierto ayer';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'días',
      one: 'día',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String get fileNotFound => 'Archivo no encontrado';

  @override
  String get fileAccessDenied => 'Acceso denegado';

  @override
  String get clearRecentFiles => 'Borrar archivos recientes';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get error => 'Error';

  @override
  String get ok => 'Aceptar';

  @override
  String get menuFile => 'Archivo';

  @override
  String get menuOpen => 'Abrir...';

  @override
  String get menuOpenRecent => 'Abrir reciente';

  @override
  String get menuNoRecentFiles => 'No hay archivos recientes';

  @override
  String get menuClearMenu => 'Vaciar menú';

  @override
  String get menuSave => 'Guardar';

  @override
  String get menuSaveAs => 'Guardar como...';

  @override
  String get menuSaveAll => 'Guardar todo';

  @override
  String get menuShare => 'Compartir...';

  @override
  String get menuCloseWindow => 'Cerrar ventana';

  @override
  String get menuCloseAll => 'Cerrar todo';

  @override
  String get menuQuit => 'Salir de PDFSign';

  @override
  String get closeAllDialogTitle => '¿Guardar cambios?';

  @override
  String closeAllDialogMessage(int count) {
    return '¿Desea guardar los cambios en $count documentos antes de cerrar?';
  }

  @override
  String get closeAllDialogMessageOne =>
      '¿Desea guardar los cambios en 1 documento antes de cerrar?';

  @override
  String get closeAllDialogSaveAll => 'Guardar todo';

  @override
  String get closeAllDialogDontSave => 'No guardar';

  @override
  String get closeAllDialogCancel => 'Cancelar';

  @override
  String get saveFailedDialogTitle => 'Error al guardar';

  @override
  String saveFailedDialogMessage(int count) {
    return 'No se pudieron guardar $count documento(s). ¿Cerrar de todos modos?';
  }

  @override
  String get saveFailedDialogClose => 'Cerrar de todos modos';

  @override
  String get saveChangesTitle => '¿Guardar cambios?';

  @override
  String saveChangesMessage(String fileName) {
    return '¿Deseáis guardar los cambios en «$fileName» antes de cerrar?';
  }

  @override
  String get saveButton => 'Guardar';

  @override
  String get discardButton => 'No guardar';

  @override
  String get documentEdited => 'Editado';

  @override
  String get documentSaved => 'Guardado';

  @override
  String get menuSettings => 'Ajustes...';

  @override
  String get menuWindow => 'Ventana';

  @override
  String get menuMinimize => 'Minimizar';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Traer todo al frente';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Predeterminado del sistema';

  @override
  String get settingsUnits => 'Unidades';

  @override
  String get settingsUnitsCentimeters => 'Centímetros';

  @override
  String get settingsUnitsInches => 'Pulgadas';

  @override
  String get settingsUnitsDefault => 'Predeterminado (por región)';

  @override
  String get settingsSearchLanguages => 'Buscar idiomas...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Añadir imagen';

  @override
  String get selectImages => 'Seleccionar imágenes';

  @override
  String get zoomFitWidth => 'Ajustar ancho';

  @override
  String get zoomIn => 'Acercar';

  @override
  String get zoomOut => 'Alejar';

  @override
  String get selectZoomLevel => 'Seleccionar nivel de zoom';

  @override
  String get goToPage => 'Ir a página';

  @override
  String get go => 'Ir';

  @override
  String get savePdfAs => 'Guardar PDF como';

  @override
  String get incorrectPassword => 'Contraseña incorrecta';

  @override
  String get saveFailed => 'Error al guardar';

  @override
  String savedTo(String path) {
    return 'Guardado en: $path';
  }

  @override
  String get noOriginalPdfStored => 'No hay PDF original almacenado';

  @override
  String get waitingForFolderPermission =>
      'Esperando permiso de acceso a la carpeta...';

  @override
  String get emptyRecentFiles => 'Abre un archivo para empezar';

  @override
  String get imagesTitle => 'Imágenes';

  @override
  String get noImagesYet => 'Sin imágenes';

  @override
  String get noImagesHint => 'Toca + para agregar tu primer sello o firma';

  @override
  String get done => 'Listo';

  @override
  String get menuEdit => 'Editar';

  @override
  String get chooseFromFiles => 'Elegir de archivos';

  @override
  String get chooseFromGallery => 'Elegir de galería';

  @override
  String get imageTooBig => 'La imagen es demasiado grande (máx. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'La resolución es demasiado alta (máx. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Formato de imagen no compatible';

  @override
  String get deleteTooltip => 'Eliminar';

  @override
  String get shareTooltip => 'Compartir';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Página $currentPage de $totalPages';
  }

  @override
  String get noDocumentLoaded => 'No hay documento cargado';

  @override
  String get failedToLoadPdf => 'No se ha podido cargar el PDF';

  @override
  String get passwordRequired => 'Contraseña requerida';

  @override
  String get pdfPasswordProtected => 'Este PDF está protegido con contraseña.';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get unsavedChangesTitle => 'Cambios sin guardar';

  @override
  String unsavedChangesMessage(String fileName) {
    return '¿Desea guardar los cambios en «$fileName»?';
  }

  @override
  String get onboardingOpenPdf => 'Toca para abrir un documento PDF';

  @override
  String get onboardingSwipeUp =>
      'Desliza hacia arriba para añadir firmas y sellos';

  @override
  String get onboardingAddImage => 'Toca para añadir tu primera firma o sello';

  @override
  String get onboardingDragImage => 'Arrastra sobre el PDF para colocarlo';

  @override
  String get onboardingResizeObject =>
      'Toca para seleccionar. Arrastra las esquinas para redimensionar.';

  @override
  String get onboardingDeleteImage =>
      'Toca para eliminar la imagen seleccionada';

  @override
  String get onboardingTapToContinue =>
      'Toca en cualquier lugar para continuar';

  @override
  String get imageConversionFailed => 'Error al convertir la imagen a PDF';

  @override
  String get saveDocumentTitle => 'Guardar documento';

  @override
  String get fileNameLabel => 'Nombre del archivo';

  @override
  String get defaultFileName => 'Documento';

  @override
  String get onlyOnePdfAllowed => 'Solo se puede abrir un PDF a la vez';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'Se ignoraron los archivos PDF. Solo se convierten las imágenes.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imágenes',
      one: 'imagen',
    );
    return 'Convirtiendo $count $_temp0...';
  }

  @override
  String get takePhoto => 'Hacer foto';

  @override
  String get removeBackgroundTitle => '¿Eliminar fondo?';

  @override
  String get removeBackgroundMessage =>
      'Se ha detectado un fondo uniforme. ¿Desea hacerlo transparente?';

  @override
  String get removeBackground => 'Eliminar';

  @override
  String get keepOriginal => 'Conservar';

  @override
  String get processingImage => 'Procesando imagen...';

  @override
  String get backgroundRemovalFailed => 'Error al eliminar el fondo';
}

/// The translations for Spanish Castilian, as used in Mexico (`es_MX`).
class AppLocalizationsEsMx extends AppLocalizationsEs {
  AppLocalizationsEsMx() : super('es_MX');

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get selectPdf => 'Abrir archivo';

  @override
  String get untitledDocument => 'Sin título.pdf';

  @override
  String get recentFiles => 'Archivos recientes';

  @override
  String get removeFromList => 'Eliminar de la lista';

  @override
  String get openedNow => 'Abierto ahora';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutos',
      one: 'minuto',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'horas',
      one: 'hora',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String get openedYesterday => 'Abierto ayer';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'días',
      one: 'día',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String get fileNotFound => 'Archivo no encontrado';

  @override
  String get fileAccessDenied => 'Acceso denegado';

  @override
  String get clearRecentFiles => 'Borrar archivos recientes';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get error => 'Error';

  @override
  String get ok => 'Aceptar';

  @override
  String get menuFile => 'Archivo';

  @override
  String get menuOpen => 'Abrir...';

  @override
  String get menuOpenRecent => 'Abrir reciente';

  @override
  String get menuNoRecentFiles => 'No hay archivos recientes';

  @override
  String get menuClearMenu => 'Limpiar menú';

  @override
  String get menuSave => 'Guardar';

  @override
  String get menuSaveAs => 'Guardar como...';

  @override
  String get menuSaveAll => 'Guardar todo';

  @override
  String get menuShare => 'Compartir...';

  @override
  String get menuCloseWindow => 'Cerrar ventana';

  @override
  String get menuCloseAll => 'Cerrar todo';

  @override
  String get menuQuit => 'Salir de PDFSign';

  @override
  String get closeAllDialogTitle => '¿Guardar cambios?';

  @override
  String closeAllDialogMessage(int count) {
    return '¿Desea guardar los cambios en $count documentos antes de cerrar?';
  }

  @override
  String get closeAllDialogMessageOne =>
      '¿Desea guardar los cambios en 1 documento antes de cerrar?';

  @override
  String get closeAllDialogSaveAll => 'Guardar todo';

  @override
  String get closeAllDialogDontSave => 'No guardar';

  @override
  String get closeAllDialogCancel => 'Cancelar';

  @override
  String get saveFailedDialogTitle => 'Error al guardar';

  @override
  String saveFailedDialogMessage(int count) {
    return 'No se pudieron guardar $count documento(s). ¿Cerrar de todos modos?';
  }

  @override
  String get saveFailedDialogClose => 'Cerrar de todos modos';

  @override
  String get saveChangesTitle => '¿Guardar cambios?';

  @override
  String saveChangesMessage(String fileName) {
    return '¿Deseas guardar los cambios en \"$fileName\" antes de cerrar?';
  }

  @override
  String get saveButton => 'Guardar';

  @override
  String get discardButton => 'No guardar';

  @override
  String get documentEdited => 'Editado';

  @override
  String get documentSaved => 'Guardado';

  @override
  String get menuSettings => 'Configuración...';

  @override
  String get menuWindow => 'Ventana';

  @override
  String get menuMinimize => 'Minimizar';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Traer todo al frente';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Predeterminado del sistema';

  @override
  String get settingsUnits => 'Unidades';

  @override
  String get settingsUnitsCentimeters => 'Centímetros';

  @override
  String get settingsUnitsInches => 'Pulgadas';

  @override
  String get settingsUnitsDefault => 'Predeterminado (por región)';

  @override
  String get settingsSearchLanguages => 'Buscar idiomas...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Agregar imagen';

  @override
  String get selectImages => 'Seleccionar imágenes';

  @override
  String get zoomFitWidth => 'Ajustar ancho';

  @override
  String get zoomIn => 'Acercar';

  @override
  String get zoomOut => 'Alejar';

  @override
  String get selectZoomLevel => 'Seleccionar nivel de zoom';

  @override
  String get goToPage => 'Ir a página';

  @override
  String get go => 'Ir';

  @override
  String get savePdfAs => 'Guardar PDF como';

  @override
  String get incorrectPassword => 'Contraseña incorrecta';

  @override
  String get saveFailed => 'Error al guardar';

  @override
  String savedTo(String path) {
    return 'Guardado en: $path';
  }

  @override
  String get noOriginalPdfStored => 'No hay PDF original almacenado';

  @override
  String get waitingForFolderPermission =>
      'Esperando permiso de acceso a la carpeta...';

  @override
  String get emptyRecentFiles => 'Abre un archivo para empezar';

  @override
  String get imagesTitle => 'Imágenes';

  @override
  String get noImagesYet => 'Sin imágenes';

  @override
  String get noImagesHint => 'Toca + para agregar tu primer sello o firma';

  @override
  String get done => 'Listo';

  @override
  String get menuEdit => 'Editar';

  @override
  String get chooseFromFiles => 'Elegir de archivos';

  @override
  String get chooseFromGallery => 'Elegir de galería';

  @override
  String get imageTooBig => 'La imagen es demasiado grande (máx. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'La resolución es demasiado alta (máx. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Formato de imagen no compatible';

  @override
  String get deleteTooltip => 'Eliminar';

  @override
  String get shareTooltip => 'Compartir';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Página $currentPage de $totalPages';
  }

  @override
  String get noDocumentLoaded => 'No hay documento cargado';

  @override
  String get failedToLoadPdf => 'No se pudo cargar el PDF';

  @override
  String get passwordRequired => 'Contraseña requerida';

  @override
  String get pdfPasswordProtected => 'Este PDF está protegido con contraseña.';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get unsavedChangesTitle => 'Cambios sin guardar';

  @override
  String unsavedChangesMessage(String fileName) {
    return '¿Deseas guardar los cambios en \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Toca para abrir un documento PDF';

  @override
  String get onboardingSwipeUp =>
      'Desliza hacia arriba para agregar firmas y sellos';

  @override
  String get onboardingAddImage => 'Toca para agregar tu primera firma o sello';

  @override
  String get onboardingDragImage => 'Arrastra sobre el PDF para colocarlo';

  @override
  String get onboardingResizeObject =>
      'Toca para seleccionar. Arrastra las esquinas para redimensionar.';

  @override
  String get onboardingDeleteImage =>
      'Toca para eliminar la imagen seleccionada';

  @override
  String get onboardingTapToContinue =>
      'Toca en cualquier lugar para continuar';

  @override
  String get imageConversionFailed => 'Error al convertir la imagen a PDF';

  @override
  String get saveDocumentTitle => 'Guardar documento';

  @override
  String get fileNameLabel => 'Nombre del archivo';

  @override
  String get defaultFileName => 'Documento';

  @override
  String get onlyOnePdfAllowed => 'Solo se puede abrir un PDF a la vez';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'Se ignoraron los archivos PDF. Solo se convierten las imágenes.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imágenes',
      one: 'imagen',
    );
    return 'Convirtiendo $count $_temp0...';
  }

  @override
  String get takePhoto => 'Tomar foto';

  @override
  String get removeBackgroundTitle => '¿Eliminar fondo?';

  @override
  String get removeBackgroundMessage =>
      'Se detectó un fondo uniforme. ¿Deseas hacerlo transparente?';

  @override
  String get removeBackground => 'Eliminar';

  @override
  String get keepOriginal => 'Conservar';

  @override
  String get processingImage => 'Procesando imagen...';

  @override
  String get backgroundRemovalFailed => 'Error al eliminar el fondo';
}
