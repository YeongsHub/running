class FormatUtils {
  static String formatDistance(double meters, {bool imperial = false}) {
    if (imperial) {
      final feet = meters * 3.28084;
      if (feet < 5280) return '${feet.toStringAsFixed(0)}ft';
      return '${(feet / 5280).toStringAsFixed(2)}mi';
    }
    if (meters < 1000) return '${meters.toStringAsFixed(0)}m';
    return '${(meters / 1000).toStringAsFixed(2)}km';
  }

  static String formatPace(double minPerKm, {bool imperial = false}) {
    if (minPerKm <= 0 || minPerKm.isInfinite) return '--\'--"';
    final pace = imperial ? minPerKm * 1.60934 : minPerKm;
    final min = pace.floor();
    final sec = ((pace - min) * 60).round();
    return "$min'${sec.toString().padLeft(2, '0')}\"";
  }

  static String formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;
    if (h > 0) return '$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  static String formatArea(double areaM2, {bool imperial = false}) {
    if (imperial) {
      final sqft = areaM2 * 10.7639;
      if (sqft < 43560) return '${sqft.toStringAsFixed(0)}ft²';
      return '${(sqft / 43560).toStringAsFixed(2)}ac';
    }
    if (areaM2 < 10000) return '${areaM2.toStringAsFixed(0)}m²';
    return '${(areaM2 / 10000).toStringAsFixed(2)}ha';
  }

  // 총 거리 표시 (km 또는 mi 단위로)
  static String formatTotalDistance(double km, {bool imperial = false}) {
    if (imperial) return '${(km * 0.621371).toStringAsFixed(1)}mi';
    return '${km.toStringAsFixed(1)}km';
  }
}
