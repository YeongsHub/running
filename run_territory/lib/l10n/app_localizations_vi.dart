// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get navHome => 'Trang chủ';

  @override
  String get navMap => 'Lãnh thổ của tôi';

  @override
  String get navRun => 'Chạy';

  @override
  String get navHistory => 'Lịch sử';

  @override
  String get navSettings => 'Cài đặt';

  @override
  String get startRun => 'Bắt đầu chạy';

  @override
  String get myStats => 'Thống kê của tôi';

  @override
  String get totalRuns => 'Tổng số lần chạy';

  @override
  String totalRunsValue(int count) {
    return '$count lần';
  }

  @override
  String get totalDistance => 'Tổng quãng đường';

  @override
  String get totalArea => 'Lãnh thổ đã chiếm';

  @override
  String get statsLoadFailed => 'Không thể tải thống kê';

  @override
  String get noRunsYet =>
      'Chưa có lần chạy nào.\nBắt đầu chạy để chiếm lãnh thổ!';

  @override
  String errorMessage(Object error) {
    return 'Lỗi: $error';
  }

  @override
  String get territoryColor => 'Màu lãnh thổ';

  @override
  String get customColor => 'Tùy chỉnh';

  @override
  String get customColorTitle => 'Chọn màu';

  @override
  String get cancel => 'Hủy';

  @override
  String get select => 'Chọn';

  @override
  String get version => 'Phiên bản';

  @override
  String get pause => 'Tạm dừng';

  @override
  String get resume => 'Tiếp tục';

  @override
  String get stop => 'Dừng';

  @override
  String get endRunTitle => 'Kết thúc chạy';

  @override
  String get endRunMessage => 'Kết thúc và lưu lãnh thổ?';

  @override
  String get save => 'Lưu';

  @override
  String get distance => 'Quãng đường';

  @override
  String get time => 'Thời gian';

  @override
  String get pace => 'Tốc độ';

  @override
  String get unitSystem => 'Hệ đơn vị';

  @override
  String get metric => 'Hệ mét (km, m)';

  @override
  String get imperial => 'Hệ Anh (mi, ft)';

  @override
  String get paceUnit => 'phút/km';

  @override
  String get paceUnitImperial => 'phút/mi';

  @override
  String get planFree => 'Miễn phí';

  @override
  String get planPro => 'Pro';

  @override
  String get upgradeToPro => 'Nâng cấp lên Pro';

  @override
  String get proFeatures => 'Tính năng Pro';

  @override
  String get proFeatureMultiplayer => 'Bản đồ nhiều người';

  @override
  String get proFeatureMultiplayerDesc =>
      'Xem lãnh thổ của người chơi khác theo thời gian thực';

  @override
  String get proFeatureLeaderboard => 'Bảng xếp hạng';

  @override
  String get proFeatureLeaderboardDesc =>
      'Cạnh tranh toàn cầu theo diện tích lãnh thổ';

  @override
  String get proFeatureCloudSync => 'Đồng bộ đám mây';

  @override
  String get proFeatureCloudSyncDesc =>
      'Sao lưu dữ liệu chạy và lãnh thổ trên nhiều thiết bị';

  @override
  String get proFeatureFriends => 'Bạn bè';

  @override
  String get proFeatureFriendsDesc => 'Thách đấu bạn bè và xem lãnh thổ của họ';

  @override
  String get proPrice => 'Mở khóa Pro — \$4.99 (một lần)';

  @override
  String get proUpgradeConfirmTitle => 'Nâng cấp lên Pro?';

  @override
  String get proUpgradeConfirmMessage =>
      'Đây là giao dịch mô phỏng. Nhấn Xác nhận để mở khóa tất cả tính năng Pro.';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get proUnlocked => 'Đã mở khóa Pro! Tận hưởng tất cả tính năng.';

  @override
  String get proAlreadyOwned => 'Bạn đã sở hữu Pro.';

  @override
  String get proLockedHint => 'Tính năng Pro — nhấn để nâng cấp';

  @override
  String get currentPlan => 'Gói hiện tại';

  @override
  String get territoryClaimed => 'Đã chiếm lãnh thổ!';

  @override
  String get areaLabel => 'Diện tích';

  @override
  String get done => 'Xong';

  @override
  String get loopCompleted => 'Hoàn thành vòng!';

  @override
  String get privacyPolicy => 'Chính sách quyền riêng tư';

  @override
  String get termsOfUse => 'Điều khoản sử dụng';
}
