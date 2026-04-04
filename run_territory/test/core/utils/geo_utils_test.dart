import 'package:flutter_test/flutter_test.dart';
import 'package:run_territory/core/utils/geo_utils.dart';
import 'package:run_territory/domain/entities/gps_point.dart';

void main() {
  final t = DateTime(2024, 1, 1);

  GpsPoint pt(double lat, double lng) =>
      GpsPoint(latitude: lat, longitude: lng, timestamp: t);

  group('haversineDistance', () {
    test('같은 지점은 거리 0', () {
      final p = pt(37.5665, 126.9780);
      expect(GeoUtils.haversineDistance(p, p), 0.0);
    });

    test('서울-부산 거리 약 325km', () {
      final seoul = pt(37.5665, 126.9780);
      final busan = pt(35.1796, 129.0756);
      final dist = GeoUtils.haversineDistance(seoul, busan);
      expect(dist, greaterThan(320000));
      expect(dist, lessThan(335000));
    });

    test('100m 남북 이동', () {
      final a = pt(37.5000, 127.0000);
      final b = pt(37.5009, 127.0000); // ~100m 북쪽
      final dist = GeoUtils.haversineDistance(a, b);
      expect(dist, greaterThan(90));
      expect(dist, lessThan(110));
    });
  });

  group('isValidPoint', () {
    test('정확도 20m 이하 → 유효', () {
      final p = GpsPoint(
          latitude: 37.5, longitude: 127.0, timestamp: t, accuracy: 15.0);
      expect(GeoUtils.isValidPoint(p, null), isTrue);
    });

    test('정확도 25m 초과 → 무효', () {
      final p = GpsPoint(
          latitude: 37.5, longitude: 127.0, timestamp: t, accuracy: 25.0);
      expect(GeoUtils.isValidPoint(p, null), isFalse);
    });

    test('이전 포인트 없으면 항상 유효 (정확도 null)', () {
      final p = pt(37.5, 127.0);
      expect(GeoUtils.isValidPoint(p, null), isTrue);
    });

    test('1초에 16m 이상 이동 → 무효 (속도 초과)', () {
      final prev = GpsPoint(
          latitude: 37.5000, longitude: 127.0000,
          timestamp: DateTime(2024, 1, 1, 0, 0, 0));
      final curr = GpsPoint(
          latitude: 37.5010, longitude: 127.0000, // ~111m
          timestamp: DateTime(2024, 1, 1, 0, 0, 1)); // 1초 후
      expect(GeoUtils.isValidPoint(curr, prev), isFalse);
    });

    test('정상 보행 속도 → 유효', () {
      final prev = GpsPoint(
          latitude: 37.5000, longitude: 127.0000,
          timestamp: DateTime(2024, 1, 1, 0, 0, 0));
      final curr = GpsPoint(
          latitude: 37.5001, longitude: 127.0000, // ~11m
          timestamp: DateTime(2024, 1, 1, 0, 0, 2)); // 2초 후
      expect(GeoUtils.isValidPoint(curr, prev), isTrue);
    });
  });

  group('calculateAreaM2', () {
    test('3점 미만 → 0', () {
      expect(GeoUtils.calculateAreaM2([pt(37.5, 127.0)]), 0.0);
    });

    test('삼각형 면적 양수', () {
      final polygon = [
        pt(37.5000, 127.0000),
        pt(37.5010, 127.0000),
        pt(37.5005, 127.0010),
      ];
      expect(GeoUtils.calculateAreaM2(polygon), greaterThan(0));
    });

    test('큰 사각형 면적 검증', () {
      final polygon = [
        pt(37.4990, 126.9990),
        pt(37.5010, 126.9990),
        pt(37.5010, 127.0010),
        pt(37.4990, 127.0010),
      ];
      final area = GeoUtils.calculateAreaM2(polygon);
      expect(area, greaterThan(40000)); // 약 0.05km²
    });
  });

  group('detectLoop', () {
    test('20포인트 미만 → 루프 아님', () {
      final path = List.generate(
          19, (i) => pt(37.5 + i * 0.0001, 127.0));
      expect(GeoUtils.detectLoop(path), isFalse);
    });

    test('시작점으로 돌아오면 루프 감지', () {
      final start = pt(37.5000, 127.0000);
      final path = [
        start,
        ...List.generate(19, (i) => pt(37.5 + (i + 1) * 0.0001, 127.0)),
        GpsPoint(latitude: 37.5000, longitude: 127.0000, timestamp: t, accuracy: 5.0),
      ];
      expect(GeoUtils.detectLoop(path), isTrue);
    });

    test('멀리 떨어져 있으면 루프 아님', () {
      final path = List.generate(
          25, (i) => pt(37.5000 + i * 0.001, 127.0000));
      expect(GeoUtils.detectLoop(path), isFalse);
    });
  });

  group('simplifyPath', () {
    test('2점 이하 → 그대로 반환', () {
      final path = [pt(37.5, 127.0), pt(37.6, 127.1)];
      expect(GeoUtils.simplifyPath(path), path);
    });

    test('직선 경로 단순화 → 시작+끝만 남음', () {
      final path = [
        pt(37.5000, 127.0000),
        pt(37.5001, 127.0001),
        pt(37.5002, 127.0002),
        pt(37.5003, 127.0003),
        pt(37.5004, 127.0004),
      ];
      final simplified = GeoUtils.simplifyPath(path, epsilon: 1.0);
      expect(simplified.length, lessThanOrEqualTo(path.length));
    });
  });
}
