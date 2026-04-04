// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get navHome => 'Início';

  @override
  String get navMap => 'Meu Território';

  @override
  String get navRun => 'Correr';

  @override
  String get navHistory => 'Histórico';

  @override
  String get navSettings => 'Configurações';

  @override
  String get startRun => 'Iniciar corrida';

  @override
  String get myStats => 'Minhas estatísticas';

  @override
  String get totalRuns => 'Total de corridas';

  @override
  String totalRunsValue(int count) {
    return '$count corridas';
  }

  @override
  String get totalDistance => 'Distância total';

  @override
  String get totalArea => 'Território conquistado';

  @override
  String get statsLoadFailed => 'Falha ao carregar estatísticas';

  @override
  String get noRunsYet =>
      'Nenhuma corrida ainda.\nComece a correr para conquistar território!';

  @override
  String errorMessage(Object error) {
    return 'Erro: $error';
  }

  @override
  String get territoryColor => 'Cor do território';

  @override
  String get customColor => 'Personalizado';

  @override
  String get customColorTitle => 'Escolher cor';

  @override
  String get cancel => 'Cancelar';

  @override
  String get select => 'Selecionar';

  @override
  String get version => 'Versão';

  @override
  String get pause => 'Pausar';

  @override
  String get resume => 'Retomar';

  @override
  String get stop => 'Parar';

  @override
  String get endRunTitle => 'Encerrar corrida';

  @override
  String get endRunMessage => 'Encerrar corrida e salvar território?';

  @override
  String get save => 'Salvar';

  @override
  String get distance => 'Distância';

  @override
  String get time => 'Tempo';

  @override
  String get pace => 'Ritmo';

  @override
  String get unitSystem => 'Sistema de unidades';

  @override
  String get metric => 'Métrico (km, m)';

  @override
  String get imperial => 'Imperial (mi, ft)';

  @override
  String get paceUnit => 'min/km';

  @override
  String get paceUnitImperial => 'min/mi';

  @override
  String get planFree => 'Grátis';

  @override
  String get planPro => 'Pro';

  @override
  String get upgradeToPro => 'Atualizar para Pro';

  @override
  String get proFeatures => 'Recursos Pro';

  @override
  String get proFeatureMultiplayer => 'Mapa multijogador';

  @override
  String get proFeatureMultiplayerDesc =>
      'Veja os territórios de outros jogadores em tempo real';

  @override
  String get proFeatureLeaderboard => 'Classificação';

  @override
  String get proFeatureLeaderboardDesc =>
      'Compete globalmente por área de território';

  @override
  String get proFeatureCloudSync => 'Sincronização na nuvem';

  @override
  String get proFeatureCloudSyncDesc =>
      'Faça backup das corridas e territórios entre dispositivos';

  @override
  String get proFeatureFriends => 'Amigos';

  @override
  String get proFeatureFriendsDesc => 'Desafie amigos e veja seus territórios';

  @override
  String get proPrice => 'Desbloquear Pro — R\$ 24,90 (pagamento único)';

  @override
  String get proUpgradeConfirmTitle => 'Atualizar para Pro?';

  @override
  String get proUpgradeConfirmMessage =>
      'Esta é uma compra simulada. Toque em Confirmar para desbloquear todos os recursos Pro.';

  @override
  String get confirm => 'Confirmar';

  @override
  String get proUnlocked => 'Pro desbloqueado! Aproveite todos os recursos.';

  @override
  String get proAlreadyOwned => 'Você já possui o Pro.';

  @override
  String get proLockedHint => 'Recurso Pro — toque para atualizar';

  @override
  String get currentPlan => 'Plano atual';

  @override
  String get territoryClaimed => 'Território conquistado!';

  @override
  String get areaLabel => 'Área';

  @override
  String get done => 'Concluído';

  @override
  String get loopCompleted => 'Volta concluída!';

  @override
  String get privacyPolicy => 'Política de privacidade';

  @override
  String get termsOfUse => 'Termos de uso';
}
