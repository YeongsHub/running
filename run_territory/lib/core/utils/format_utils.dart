class FormatUtils {
  static String formatDistance(double meters) {
    if (meters < 1000) return '${meters.toStringAsFixed(0)}m';
    return '${(meters / 1000).toStringAsFixed(2)}km';
  }

  static String formatPace(double minPerKm) {
    if (minPerKm <= 0 || minPerKm.isInfinite) return '--\'--"';
    final min = minPerKm.floor();
    final sec = ((minPerKm - min) * 60).round();
    return "$min'${sec.toString().padLeft(2, '0')}\"";
  }

  static String formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;
    if (h > 0) return '$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  static String formatArea(double areaM2) {
    if (areaM2 < 10000) return '${areaM2.toStringAsFixed(0)}m²';
    return '${(areaM2 / 10000).toStringAsFixed(2)}ha';
  }
}
