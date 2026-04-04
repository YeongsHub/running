// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navMap => 'Aking Teritoryo';

  @override
  String get navRun => 'Tumakbo';

  @override
  String get navHistory => 'Kasaysayan';

  @override
  String get navSettings => 'Mga Setting';

  @override
  String get startRun => 'Simulan ang Takbo';

  @override
  String get myStats => 'Aking Estadistika';

  @override
  String get totalRuns => 'Kabuuang Takbo';

  @override
  String totalRunsValue(int count) {
    return '$count beses';
  }

  @override
  String get totalDistance => 'Kabuuang Distansya';

  @override
  String get totalArea => 'Teritoryong Na-claim';

  @override
  String get statsLoadFailed => 'Hindi ma-load ang estadistika';

  @override
  String get noRunsYet =>
      'Wala pang rekord ng takbo.\nTumakbo na para mag-claim ng teritoryo!';

  @override
  String errorMessage(Object error) {
    return 'Error: $error';
  }

  @override
  String get territoryColor => 'Kulay ng Teritoryo';

  @override
  String get customColor => 'Custom';

  @override
  String get customColorTitle => 'Pumili ng Kulay';

  @override
  String get cancel => 'Kanselahin';

  @override
  String get select => 'Piliin';

  @override
  String get version => 'Bersyon';

  @override
  String get pause => 'I-pause';

  @override
  String get resume => 'Ituloy';

  @override
  String get stop => 'Ihinto';

  @override
  String get endRunTitle => 'Tapusin ang Takbo';

  @override
  String get endRunMessage => 'Tapusin at i-save ang teritoryo?';

  @override
  String get save => 'I-save';

  @override
  String get distance => 'Distansya';

  @override
  String get time => 'Oras';

  @override
  String get pace => 'Bilis';

  @override
  String get unitSystem => 'Sistema ng Sukat';

  @override
  String get metric => 'Metric (km, m)';

  @override
  String get imperial => 'Imperial (mi, ft)';

  @override
  String get paceUnit => 'min/km';

  @override
  String get paceUnitImperial => 'min/mi';

  @override
  String get planFree => 'Libre';

  @override
  String get planPro => 'Pro';

  @override
  String get upgradeToPro => 'I-upgrade sa Pro';

  @override
  String get proFeatures => 'Mga Feature ng Pro';

  @override
  String get proFeatureMultiplayer => 'Multiplayer Map';

  @override
  String get proFeatureMultiplayerDesc =>
      'Tingnan ang mga teritoryo ng ibang manlalaro sa real time';

  @override
  String get proFeatureLeaderboard => 'Leaderboard';

  @override
  String get proFeatureLeaderboardDesc =>
      'Makipagsabong sa buong mundo ayon sa laki ng teritoryo';

  @override
  String get proFeatureCloudSync => 'Cloud Sync';

  @override
  String get proFeatureCloudSyncDesc =>
      'I-backup ang mga takbo at teritoryo sa iba\'t ibang device';

  @override
  String get proFeatureFriends => 'Mga Kaibigan';

  @override
  String get proFeatureFriendsDesc =>
      'Hamunin ang mga kaibigan at tingnan ang kanilang teritoryo';

  @override
  String get proPrice => 'I-unlock ang Pro — \$4.99 (isang beses)';

  @override
  String get proUpgradeConfirmTitle => 'I-upgrade sa Pro?';

  @override
  String get proUpgradeConfirmMessage =>
      'Ito ay simulate na pagbili. I-tap ang Kumpirmahin para i-unlock ang lahat ng Pro features.';

  @override
  String get confirm => 'Kumpirmahin';

  @override
  String get proUnlocked =>
      'Naka-unlock na ang Pro! I-enjoy ang lahat ng features.';

  @override
  String get proAlreadyOwned => 'Mayroon ka na ng Pro.';

  @override
  String get proLockedHint => 'Feature ng Pro — i-tap para mag-upgrade';

  @override
  String get currentPlan => 'Kasalukuyang Plano';

  @override
  String get territoryClaimed => 'Na-claim ang Teritoryo!';

  @override
  String get areaLabel => 'Lugar';

  @override
  String get done => 'Tapos';

  @override
  String get loopCompleted => 'Natapos ang Loop!';

  @override
  String get privacyPolicy => 'Patakaran sa Privacy';

  @override
  String get termsOfUse => 'Mga Tuntunin ng Paggamit';
}
