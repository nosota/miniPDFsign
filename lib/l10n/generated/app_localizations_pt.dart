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
  String get selectPdf => 'Selecionar PDF';

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
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get selectPdf => 'Selecionar PDF';

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
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationsPtPt extends AppLocalizationsPt {
  AppLocalizationsPtPt() : super('pt_PT');

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get selectPdf => 'Selecionar PDF';

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
}
