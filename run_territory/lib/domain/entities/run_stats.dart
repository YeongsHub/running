class RunStats {
  final int totalRuns;
  final double totalDistanceKm;
  final Duration totalDuration;
  final double totalAreaM2;
  final double bestPace;
  final double longestRunKm;

  const RunStats({
    required this.totalRuns,
    required this.totalDistanceKm,
    required this.totalDuration,
    required this.totalAreaM2,
    required this.bestPace,
    required this.longestRunKm,
  });

  static const RunStats empty = RunStats(
    totalRuns: 0,
    totalDistanceKm: 0,
    totalDuration: Duration.zero,
    totalAreaM2: 0,
    bestPace: 0,
    longestRunKm: 0,
  );
}
