// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get navHome => 'Start';

  @override
  String get navMap => 'Mein Revier';

  @override
  String get navRun => 'Laufen';

  @override
  String get navHistory => 'Verlauf';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get startRun => 'Lauf starten';

  @override
  String get myStats => 'Meine Statistiken';

  @override
  String get totalRuns => 'Gesamte Läufe';

  @override
  String totalRunsValue(int count) {
    return '$count Läufe';
  }

  @override
  String get totalDistance => 'Gesamtdistanz';

  @override
  String get totalArea => 'Gewonnenes Gebiet';

  @override
  String get statsLoadFailed => 'Statistiken konnten nicht geladen werden';

  @override
  String get noRunsYet => 'Noch keine Läufe.\nLauf los und erobere Gebiete!';

  @override
  String errorMessage(Object error) {
    return 'Fehler: $error';
  }

  @override
  String get territoryColor => 'Gebietsfarbe';

  @override
  String get customColor => 'Benutzerdefiniert';

  @override
  String get customColorTitle => 'Farbe auswählen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get select => 'Auswählen';

  @override
  String get version => 'Version';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Fortsetzen';

  @override
  String get stop => 'Stopp';

  @override
  String get endRunTitle => 'Lauf beenden';

  @override
  String get endRunMessage => 'Lauf beenden und Gebiet speichern?';

  @override
  String get save => 'Speichern';

  @override
  String get distance => 'Distanz';

  @override
  String get time => 'Zeit';

  @override
  String get pace => 'Tempo';

  @override
  String get unitSystem => 'Einheitensystem';

  @override
  String get metric => 'Metrisch (km, m)';

  @override
  String get imperial => 'Imperial (mi, ft)';

  @override
  String get paceUnit => 'min/km';

  @override
  String get paceUnitImperial => 'min/mi';

  @override
  String get planFree => 'Free';

  @override
  String get planPro => 'Pro';

  @override
  String get upgradeToPro => 'Auf Pro upgraden';

  @override
  String get proFeatures => 'Pro-Funktionen';

  @override
  String get proFeatureMultiplayer => 'Multiplayer-Karte';

  @override
  String get proFeatureMultiplayerDesc =>
      'Gebiete anderer Spieler in Echtzeit sehen';

  @override
  String get proFeatureLeaderboard => 'Bestenliste';

  @override
  String get proFeatureLeaderboardDesc => 'Global nach Gebietsfläche ranken';

  @override
  String get proFeatureCloudSync => 'Cloud-Synchronisation';

  @override
  String get proFeatureCloudSyncDesc =>
      'Läufe und Gebiete geräteübergreifend sichern';

  @override
  String get proFeatureFriends => 'Freunde';

  @override
  String get proFeatureFriendsDesc => 'Mit Freunden um Gebiete konkurrieren';

  @override
  String get proPrice => 'Pro freischalten — 4,99 € (einmalig)';

  @override
  String get proUpgradeConfirmTitle => 'Auf Pro upgraden?';

  @override
  String get proUpgradeConfirmMessage =>
      'Dies ist ein simulierter Kauf. Bestätigen zum Freischalten aller Pro-Funktionen.';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get proUnlocked => 'Pro freigeschaltet! Viel Spaß.';

  @override
  String get proAlreadyOwned => 'Du besitzt bereits Pro.';

  @override
  String get proLockedHint => 'Pro-Funktion — tippen zum Upgraden';

  @override
  String get currentPlan => 'Aktueller Plan';

  @override
  String get territoryClaimed => 'Gebiet erobert!';

  @override
  String get areaLabel => 'Fläche';

  @override
  String get done => 'Fertig';

  @override
  String get loopCompleted => 'Runde abgeschlossen!';
}
