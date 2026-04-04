// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get navHome => 'Accueil';

  @override
  String get navMap => 'Mon territoire';

  @override
  String get navRun => 'Courir';

  @override
  String get navHistory => 'Historique';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get startRun => 'Démarrer la course';

  @override
  String get myStats => 'Mes statistiques';

  @override
  String get totalRuns => 'Courses totales';

  @override
  String totalRunsValue(int count) {
    return '$count courses';
  }

  @override
  String get totalDistance => 'Distance totale';

  @override
  String get totalArea => 'Territoire conquis';

  @override
  String get statsLoadFailed => 'Impossible de charger les statistiques';

  @override
  String get noRunsYet =>
      'Aucune course pour l\'instant.\nCommencez à courir pour conquérir un territoire !';

  @override
  String errorMessage(Object error) {
    return 'Erreur : $error';
  }

  @override
  String get territoryColor => 'Couleur du territoire';

  @override
  String get customColor => 'Personnalisé';

  @override
  String get customColorTitle => 'Choisir une couleur';

  @override
  String get cancel => 'Annuler';

  @override
  String get select => 'Sélectionner';

  @override
  String get version => 'Version';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Reprendre';

  @override
  String get stop => 'Arrêter';

  @override
  String get endRunTitle => 'Terminer la course';

  @override
  String get endRunMessage =>
      'Terminer la course et sauvegarder le territoire ?';

  @override
  String get save => 'Enregistrer';

  @override
  String get distance => 'Distance';

  @override
  String get time => 'Temps';

  @override
  String get pace => 'Allure';

  @override
  String get unitSystem => 'Système d\'unités';

  @override
  String get metric => 'Métrique (km, m)';

  @override
  String get imperial => 'Impérial (mi, ft)';

  @override
  String get paceUnit => 'min/km';

  @override
  String get paceUnitImperial => 'min/mi';

  @override
  String get planFree => 'Gratuit';

  @override
  String get planPro => 'Pro';

  @override
  String get upgradeToPro => 'Passer à Pro';

  @override
  String get proFeatures => 'Fonctionnalités Pro';

  @override
  String get proFeatureMultiplayer => 'Carte multijoueur';

  @override
  String get proFeatureMultiplayerDesc =>
      'Voyez les territoires des autres joueurs en temps réel';

  @override
  String get proFeatureLeaderboard => 'Classement';

  @override
  String get proFeatureLeaderboardDesc =>
      'Affrontez le monde par superficie de territoire';

  @override
  String get proFeatureCloudSync => 'Synchronisation cloud';

  @override
  String get proFeatureCloudSyncDesc =>
      'Sauvegardez vos courses et territoires sur tous vos appareils';

  @override
  String get proFeatureFriends => 'Amis';

  @override
  String get proFeatureFriendsDesc =>
      'Défiez vos amis et voyez leurs territoires';

  @override
  String get proPrice => 'Débloquer Pro — 4,99 € (achat unique)';

  @override
  String get proUpgradeConfirmTitle => 'Passer à Pro ?';

  @override
  String get proUpgradeConfirmMessage =>
      'Il s\'agit d\'un achat simulé. Appuyez sur Confirmer pour débloquer toutes les fonctionnalités Pro.';

  @override
  String get confirm => 'Confirmer';

  @override
  String get proUnlocked =>
      'Pro débloqué ! Profitez de toutes les fonctionnalités.';

  @override
  String get proAlreadyOwned => 'Vous possédez déjà Pro.';

  @override
  String get proLockedHint => 'Fonctionnalité Pro — appuyez pour passer à Pro';

  @override
  String get currentPlan => 'Plan actuel';

  @override
  String get territoryClaimed => 'Territoire conquis !';

  @override
  String get areaLabel => 'Superficie';

  @override
  String get done => 'Terminé';

  @override
  String get loopCompleted => 'Boucle terminée !';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get termsOfUse => 'Conditions d\'utilisation';
}
