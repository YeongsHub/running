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
  String get navMap => 'Karte';

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
}
