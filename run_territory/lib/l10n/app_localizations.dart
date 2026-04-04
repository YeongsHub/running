import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fil.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fil'),
    Locale('fr'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('ms'),
    Locale('pt'),
    Locale('ru'),
    Locale('vi'),
    Locale('zh')
  ];

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navMap.
  ///
  /// In en, this message translates to:
  /// **'My Territory'**
  String get navMap;

  /// No description provided for @navRun.
  ///
  /// In en, this message translates to:
  /// **'Run'**
  String get navRun;

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @startRun.
  ///
  /// In en, this message translates to:
  /// **'Start Run'**
  String get startRun;

  /// No description provided for @myStats.
  ///
  /// In en, this message translates to:
  /// **'My Stats'**
  String get myStats;

  /// No description provided for @totalRuns.
  ///
  /// In en, this message translates to:
  /// **'Total Runs'**
  String get totalRuns;

  /// No description provided for @totalRunsValue.
  ///
  /// In en, this message translates to:
  /// **'{count} runs'**
  String totalRunsValue(int count);

  /// No description provided for @totalDistance.
  ///
  /// In en, this message translates to:
  /// **'Total Distance'**
  String get totalDistance;

  /// No description provided for @totalArea.
  ///
  /// In en, this message translates to:
  /// **'Territory Claimed'**
  String get totalArea;

  /// No description provided for @statsLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load stats'**
  String get statsLoadFailed;

  /// No description provided for @noRunsYet.
  ///
  /// In en, this message translates to:
  /// **'No runs yet.\nStart running to claim territory!'**
  String get noRunsYet;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorMessage(Object error);

  /// No description provided for @territoryColor.
  ///
  /// In en, this message translates to:
  /// **'Territory Color'**
  String get territoryColor;

  /// No description provided for @customColor.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get customColor;

  /// No description provided for @customColorTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a Color'**
  String get customColorTitle;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @endRunTitle.
  ///
  /// In en, this message translates to:
  /// **'End Run'**
  String get endRunTitle;

  /// No description provided for @endRunMessage.
  ///
  /// In en, this message translates to:
  /// **'End run and save territory?'**
  String get endRunMessage;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @pace.
  ///
  /// In en, this message translates to:
  /// **'Pace'**
  String get pace;

  /// No description provided for @unitSystem.
  ///
  /// In en, this message translates to:
  /// **'Unit System'**
  String get unitSystem;

  /// No description provided for @metric.
  ///
  /// In en, this message translates to:
  /// **'Metric (km, m)'**
  String get metric;

  /// No description provided for @imperial.
  ///
  /// In en, this message translates to:
  /// **'Imperial (mi, ft)'**
  String get imperial;

  /// No description provided for @paceUnit.
  ///
  /// In en, this message translates to:
  /// **'min/km'**
  String get paceUnit;

  /// No description provided for @paceUnitImperial.
  ///
  /// In en, this message translates to:
  /// **'min/mi'**
  String get paceUnitImperial;

  /// No description provided for @planFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get planFree;

  /// No description provided for @planPro.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get planPro;

  /// No description provided for @upgradeToPro.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get upgradeToPro;

  /// No description provided for @proFeatures.
  ///
  /// In en, this message translates to:
  /// **'Pro Features'**
  String get proFeatures;

  /// No description provided for @proFeatureMultiplayer.
  ///
  /// In en, this message translates to:
  /// **'Multiplayer Map'**
  String get proFeatureMultiplayer;

  /// No description provided for @proFeatureMultiplayerDesc.
  ///
  /// In en, this message translates to:
  /// **'See other players\' territories in real time'**
  String get proFeatureMultiplayerDesc;

  /// No description provided for @proFeatureLeaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboards'**
  String get proFeatureLeaderboard;

  /// No description provided for @proFeatureLeaderboardDesc.
  ///
  /// In en, this message translates to:
  /// **'Compete globally and rank by territory area'**
  String get proFeatureLeaderboardDesc;

  /// No description provided for @proFeatureCloudSync.
  ///
  /// In en, this message translates to:
  /// **'Cloud Sync'**
  String get proFeatureCloudSync;

  /// No description provided for @proFeatureCloudSyncDesc.
  ///
  /// In en, this message translates to:
  /// **'Back up your runs and territories across devices'**
  String get proFeatureCloudSyncDesc;

  /// No description provided for @proFeatureFriends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get proFeatureFriends;

  /// No description provided for @proFeatureFriendsDesc.
  ///
  /// In en, this message translates to:
  /// **'Challenge friends and see their territories'**
  String get proFeatureFriendsDesc;

  /// No description provided for @proPrice.
  ///
  /// In en, this message translates to:
  /// **'Unlock Pro — \$4.99 (one-time)'**
  String get proPrice;

  /// No description provided for @proUpgradeConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro?'**
  String get proUpgradeConfirmTitle;

  /// No description provided for @proUpgradeConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This is a simulated purchase. Tap Confirm to unlock all Pro features.'**
  String get proUpgradeConfirmMessage;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @proUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Pro unlocked! Enjoy all features.'**
  String get proUnlocked;

  /// No description provided for @proAlreadyOwned.
  ///
  /// In en, this message translates to:
  /// **'You already own Pro.'**
  String get proAlreadyOwned;

  /// No description provided for @proLockedHint.
  ///
  /// In en, this message translates to:
  /// **'Pro feature — tap to upgrade'**
  String get proLockedHint;

  /// No description provided for @currentPlan.
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get currentPlan;

  /// No description provided for @territoryClaimed.
  ///
  /// In en, this message translates to:
  /// **'Territory Claimed!'**
  String get territoryClaimed;

  /// No description provided for @areaLabel.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get areaLabel;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @loopCompleted.
  ///
  /// In en, this message translates to:
  /// **'Loop Completed!'**
  String get loopCompleted;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fil',
        'fr',
        'id',
        'it',
        'ja',
        'ko',
        'ms',
        'pt',
        'ru',
        'vi',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fil':
      return AppLocalizationsFil();
    case 'fr':
      return AppLocalizationsFr();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ms':
      return AppLocalizationsMs();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
