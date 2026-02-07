// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get selectPdf => 'Abrir arquivo';

  @override
  String get untitledDocument => 'Sem título.pdf';

  @override
  String get recentFiles => 'Arquivos recentes';

  @override
  String get removeFromList => 'Remover da lista';

  @override
  String get openedNow => 'Aberto agora';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutos',
      one: 'minuto',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'horas',
      one: 'hora',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String get openedYesterday => 'Aberto ontem';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dias',
      one: 'dia',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String get fileNotFound => 'Arquivo não encontrado';

  @override
  String get fileAccessDenied => 'Acesso negado';

  @override
  String get clearRecentFiles => 'Limpar arquivos recentes';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get error => 'Erro';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Arquivo';

  @override
  String get menuOpen => 'Abrir...';

  @override
  String get menuOpenRecent => 'Abrir recentes';

  @override
  String get menuNoRecentFiles => 'Nenhum arquivo recente';

  @override
  String get menuClearMenu => 'Limpar menu';

  @override
  String get menuSave => 'Salvar';

  @override
  String get menuSaveAs => 'Salvar como...';

  @override
  String get menuSaveAll => 'Salvar tudo';

  @override
  String get menuShare => 'Compartilhar...';

  @override
  String get menuCloseWindow => 'Fechar janela';

  @override
  String get menuCloseAll => 'Fechar tudo';

  @override
  String get menuQuit => 'Sair do PDFSign';

  @override
  String get closeAllDialogTitle => 'Salvar alterações?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Deseja salvar as alterações em $count documentos antes de fechar?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Deseja salvar as alterações em 1 documento antes de fechar?';

  @override
  String get closeAllDialogSaveAll => 'Salvar tudo';

  @override
  String get closeAllDialogDontSave => 'Não salvar';

  @override
  String get closeAllDialogCancel => 'Cancelar';

  @override
  String get saveFailedDialogTitle => 'Falha ao salvar';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Falha ao salvar $count documento(s). Fechar mesmo assim?';
  }

  @override
  String get saveFailedDialogClose => 'Fechar mesmo assim';

  @override
  String get saveChangesTitle => 'Salvar alterações?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Deseja salvar as alterações em \"$fileName\" antes de fechar?';
  }

  @override
  String get saveButton => 'Salvar';

  @override
  String get discardButton => 'Não salvar';

  @override
  String get documentEdited => 'Editado';

  @override
  String get documentSaved => 'Salvo';

  @override
  String get menuSettings => 'Configurações...';

  @override
  String get menuWindow => 'Janela';

  @override
  String get menuMinimize => 'Minimizar';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Trazer Tudo para a Frente';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Padrão do sistema';

  @override
  String get settingsUnits => 'Unidades';

  @override
  String get settingsUnitsCentimeters => 'Centímetros';

  @override
  String get settingsUnitsInches => 'Polegadas';

  @override
  String get settingsUnitsDefault => 'Padrão (por região)';

  @override
  String get settingsSearchLanguages => 'Pesquisar idiomas...';

  @override
  String get settingsGeneral => 'Geral';

  @override
  String get addImage => 'Adicionar imagem';

  @override
  String get selectImages => 'Selecionar imagens';

  @override
  String get zoomFitWidth => 'Ajustar largura';

  @override
  String get zoomIn => 'Aumentar zoom';

  @override
  String get zoomOut => 'Diminuir zoom';

  @override
  String get selectZoomLevel => 'Selecionar nível de zoom';

  @override
  String get goToPage => 'Ir para página';

  @override
  String get go => 'Ir';

  @override
  String get savePdfAs => 'Salvar PDF como';

  @override
  String get incorrectPassword => 'Senha incorreta';

  @override
  String get saveFailed => 'Falha ao salvar';

  @override
  String savedTo(String path) {
    return 'Salvo em: $path';
  }

  @override
  String get noOriginalPdfStored => 'Nenhum PDF original armazenado';

  @override
  String get waitingForFolderPermission =>
      'Aguardando permissão de acesso à pasta...';

  @override
  String get emptyRecentFiles => 'Abra um arquivo para começar';

  @override
  String get imagesTitle => 'Imagens';

  @override
  String get noImagesYet => 'Sem imagens';

  @override
  String get noImagesHint =>
      'Toque em + para adicionar seu primeiro carimbo ou assinatura';

  @override
  String get done => 'Concluído';

  @override
  String get menuEdit => 'Editar';

  @override
  String get chooseFromFiles => 'Escolher de ficheiros';

  @override
  String get chooseFromGallery => 'Escolher da galeria';

  @override
  String get imageTooBig => 'A imagem é demasiado grande (máx. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'A resolução é demasiado alta (máx. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Formato de imagem não suportado';

  @override
  String get deleteTooltip => 'Eliminar';

  @override
  String get shareTooltip => 'Partilhar';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Página $currentPage de $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Nenhum documento carregado';

  @override
  String get failedToLoadPdf => 'Falha ao carregar o PDF';

  @override
  String get passwordRequired => 'Palavra-passe necessária';

  @override
  String get pdfPasswordProtected =>
      'Este PDF está protegido por palavra-passe.';

  @override
  String errorWithMessage(String message) {
    return 'Erro: $message';
  }

  @override
  String get unsavedChangesTitle => 'Alterações não guardadas';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Deseja guardar as alterações em \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Toque para abrir um documento PDF';

  @override
  String get onboardingSwipeUp =>
      'Deslize para cima para adicionar assinaturas e carimbos';

  @override
  String get onboardingAddImage =>
      'Toque para adicionar a sua primeira assinatura ou carimbo';

  @override
  String get onboardingDragImage => 'Arraste para o PDF para colocar';

  @override
  String get onboardingResizeObject =>
      'Toque para selecionar. Arraste os cantos para redimensionar.';

  @override
  String get onboardingDeleteImage => 'Toque para excluir a imagem selecionada';

  @override
  String get onboardingTapToContinue =>
      'Toque em qualquer lugar para continuar';

  @override
  String get imageConversionFailed => 'Falha ao converter imagem para PDF';

  @override
  String get saveDocumentTitle => 'Guardar documento';

  @override
  String get fileNameLabel => 'Nome do ficheiro';

  @override
  String get defaultFileName => 'Documento';

  @override
  String get onlyOnePdfAllowed => 'Só é possível abrir um PDF de cada vez';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'Os ficheiros PDF foram ignorados. Apenas as imagens são convertidas.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imagens',
      one: 'imagem',
    );
    return 'Convertendo $count $_temp0...';
  }

  @override
  String get takePhoto => 'Tirar foto';

  @override
  String get removeBackgroundTitle => 'Remover fundo?';

  @override
  String get removeBackgroundMessage =>
      'Foi detetado um fundo uniforme. Deseja torná-lo transparente?';

  @override
  String get removeBackground => 'Remover';

  @override
  String get keepOriginal => 'Manter';

  @override
  String get processingImage => 'A processar imagem...';

  @override
  String get backgroundRemovalFailed => 'Falha ao remover o fundo';

  @override
  String get passwordLabel => 'Palavra-passe';

  @override
  String get unlockButton => 'Desbloquear';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get selectPdf => 'Abrir arquivo';

  @override
  String get untitledDocument => 'Sem título.pdf';

  @override
  String get recentFiles => 'Arquivos recentes';

  @override
  String get removeFromList => 'Remover da lista';

  @override
  String get openedNow => 'Aberto agora';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutos',
      one: 'minuto',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'horas',
      one: 'hora',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String get openedYesterday => 'Aberto ontem';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dias',
      one: 'dia',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String get fileNotFound => 'Arquivo não encontrado';

  @override
  String get fileAccessDenied => 'Acesso negado';

  @override
  String get clearRecentFiles => 'Limpar arquivos recentes';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get error => 'Erro';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Arquivo';

  @override
  String get menuOpen => 'Abrir...';

  @override
  String get menuOpenRecent => 'Abrir recentes';

  @override
  String get menuNoRecentFiles => 'Nenhum arquivo recente';

  @override
  String get menuClearMenu => 'Limpar menu';

  @override
  String get menuSave => 'Salvar';

  @override
  String get menuSaveAs => 'Salvar como...';

  @override
  String get menuSaveAll => 'Salvar tudo';

  @override
  String get menuShare => 'Compartilhar...';

  @override
  String get menuCloseWindow => 'Fechar janela';

  @override
  String get menuCloseAll => 'Fechar tudo';

  @override
  String get menuQuit => 'Sair do PDFSign';

  @override
  String get closeAllDialogTitle => 'Salvar alterações?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Deseja salvar as alterações em $count documentos antes de fechar?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Deseja salvar as alterações em 1 documento antes de fechar?';

  @override
  String get closeAllDialogSaveAll => 'Salvar tudo';

  @override
  String get closeAllDialogDontSave => 'Não salvar';

  @override
  String get closeAllDialogCancel => 'Cancelar';

  @override
  String get saveFailedDialogTitle => 'Falha ao salvar';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Falha ao salvar $count documento(s). Fechar mesmo assim?';
  }

  @override
  String get saveFailedDialogClose => 'Fechar mesmo assim';

  @override
  String get saveChangesTitle => 'Salvar alterações?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Deseja salvar as alterações em \"$fileName\" antes de fechar?';
  }

  @override
  String get saveButton => 'Salvar';

  @override
  String get discardButton => 'Não salvar';

  @override
  String get documentEdited => 'Editado';

  @override
  String get documentSaved => 'Salvo';

  @override
  String get menuSettings => 'Configurações...';

  @override
  String get menuWindow => 'Janela';

  @override
  String get menuMinimize => 'Minimizar';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Trazer Tudo para a Frente';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Padrão do sistema';

  @override
  String get settingsUnits => 'Unidades';

  @override
  String get settingsUnitsCentimeters => 'Centímetros';

  @override
  String get settingsUnitsInches => 'Polegadas';

  @override
  String get settingsUnitsDefault => 'Padrão (por região)';

  @override
  String get settingsSearchLanguages => 'Pesquisar idiomas...';

  @override
  String get settingsGeneral => 'Geral';

  @override
  String get addImage => 'Adicionar imagem';

  @override
  String get selectImages => 'Selecionar imagens';

  @override
  String get zoomFitWidth => 'Ajustar largura';

  @override
  String get zoomIn => 'Aumentar zoom';

  @override
  String get zoomOut => 'Diminuir zoom';

  @override
  String get selectZoomLevel => 'Selecionar nível de zoom';

  @override
  String get goToPage => 'Ir para página';

  @override
  String get go => 'Ir';

  @override
  String get savePdfAs => 'Salvar PDF como';

  @override
  String get incorrectPassword => 'Senha incorreta';

  @override
  String get saveFailed => 'Falha ao salvar';

  @override
  String savedTo(String path) {
    return 'Salvo em: $path';
  }

  @override
  String get noOriginalPdfStored => 'Nenhum PDF original armazenado';

  @override
  String get waitingForFolderPermission =>
      'Aguardando permissão de acesso à pasta...';

  @override
  String get emptyRecentFiles => 'Abra um arquivo para começar';

  @override
  String get imagesTitle => 'Imagens';

  @override
  String get noImagesYet => 'Sem imagens';

  @override
  String get noImagesHint =>
      'Toque em + para adicionar seu primeiro carimbo ou assinatura';

  @override
  String get done => 'Concluído';

  @override
  String get menuEdit => 'Editar';

  @override
  String get chooseFromFiles => 'Escolher de arquivos';

  @override
  String get chooseFromGallery => 'Escolher da galeria';

  @override
  String get imageTooBig => 'A imagem é muito grande (máx. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'A resolução é muito alta (máx. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Formato de imagem não suportado';

  @override
  String get deleteTooltip => 'Excluir';

  @override
  String get shareTooltip => 'Compartilhar';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Página $currentPage de $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Nenhum documento carregado';

  @override
  String get failedToLoadPdf => 'Falha ao carregar PDF';

  @override
  String get passwordRequired => 'Senha necessária';

  @override
  String get pdfPasswordProtected => 'Este PDF está protegido por senha.';

  @override
  String errorWithMessage(String message) {
    return 'Erro: $message';
  }

  @override
  String get unsavedChangesTitle => 'Alterações não salvas';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Deseja salvar as alterações em \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Toque para abrir um documento PDF';

  @override
  String get onboardingSwipeUp =>
      'Deslize para cima para adicionar assinaturas e carimbos';

  @override
  String get onboardingAddImage =>
      'Toque para adicionar sua primeira assinatura ou carimbo';

  @override
  String get onboardingDragImage => 'Arraste para o PDF para posicioná-lo';

  @override
  String get onboardingResizeObject =>
      'Toque para selecionar. Arraste os cantos para redimensionar.';

  @override
  String get onboardingDeleteImage => 'Toque para excluir a imagem selecionada';

  @override
  String get onboardingTapToContinue =>
      'Toque em qualquer lugar para continuar';

  @override
  String get imageConversionFailed => 'Falha ao converter imagem para PDF';

  @override
  String get saveDocumentTitle => 'Salvar documento';

  @override
  String get fileNameLabel => 'Nome do arquivo';

  @override
  String get defaultFileName => 'Documento';

  @override
  String get onlyOnePdfAllowed => 'Só é possível abrir um PDF por vez';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'Os arquivos PDF foram ignorados. Apenas as imagens são convertidas.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imagens',
      one: 'imagem',
    );
    return 'Convertendo $count $_temp0...';
  }

  @override
  String get takePhoto => 'Tirar foto';

  @override
  String get removeBackgroundTitle => 'Remover fundo?';

  @override
  String get removeBackgroundMessage =>
      'Foi detectado um fundo uniforme. Deseja torná-lo transparente?';

  @override
  String get removeBackground => 'Remover';

  @override
  String get keepOriginal => 'Manter';

  @override
  String get processingImage => 'Processando imagem...';

  @override
  String get backgroundRemovalFailed => 'Falha ao remover o fundo';

  @override
  String get passwordLabel => 'Senha';

  @override
  String get unlockButton => 'Desbloquear';
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationsPtPt extends AppLocalizationsPt {
  AppLocalizationsPtPt() : super('pt_PT');

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get selectPdf => 'Abrir ficheiro';

  @override
  String get untitledDocument => 'Sem título.pdf';

  @override
  String get recentFiles => 'Ficheiros recentes';

  @override
  String get removeFromList => 'Remover da lista';

  @override
  String get openedNow => 'Aberto agora';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutos',
      one: 'minuto',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'horas',
      one: 'hora',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String get openedYesterday => 'Aberto ontem';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dias',
      one: 'dia',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String get fileNotFound => 'Ficheiro não encontrado';

  @override
  String get fileAccessDenied => 'Acesso negado';

  @override
  String get clearRecentFiles => 'Limpar ficheiros recentes';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get error => 'Erro';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Ficheiro';

  @override
  String get menuOpen => 'Abrir...';

  @override
  String get menuOpenRecent => 'Abrir recentes';

  @override
  String get menuNoRecentFiles => 'Sem ficheiros recentes';

  @override
  String get menuClearMenu => 'Limpar menu';

  @override
  String get menuSave => 'Guardar';

  @override
  String get menuSaveAs => 'Guardar como...';

  @override
  String get menuSaveAll => 'Salvar tudo';

  @override
  String get menuShare => 'Partilhar...';

  @override
  String get menuCloseWindow => 'Fechar janela';

  @override
  String get menuCloseAll => 'Fechar tudo';

  @override
  String get menuQuit => 'Sair do PDFSign';

  @override
  String get closeAllDialogTitle => 'Guardar alterações?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Deseja guardar as alterações em $count documentos antes de fechar?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Deseja guardar as alterações em 1 documento antes de fechar?';

  @override
  String get closeAllDialogSaveAll => 'Guardar tudo';

  @override
  String get closeAllDialogDontSave => 'Não guardar';

  @override
  String get closeAllDialogCancel => 'Cancelar';

  @override
  String get saveFailedDialogTitle => 'Falha ao salvar';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Falha ao salvar $count documento(s). Fechar mesmo assim?';
  }

  @override
  String get saveFailedDialogClose => 'Fechar mesmo assim';

  @override
  String get saveChangesTitle => 'Guardar alterações?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Deseja guardar as alterações em \"$fileName\" antes de fechar?';
  }

  @override
  String get saveButton => 'Guardar';

  @override
  String get discardButton => 'Não guardar';

  @override
  String get documentEdited => 'Editado';

  @override
  String get documentSaved => 'Guardado';

  @override
  String get menuSettings => 'Definições...';

  @override
  String get menuWindow => 'Janela';

  @override
  String get menuMinimize => 'Minimizar';

  @override
  String get menuZoom => 'Ampliação';

  @override
  String get menuBringAllToFront => 'Trazer Tudo para a Frente';

  @override
  String get settingsTitle => 'Definições';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Predefinição do sistema';

  @override
  String get settingsUnits => 'Unidades';

  @override
  String get settingsUnitsCentimeters => 'Centímetros';

  @override
  String get settingsUnitsInches => 'Polegadas';

  @override
  String get settingsUnitsDefault => 'Padrão (por região)';

  @override
  String get settingsSearchLanguages => 'Pesquisar idiomas...';

  @override
  String get settingsGeneral => 'Geral';

  @override
  String get addImage => 'Adicionar imagem';

  @override
  String get selectImages => 'Selecionar imagens';

  @override
  String get zoomFitWidth => 'Ajustar largura';

  @override
  String get zoomIn => 'Aumentar';

  @override
  String get zoomOut => 'Diminuir';

  @override
  String get selectZoomLevel => 'Selecionar nível de zoom';

  @override
  String get goToPage => 'Ir para página';

  @override
  String get go => 'Ir';

  @override
  String get savePdfAs => 'Guardar PDF como';

  @override
  String get incorrectPassword => 'Palavra-passe incorreta';

  @override
  String get saveFailed => 'Falha ao guardar';

  @override
  String savedTo(String path) {
    return 'Guardado em: $path';
  }

  @override
  String get noOriginalPdfStored => 'Nenhum PDF original armazenado';

  @override
  String get waitingForFolderPermission =>
      'Aguardando permissão de acesso à pasta...';

  @override
  String get emptyRecentFiles => 'Abra um ficheiro para começar';

  @override
  String get imagesTitle => 'Imagens';

  @override
  String get noImagesYet => 'Sem imagens';

  @override
  String get noImagesHint =>
      'Toque em + para adicionar o seu primeiro carimbo ou assinatura';

  @override
  String get done => 'Concluído';

  @override
  String get menuEdit => 'Editar';

  @override
  String get chooseFromFiles => 'Escolher de ficheiros';

  @override
  String get chooseFromGallery => 'Escolher da galeria';

  @override
  String get imageTooBig => 'A imagem é demasiado grande (máx. 50 MB)';

  @override
  String get imageResolutionTooHigh =>
      'A resolução é demasiado alta (máx. 4096×4096)';

  @override
  String get unsupportedImageFormat => 'Formato de imagem não suportado';

  @override
  String get deleteTooltip => 'Eliminar';

  @override
  String get shareTooltip => 'Partilhar';

  @override
  String pageIndicator(int currentPage, int totalPages) {
    return 'Página $currentPage de $totalPages';
  }

  @override
  String get noDocumentLoaded => 'Nenhum documento carregado';

  @override
  String get failedToLoadPdf => 'Falha ao carregar PDF';

  @override
  String get passwordRequired => 'Palavra-passe necessária';

  @override
  String get pdfPasswordProtected =>
      'Este PDF está protegido por palavra-passe.';

  @override
  String errorWithMessage(String message) {
    return 'Erro: $message';
  }

  @override
  String get unsavedChangesTitle => 'Alterações não guardadas';

  @override
  String unsavedChangesMessage(String fileName) {
    return 'Deseja guardar as alterações em \"$fileName\"?';
  }

  @override
  String get onboardingOpenPdf => 'Toque para abrir um documento PDF';

  @override
  String get onboardingSwipeUp =>
      'Deslize para cima para adicionar assinaturas e carimbos';

  @override
  String get onboardingAddImage =>
      'Toque para adicionar a sua primeira assinatura ou carimbo';

  @override
  String get onboardingDragImage => 'Arraste para o PDF para o posicionar';

  @override
  String get onboardingResizeObject =>
      'Toque para selecionar. Arraste os cantos para redimensionar.';

  @override
  String get onboardingDeleteImage =>
      'Toque para eliminar a imagem selecionada';

  @override
  String get onboardingTapToContinue =>
      'Toque em qualquer lugar para continuar';

  @override
  String get imageConversionFailed => 'Falha ao converter imagem para PDF';

  @override
  String get saveDocumentTitle => 'Guardar documento';

  @override
  String get fileNameLabel => 'Nome do ficheiro';

  @override
  String get defaultFileName => 'Documento';

  @override
  String get onlyOnePdfAllowed => 'Só é possível abrir um PDF de cada vez';

  @override
  String get pdfsIgnoredInMixedSelection =>
      'Os ficheiros PDF foram ignorados. Apenas as imagens são convertidas.';

  @override
  String convertingImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imagens',
      one: 'imagem',
    );
    return 'A converter $count $_temp0...';
  }

  @override
  String get takePhoto => 'Tirar fotografia';

  @override
  String get removeBackgroundTitle => 'Remover fundo?';

  @override
  String get removeBackgroundMessage =>
      'Foi detetado um fundo uniforme. Deseja torná-lo transparente?';

  @override
  String get removeBackground => 'Remover';

  @override
  String get keepOriginal => 'Manter';

  @override
  String get processingImage => 'A processar imagem...';

  @override
  String get backgroundRemovalFailed => 'Falha ao remover o fundo';

  @override
  String get passwordLabel => 'Palavra-passe';

  @override
  String get unlockButton => 'Desbloquear';
}
