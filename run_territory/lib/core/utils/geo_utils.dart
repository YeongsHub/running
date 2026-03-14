import 'dart:math';
import 'package:run_territory/domain/entities/gps_point.dart';

class GeoUtils {
  static const double _earthRadius = 6371000.0;

  static double haversineDistance(GpsPoint a, GpsPoint b) {
    final lat1 = a.latitude * pi / 180;
    final lat2 = b.latitude * pi / 180;
    final dLat = (b.latitude - a.latitude) * pi / 180;
    final dLng = (b.longitude - a.longitude) * pi / 180;
    final sinDLat = sin(dLat / 2);
    final sinDLng = sin(dLng / 2);
    final aVal = sinDLat * sinDLat + cos(lat1) * cos(lat2) * sinDLng * sinDLng;
    return 2 * _earthRadius * atan2(sqrt(aVal), sqrt(1 - aVal));
  }

  static bool isValidPoint(GpsPoint point, GpsPoint? previous) {
    if (point.accuracy != null && point.accuracy! > 20) return false;
    if (previous != null) {
      final dist = haversineDistance(point, previous);
      final timeDiff = point.timestamp.difference(previous.timestamp).inSeconds;
      if (timeDiff > 0 && dist / timeDiff > 15) return false;
    }
    return true;
  }

  static List<GpsPoint> simplifyPath(List<GpsPoint> points, {double epsilon = 2.0}) {
    if (points.length <= 2) return points;
    double maxDist = 0;
    int maxIdx = 0;
    final start = points.first;
    final end = points.last;
    for (int i = 1; i < points.length - 1; i++) {
      final dist = _perpendicularDistance(points[i], start, end);
      if (dist > maxDist) {
        maxDist = dist;
        maxIdx = i;
      }
    }
    if (maxDist > epsilon) {
      final left = simplifyPath(points.sublist(0, maxIdx + 1), epsilon: epsilon);
      final right = simplifyPath(points.sublist(maxIdx), epsilon: epsilon);
      return [...left.sublist(0, left.length - 1), ...right];
    }
    return [start, end];
  }

  static double _perpendicularDistance(GpsPoint p, GpsPoint start, GpsPoint end) {
    final dx = end.longitude - start.longitude;
    final dy = end.latitude - start.latitude;
    final mag = sqrt(dx * dx + dy * dy);
    if (mag == 0) return haversineDistance(p, start);
    final u = ((p.longitude - start.longitude) * dx + (p.latitude - start.latitude) * dy) / (mag * mag);
    final closestLat = start.latitude + u * dy;
    final closestLng = start.longitude + u * dx;
    return haversineDistance(p, GpsPoint(
      latitude: closestLat, longitude: closestLng, timestamp: p.timestamp));
  }

  /// 경로를 좌우 bufferMeters만큼 확장하여 폴리곤 생성
  static List<GpsPoint> pathToPolygon(List<GpsPoint> path, {double bufferMeters = 5.0}) {
    if (path.length < 2) return path;
    final simplified = simplifyPath(path);
    final left = <GpsPoint>[];
    final right = <GpsPoint>[];

    for (int i = 0; i < simplified.length; i++) {
      final curr = simplified[i];
      GpsPoint dir;
      if (i == 0) {
        dir = simplified[1];
      } else if (i == simplified.length - 1) {
        dir = simplified[i - 1];
      } else {
        dir = simplified[i + 1];
      }

      final bearing = _bearing(curr, dir);
      final leftBearing = (bearing - 90) * pi / 180;
      final rightBearing = (bearing + 90) * pi / 180;

      final dLat = bufferMeters / _earthRadius * 180 / pi;
      final dLng = bufferMeters / (_earthRadius * cos(curr.latitude * pi / 180)) * 180 / pi;

      left.add(GpsPoint(
        latitude: curr.latitude + dLat * sin(leftBearing),
        longitude: curr.longitude + dLng * cos(leftBearing),
        timestamp: curr.timestamp,
      ));
      right.add(GpsPoint(
        latitude: curr.latitude + dLat * sin(rightBearing),
        longitude: curr.longitude + dLng * cos(rightBearing),
        timestamp: curr.timestamp,
      ));
    }

    return [...left, ...right.reversed];
  }

