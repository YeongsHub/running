// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navMap => 'Il mio territorio';

  @override
  String get navRun => 'Corri';

  @override
  String get navHistory => 'Cronologia';

  @override
  String get navSettings => 'Impostazioni';

  @override
  String get startRun => 'Inizia corsa';

  @override
  String get myStats => 'Le mie statistiche';

  @override
  String get totalRuns => 'Corse totali';

  @override
  String totalRunsValue(int count) {
    return '$count corse';
  }

  @override
  String get totalDistance => 'Distanza totale';

  @override
  String get totalArea => 'Territorio conquistato';

  @override
  String get statsLoadFailed => 'Impossibile caricare le statistiche';

  @override
  String get noRunsYet =>
      'Nessuna corsa ancora.\nInizia a correre per conquistare territorio!';

  @override
  String errorMessage(Object error) {
    return 'Errore: $error';
  }

  @override
  String get territoryColor => 'Colore del territorio';

  @override
  String get customColor => 'Personalizzato';

  @override
  String get customColorTitle => 'Scegli un colore';

  @override
  String get cancel => 'Annulla';

  @override
  String get select => 'Seleziona';

  @override
  String get version => 'Versione';

  @override
  String get pause => 'Pausa';

  @override
  String get resume => 'Riprendi';

  @override
  String get stop => 'Ferma';

  @override
  String get endRunTitle => 'Termina corsa';

  @override
  String get endRunMessage => 'Terminare la corsa e salvare il territorio?';

  @override
  String get save => 'Salva';

  @override
  String get distance => 'Distanza';

  @override
  String get time => 'Tempo';

  @override
  String get pace => 'Passo';

  @override
  String get unitSystem => 'Sistema di unità';

  @override
  String get metric => 'Metrico (km, m)';

  @override
  String get imperial => 'Imperiale (mi, ft)';

  @override
  String get paceUnit => 'min/km';

  @override
  String get paceUnitImperial => 'min/mi';

  @override
  String get planFree => 'Gratuito';

  @override
  String get planPro => 'Pro';

  @override
  String get upgradeToPro => 'Passa a Pro';

  @override
  String get proFeatures => 'Funzionalità Pro';

  @override
  String get proFeatureMultiplayer => 'Mappa multiplayer';

  @override
  String get proFeatureMultiplayerDesc =>
      'Vedi i territori degli altri giocatori in tempo reale';

  @override
  String get proFeatureLeaderboard => 'Classifica';

  @override
  String get proFeatureLeaderboardDesc =>
      'Compete globalmente per area di territorio';

  @override
  String get proFeatureCloudSync => 'Sincronizzazione cloud';

  @override
  String get proFeatureCloudSyncDesc =>
      'Backup di corse e territori su tutti i tuoi dispositivi';

  @override
  String get proFeatureFriends => 'Amici';

  @override
  String get proFeatureFriendsDesc =>
      'Sfida gli amici e guarda i loro territori';

  @override
  String get proPrice => 'Sblocca Pro — 4,99 € (acquisto unico)';

  @override
  String get proUpgradeConfirmTitle => 'Passare a Pro?';

  @override
  String get proUpgradeConfirmMessage =>
      'Questo è un acquisto simulato. Tocca Conferma per sbloccare tutte le funzionalità Pro.';

  @override
  String get confirm => 'Conferma';

  @override
  String get proUnlocked => 'Pro sbloccato! Goditi tutte le funzionalità.';

  @override
  String get proAlreadyOwned => 'Possiedi già Pro.';

  @override
  String get proLockedHint => 'Funzionalità Pro — tocca per passare a Pro';

  @override
  String get currentPlan => 'Piano attuale';

  @override
  String get territoryClaimed => 'Territorio conquistato!';

  @override
  String get areaLabel => 'Area';

  @override
  String get done => 'Fatto';

  @override
  String get loopCompleted => 'Giro completato!';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get termsOfUse => 'Termini di utilizzo';
}
