// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get navHome => 'Inicio';

  @override
  String get navMap => 'Mi Territorio';

  @override
  String get navRun => 'Correr';

  @override
  String get navHistory => 'Historial';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get startRun => 'Iniciar carrera';

  @override
  String get myStats => 'Mis estadísticas';

  @override
  String get totalRuns => 'Carreras totales';

  @override
  String totalRunsValue(int count) {
    return '$count carreras';
  }

  @override
  String get totalDistance => 'Distancia total';

  @override
  String get totalArea => 'Territorio reclamado';

  @override
  String get statsLoadFailed => 'Error al cargar estadísticas';

  @override
  String get noRunsYet =>
      'Aún no hay carreras.\n¡Empieza a correr para reclamar territorio!';

  @override
  String errorMessage(Object error) {
    return 'Error: $error';
  }

  @override
  String get territoryColor => 'Color del territorio';

  @override
  String get customColor => 'Personalizado';

  @override
  String get customColorTitle => 'Elige un color';

  @override
  String get cancel => 'Cancelar';

  @override
  String get select => 'Seleccionar';

  @override
  String get version => 'Versión';

  @override
  String get pause => 'Pausar';

  @override
  String get resume => 'Reanudar';

  @override
  String get stop => 'Detener';

  @override
  String get endRunTitle => 'Finalizar carrera';

  @override
  String get endRunMessage => '¿Finalizar carrera y guardar territorio?';

  @override
  String get save => 'Guardar';

  @override
  String get distance => 'Distancia';

  @override
  String get time => 'Tiempo';

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
  String get planFree => 'Gratis';

  @override
  String get planPro => 'Pro';

  @override
  String get upgradeToPro => 'Actualizar a Pro';

  @override
  String get proFeatures => 'Funciones Pro';

  @override
  String get proFeatureMultiplayer => 'Mapa multijugador';

  @override
  String get proFeatureMultiplayerDesc =>
      'Ve los territorios de otros jugadores en tiempo real';

  @override
  String get proFeatureLeaderboard => 'Clasificación';

  @override
  String get proFeatureLeaderboardDesc =>
      'Compite globalmente por área de territorio';

  @override
  String get proFeatureCloudSync => 'Sincronización en la nube';

  @override
  String get proFeatureCloudSyncDesc =>
      'Haz copia de seguridad en todos tus dispositivos';

  @override
  String get proFeatureFriends => 'Amigos';

  @override
  String get proFeatureFriendsDesc => 'Desafía a amigos y ve sus territorios';

  @override
  String get proPrice => 'Desbloquear Pro — 4,99 € (pago único)';

  @override
  String get proUpgradeConfirmTitle => '¿Actualizar a Pro?';

  @override
  String get proUpgradeConfirmMessage =>
      'Esta es una compra simulada. Toca Confirmar para desbloquear todas las funciones Pro.';

  @override
  String get confirm => 'Confirmar';

  @override
  String get proUnlocked =>
      '¡Pro desbloqueado! Disfruta de todas las funciones.';

  @override
  String get proAlreadyOwned => 'Ya tienes Pro.';

  @override
  String get proLockedHint => 'Función Pro — toca para actualizar';

  @override
  String get currentPlan => 'Plan actual';

  @override
  String get territoryClaimed => '¡Territorio reclamado!';

  @override
  String get areaLabel => 'Área';

  @override
  String get done => 'Listo';

  @override
  String get loopCompleted => '¡Vuelta completada!';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get termsOfUse => 'Términos de uso';
}