  static double _bearing(GpsPoint from, GpsPoint to) {
    final dLng = (to.longitude - from.longitude) * pi / 180;
    final lat1 = from.latitude * pi / 180;
    final lat2 = to.latitude * pi / 180;
    final y = sin(dLng) * cos(lat2);
    final x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLng);
    return atan2(y, x) * 180 / pi;
  }

  static double calculateAreaM2(List<GpsPoint> polygon) {
    if (polygon.length < 3) return 0;
    double area = 0;
    final n = polygon.length;
    for (int i = 0; i < n; i++) {
      final j = (i + 1) % n;
      final xi = polygon[i].longitude * pi / 180 * _earthRadius;
      final yi = polygon[i].latitude * pi / 180 * _earthRadius;
      final xj = polygon[j].longitude * pi / 180 * _earthRadius;
      final yj = polygon[j].latitude * pi / 180 * _earthRadius;
      area += xi * yj - xj * yi;
    }
    return area.abs() / 2;
  }

  /// 단순한 폴리곤 포함 여부 검사 (Ray casting)
  static bool polygonContainsPoint(List<GpsPoint> polygon, GpsPoint point) {
    bool inside = false;
    final n = polygon.length;
    for (int i = 0, j = n - 1; i < n; j = i++) {
      final xi = polygon[i].longitude;
      final yi = polygon[i].latitude;
      final xj = polygon[j].longitude;
      final yj = polygon[j].latitude;
      final intersect = ((yi > point.latitude) != (yj > point.latitude)) &&
          (point.longitude < (xj - xi) * (point.latitude - yi) / (yj - yi) + xi);
      if (intersect) inside = !inside;
    }
    return inside;
  }

  /// 두 폴리곤의 중심점이 서로 포함되는지 확인 (간단한 중첩 검사)
  static bool polygonsOverlap(List<GpsPoint> a, List<GpsPoint> b) {
    if (a.isEmpty || b.isEmpty) return false;
    final centerA = _centroid(a);
    final centerB = _centroid(b);
    return polygonContainsPoint(b, centerA) || polygonContainsPoint(a, centerB);
  }

  static GpsPoint _centroid(List<GpsPoint> polygon) {
    final lat = polygon.map((p) => p.latitude).reduce((a, b) => a + b) / polygon.length;
    final lng = polygon.map((p) => p.longitude).reduce((a, b) => a + b) / polygon.length;
    return GpsPoint(latitude: lat, longitude: lng, timestamp: DateTime.now());
  }

  /// 단순 병합: 두 폴리곤의 꼭짓점을 합쳐 Convex Hull 반환
  static List<GpsPoint> mergePolygons(List<GpsPoint> a, List<GpsPoint> b) {
    final combined = [...a, ...b];
    return _convexHull(combined);
  }

  static List<GpsPoint> _convexHull(List<GpsPoint> points) {
    if (points.length <= 3) return points;
    final sorted = List<GpsPoint>.from(points)
      ..sort((a, b) {
        final latCmp = a.latitude.compareTo(b.latitude);
        return latCmp != 0 ? latCmp : a.longitude.compareTo(b.longitude);
      });

    List<GpsPoint> lower = [];
    for (final p in sorted) {
      while (lower.length >= 2 && _cross(lower[lower.length - 2], lower.last, p) <= 0) {
        lower.removeLast();
      }
      lower.add(p);
    }
    List<GpsPoint> upper = [];
    for (final p in sorted.reversed) {
      while (upper.length >= 2 && _cross(upper[upper.length - 2], upper.last, p) <= 0) {
        upper.removeLast();
      }
      upper.add(p);
    }
    lower.removeLast();
    upper.removeLast();
    return [...lower, ...upper];
  }

  static double _cross(GpsPoint O, GpsPoint A, GpsPoint B) {
    return (A.longitude - O.longitude) * (B.latitude - O.latitude) -
        (A.latitude - O.latitude) * (B.longitude - O.longitude);
  }

  // 루프 감지: 현재 마지막 포인트가 시작점으로부터 thresholdMeters 이내인지 확인
  // 최소 20포인트 이상이어야 루프로 인정 (너무 짧은 경로 방지)
  static bool detectLoop(List<GpsPoint> path, {double thresholdMeters = 10.0}) {
    if (path.length < 20) return false;
    final start = path.first;
    final current = path.last;
    return haversineDistance(start, current) <= thresholdMeters;
  }

  // 루프 경로를 폴리곤으로 변환 (버퍼링 없이 경로 자체를 폴리곤으로)
  static List<GpsPoint> pathToEnclosedPolygon(List<GpsPoint> path) {
    if (path.length < 3) return path;
    return simplifyPath(path, epsilon: 2.0);
  }
}
