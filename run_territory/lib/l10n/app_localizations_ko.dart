// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get navHome => '홈';

  @override
  String get navMap => '지도';

  @override
  String get navRun => '달리기';

  @override
  String get navHistory => '기록';

  @override
  String get navSettings => '설정';

  @override
  String get startRun => '달리기 시작';

  @override
  String get myStats => '내 기록';

  @override
  String get totalRuns => '총 달리기';

  @override
  String totalRunsValue(int count) {
    return '$count회';
  }

  @override
  String get totalDistance => '총 거리';

  @override
  String get totalArea => '확보 영역';

  @override
  String get statsLoadFailed => '통계 로드 실패';

  @override
  String get noRunsYet => '아직 달리기 기록이 없어요.\n달려서 땅을 차지해보세요!';

  @override
  String errorMessage(Object error) {
    return '오류: $error';
  }

  @override
  String get territoryColor => '내 영역 색상';

  @override
  String get customColor => '직접 입력';

  @override
  String get customColorTitle => '색상 직접 선택';

  @override
  String get cancel => '취소';

  @override
  String get select => '선택';

  @override
  String get version => '버전';

  @override
  String get pause => '일시정지';

  @override
  String get resume => '재개';

  @override
  String get stop => '정지';

  @override
  String get endRunTitle => '달리기 종료';

  @override
  String get endRunMessage => '달리기를 종료하고 영역을 저장할까요?';

  @override
  String get save => '저장';

  @override
  String get distance => '거리';

  @override
  String get time => '시간';

  @override
  String get pace => '페이스';

  @override
  String get unitSystem => '단위 시스템';

  @override
  String get metric => '미터법 (km, m)';

  @override
  String get imperial => '야드파운드법 (mi, ft)';

  @override
  String get paceUnit => '분/km';

  @override
  String get paceUnitImperial => '분/mi';
}
