// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get navHome => '主页';

  @override
  String get navMap => '我的领地';

  @override
  String get navRun => '跑步';

  @override
  String get navHistory => '历史';

  @override
  String get navSettings => '设置';

  @override
  String get startRun => '开始跑步';

  @override
  String get myStats => '我的统计';

  @override
  String get totalRuns => '总跑步次数';

  @override
  String totalRunsValue(int count) {
    return '$count次';
  }

  @override
  String get totalDistance => '总距离';

  @override
  String get totalArea => '占领面积';

  @override
  String get statsLoadFailed => '统计加载失败';

  @override
  String get noRunsYet => '还没有跑步记录。\n开始跑步，占领你的领地！';

  @override
  String errorMessage(Object error) {
    return '错误：$error';
  }

  @override
  String get territoryColor => '领地颜色';

  @override
  String get customColor => '自定义';

  @override
  String get customColorTitle => '选择颜色';

  @override
  String get cancel => '取消';

  @override
  String get select => '选择';

  @override
  String get version => '版本';

  @override
  String get pause => '暂停';

  @override
  String get resume => '继续';

  @override
  String get stop => '停止';

  @override
  String get endRunTitle => '结束跑步';

  @override
  String get endRunMessage => '结束跑步并保存领地？';

  @override
  String get save => '保存';

  @override
  String get distance => '距离';

  @override
  String get time => '时间';

  @override
  String get pace => '配速';

  @override
  String get unitSystem => '单位制';

  @override
  String get metric => '公制（km, m）';

  @override
  String get imperial => '英制（mi, ft）';

  @override
  String get paceUnit => '分钟/km';

  @override
  String get paceUnitImperial => '分钟/mi';

  @override
  String get planFree => '免费版';

  @override
  String get planPro => 'Pro';

  @override
  String get upgradeToPro => '升级到 Pro';

  @override
  String get proFeatures => 'Pro 功能';

  @override
  String get proFeatureMultiplayer => '多人地图';

  @override
  String get proFeatureMultiplayerDesc => '实时查看其他玩家的领地';

  @override
  String get proFeatureLeaderboard => '排行榜';

  @override
  String get proFeatureLeaderboardDesc => '按领地面积全球排名';

  @override
  String get proFeatureCloudSync => '云同步';

  @override
  String get proFeatureCloudSyncDesc => '跨设备备份跑步记录和领地';

  @override
  String get proFeatureFriends => '好友';

  @override
  String get proFeatureFriendsDesc => '与好友竞争领地';

  @override
  String get proPrice => '解锁 Pro — ¥30（一次性）';

  @override
  String get proUpgradeConfirmTitle => '升级到 Pro？';

  @override
  String get proUpgradeConfirmMessage => '这是模拟购买。点击确认解锁所有 Pro 功能。';

  @override
  String get confirm => '确认';

  @override
  String get proUnlocked => 'Pro 已解锁！尽情享用所有功能。';

  @override
  String get proAlreadyOwned => '您已拥有 Pro。';

  @override
  String get proLockedHint => 'Pro 功能 — 点击升级';

  @override
  String get currentPlan => '当前方案';

  @override
  String get territoryClaimed => '领地占领成功！';

  @override
  String get areaLabel => '面积';

  @override
  String get done => '完成';

  @override
  String get loopCompleted => '循环完成！';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get termsOfUse => '使用条款';
}
