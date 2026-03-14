import 'package:flutter_test/flutter_test.dart';
import 'package:run_territory/core/utils/geo_utils.dart';
import 'package:run_territory/domain/entities/gps_point.dart';

void main() {
  group('GeoUtils', () {
    group('haversineDistance', () {
      test('같은 지점 거리는 0', () {
        final p = GpsPoint(latitude: 37.5665, longitude: 126.9780, timestamp: DateTime.now());
        expect(GeoUtils.haversineDistance(p, p), closeTo(0, 0.001));
      });

      test('서울-부산 약 325km', () {
        final seoul = GpsPoint(latitude: 37.5665, longitude: 126.9780, timestamp: DateTime.now());
        final busan = GpsPoint(latitude: 35.1796, longitude: 129.0756, timestamp: DateTime.now());
        final dist = GeoUtils.haversineDistance(seoul, busan);
        expect(dist, greaterThan(300000));
        expect(dist, lessThan(350000));
      });
    });

    group('detectLoop', () {
      test('20포인트 미만이면 루프 감지 안 함', () {
        final point = GpsPoint(latitude: 37.5665, longitude: 126.9780, timestamp: DateTime.now());
        final path = List.generate(19, (_) => point);
        expect(GeoUtils.detectLoop(path), isFalse);
      });

      test('시작점으로 10m 이내 복귀하면 루프 감지', () {
        // 20개 포인트 생성 후 마지막을 시작점 근처로
        final path = List.generate(19, (i) => GpsPoint(
          latitude: 37.5665 + i * 0.001,
          longitude: 126.9780,
          timestamp: DateTime.now(),
        ));
        // 마지막 포인트를 시작점에서 5m 거리에 추가
        final nearStart = GpsPoint(latitude: 37.56650045, longitude: 126.9780, timestamp: DateTime.now());
        path.add(nearStart);
        expect(GeoUtils.detectLoop(path), isTrue);
      });

      test('시작점에서 멀리 있으면 루프 감지 안 함', () {
        final path = List.generate(20, (i) => GpsPoint(
          latitude: 37.5665 + i * 0.001,
          longitude: 126.9780,
          timestamp: DateTime.now(),
        ));
        expect(GeoUtils.detectLoop(path), isFalse);
      });
    });

    group('calculateAreaM2', () {
      test('삼각형 면적 계산', () {
        final polygon = [
          GpsPoint(latitude: 37.5665, longitude: 126.9780, timestamp: DateTime.now()),
          GpsPoint(latitude: 37.5675, longitude: 126.9780, timestamp: DateTime.now()),
          GpsPoint(latitude: 37.5670, longitude: 126.9790, timestamp: DateTime.now()),
        ];
        final area = GeoUtils.calculateAreaM2(polygon);
        expect(area, greaterThan(0));
      });
    });

    group('simplifyPath', () {
      test('2개 이하 포인트는 그대로 반환', () {
        final path = [
          GpsPoint(latitude: 37.5665, longitude: 126.9780, timestamp: DateTime.now()),
        ];
        expect(GeoUtils.simplifyPath(path).length, equals(1));
      });

      test('직선 경로는 단순화 후 시작/끝만 남음', () {
        final path = List.generate(10, (i) => GpsPoint(
          latitude: 37.5665 + i * 0.0001,
          longitude: 126.9780,
          timestamp: DateTime.now(),
        ));
        final simplified = GeoUtils.simplifyPath(path, epsilon: 1.0);
        expect(simplified.length, lessThanOrEqualTo(path.length));
        expect(simplified.first.latitude, equals(path.first.latitude));
        expect(simplified.last.latitude, equals(path.last.latitude));
      });
    });
  });
}
