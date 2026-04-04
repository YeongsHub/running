import 'package:flutter_test/flutter_test.dart';
import 'package:run_territory/core/utils/format_utils.dart';

void main() {
  group('formatDistance', () {
    test('1000m 미만 → 미터 표시', () {
      expect(FormatUtils.formatDistance(500), '500m');
    });

    test('1000m 이상 → km 표시', () {
      expect(FormatUtils.formatDistance(1500), '1.50km');
    });

    test('야드파운드법: 5280ft 미만 → ft 표시', () {
      expect(FormatUtils.formatDistance(100, imperial: true), contains('ft'));
    });

    test('야드파운드법: 1마일 이상 → mi 표시', () {
      expect(FormatUtils.formatDistance(2000, imperial: true), contains('mi'));
    });

    test('0m → 0m', () {
      expect(FormatUtils.formatDistance(0), '0m');
    });
  });

  group('formatPace', () {
    test('0 → 구분자 반환', () {
      expect(FormatUtils.formatPace(0), "--'--\"");
    });

    test('무한대 → 구분자 반환', () {
      expect(FormatUtils.formatPace(double.infinity), "--'--\"");
    });

    test('5분/km → 5\'00"', () {
      expect(FormatUtils.formatPace(5.0), "5'00\"");
    });

    test('6.5분/km → 6\'30"', () {
      expect(FormatUtils.formatPace(6.5), "6'30\"");
    });

    test('야드파운드법 페이스 변환', () {
      final result = FormatUtils.formatPace(5.0, imperial: true);
      expect(result, isNot("--'--\""));
    });
  });

  group('formatDuration', () {
    test('1시간 미만 → MM:SS', () {
      expect(FormatUtils.formatDuration(const Duration(minutes: 30, seconds: 5)),
          '30:05');
    });

    test('1시간 이상 → H:MM:SS', () {
      expect(
          FormatUtils.formatDuration(
              const Duration(hours: 1, minutes: 5, seconds: 3)),
          '1:05:03');
    });

    test('0 → 00:00', () {
      expect(FormatUtils.formatDuration(Duration.zero), '00:00');
    });

    test('59초 → 00:59', () {
      expect(FormatUtils.formatDuration(const Duration(seconds: 59)), '00:59');
    });
  });

  group('formatArea', () {
    test('10000m² 미만 → m² 표시', () {
      expect(FormatUtils.formatArea(500), '500m²');
    });

    test('10000m² 이상 → ha 표시', () {
      expect(FormatUtils.formatArea(15000), '1.50ha');
    });

    test('야드파운드법: 43560ft² 미만 → ft² 표시', () {
      expect(FormatUtils.formatArea(100, imperial: true), contains('ft²'));
    });

    test('야드파운드법: 1에이커 이상 → ac 표시', () {
      expect(FormatUtils.formatArea(10000, imperial: true), contains('ac'));
    });
  });

  group('formatTotalDistance', () {
    test('미터법 → km', () {
      expect(FormatUtils.formatTotalDistance(5.5), '5.5km');
    });

    test('야드파운드법 → mi', () {
      expect(FormatUtils.formatTotalDistance(10.0, imperial: true),
          contains('mi'));
    });
  });
}
