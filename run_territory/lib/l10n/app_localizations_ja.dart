// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get navHome => 'ホーム';

  @override
  String get navMap => 'マイテリトリー';

  @override
  String get navRun => 'ランニング';

  @override
  String get navHistory => '履歴';

  @override
  String get navSettings => '設定';

  @override
  String get startRun => 'ランニング開始';

  @override
  String get myStats => 'マイ統計';

  @override
  String get totalRuns => '総ラン数';

  @override
  String totalRunsValue(int count) {
    return '$count回';
  }

  @override
  String get totalDistance => '総距離';

  @override
  String get totalArea => '獲得エリア';

  @override
  String get statsLoadFailed => '統計の読み込みに失敗しました';

  @override
  String get noRunsYet => 'まだ記録がありません。\n走ってテリトリーを獲得しよう！';

  @override
  String errorMessage(Object error) {
    return 'エラー：$error';
  }

  @override
  String get territoryColor => 'テリトリーカラー';

  @override
  String get customColor => 'カスタム';

  @override
  String get customColorTitle => '色を選択';

  @override
  String get cancel => 'キャンセル';

  @override
  String get select => '選択';

  @override
  String get version => 'バージョン';

  @override
  String get pause => '一時停止';

  @override
  String get resume => '再開';

  @override
  String get stop => '停止';

  @override
  String get endRunTitle => 'ランを終了';

  @override
  String get endRunMessage => 'ランを終了してテリトリーを保存しますか？';

  @override
  String get save => '保存';

  @override
  String get distance => '距離';

  @override
  String get time => '時間';

  @override
  String get pace => 'ペース';

  @override
  String get unitSystem => '単位系';

  @override
  String get metric => 'メートル法（km, m）';

  @override
  String get imperial => 'ヤード・ポンド法（mi, ft）';

  @override
  String get paceUnit => '分/km';

  @override
  String get paceUnitImperial => '分/mi';

  @override
  String get planFree => '無料';

  @override
  String get planPro => 'Pro';

  @override
  String get upgradeToPro => 'Proにアップグレード';

  @override
  String get proFeatures => 'Pro機能';

  @override
  String get proFeatureMultiplayer => 'マルチプレイヤーマップ';

  @override
  String get proFeatureMultiplayerDesc => '他のプレイヤーのテリトリーをリアルタイムで確認';

  @override
  String get proFeatureLeaderboard => 'リーダーボード';

  @override
  String get proFeatureLeaderboardDesc => 'テリトリー面積で世界ランキングに参加';

  @override
  String get proFeatureCloudSync => 'クラウド同期';

  @override
  String get proFeatureCloudSyncDesc => '端末間でランとテリトリーをバックアップ';

  @override
  String get proFeatureFriends => 'フレンド';

  @override
  String get proFeatureFriendsDesc => 'フレンドとテリトリーを競い合おう';

  @override
  String get proPrice => 'Proを解除 — ¥750（買い切り）';

  @override
  String get proUpgradeConfirmTitle => 'Proにアップグレード？';

  @override
  String get proUpgradeConfirmMessage => 'これはシミュレーション購入です。確認でPro機能がすべて解除されます。';

  @override
  String get confirm => '確認';

  @override
  String get proUnlocked => 'Proが解除されました！すべての機能をお楽しみください。';

  @override
  String get proAlreadyOwned => 'すでにProを所有しています。';

  @override
  String get proLockedHint => 'Pro機能 — タップしてアップグレード';

  @override
  String get currentPlan => '現在のプラン';

  @override
  String get territoryClaimed => 'テリトリー獲得！';

  @override
  String get areaLabel => '面積';

  @override
  String get done => '完了';

  @override
  String get loopCompleted => 'ループ完了！';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get termsOfUse => '利用規約';
}
