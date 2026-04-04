// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navMap => 'My Territory';

  @override
  String get navRun => 'Run';

  @override
  String get navHistory => 'History';

  @override
  String get navSettings => 'Settings';

  @override
  String get startRun => 'Start Run';

  @override
  String get myStats => 'My Stats';

  @override
  String get totalRuns => 'Total Runs';

  @override
  String totalRunsValue(int count) {
    return '$count runs';
  }

  @override
  String get totalDistance => 'Total Distance';

  @override
  String get totalArea => 'Territory Claimed';

  @override
  String get statsLoadFailed => 'Failed to load stats';

  @override
  String get noRunsYet => 'No runs yet.\nStart running to claim territory!';

  @override
  String errorMessage(Object error) {
    return 'Error: $error';
  }

  @override
  String get territoryColor => 'Territory Color';

  @override
  String get customColor => 'Custom';

  @override
  String get customColorTitle => 'Pick a Color';

  @override
  String get cancel => 'Cancel';

  @override
  String get select => 'Select';

  @override
  String get version => 'Version';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Resume';

  @override
  String get stop => 'Stop';

  @override
  String get endRunTitle => 'End Run';

  @override
  String get endRunMessage => 'End run and save territory?';

  @override
  String get save => 'Save';

  @override
  String get distance => 'Distance';

  @override
  String get time => 'Time';

  @override
  String get pace => 'Pace';

  @override
  String get unitSystem => 'Unit System';

  @override
  String get metric => 'Metric (km, m)';

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
  String get upgradeToPro => 'Upgrade to Pro';

  @override
  String get proFeatures => 'Pro Features';

  @override
  String get proFeatureMultiplayer => 'Multiplayer Map';

  @override
  String get proFeatureMultiplayerDesc =>
      'See other players\' territories in real time';

  @override
  String get proFeatureLeaderboard => 'Leaderboards';

  @override
  String get proFeatureLeaderboardDesc =>
      'Compete globally and rank by territory area';

  @override
  String get proFeatureCloudSync => 'Cloud Sync';

  @override
  String get proFeatureCloudSyncDesc =>
      'Back up your runs and territories across devices';

  @override
  String get proFeatureFriends => 'Friends';

  @override
  String get proFeatureFriendsDesc =>
      'Challenge friends and see their territories';

  @override
  String get proPrice => 'Unlock Pro — \$4.99 (one-time)';

  @override
  String get proUpgradeConfirmTitle => 'Upgrade to Pro?';

  @override
  String get proUpgradeConfirmMessage =>
      'This is a simulated purchase. Tap Confirm to unlock all Pro features.';

  @override
  String get confirm => 'Confirm';

  @override
  String get proUnlocked => 'Pro unlocked! Enjoy all features.';

  @override
  String get proAlreadyOwned => 'You already own Pro.';

  @override
  String get proLockedHint => 'Pro feature — tap to upgrade';

  @override
  String get currentPlan => 'Current Plan';

  @override
  String get territoryClaimed => 'Territory Claimed!';

  @override
  String get areaLabel => 'Area';

  @override
  String get done => 'Done';

  @override
  String get loopCompleted => 'Loop Completed!';
}
