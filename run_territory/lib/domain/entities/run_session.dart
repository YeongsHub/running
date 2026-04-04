import 'package:run_territory/domain/entities/gps_point.dart';

enum RunStatus { idle, running, paused, loopCompleted, completed }

class RunSession {
  final String id;
  final DateTime startedAt;
  final DateTime? endedAt;
  final RunStatus status;
  final List<GpsPoint> path;
  final double totalDistance;
  final Duration totalDuration;

  const RunSession({
    required this.id,
    required this.startedAt,
    this.endedAt,
    required this.status,
    required this.path,
    required this.totalDistance,
    required this.totalDuration,
  });

  double get avgPace {
    if (totalDistance == 0) return 0;
    return totalDuration.inSeconds / 60 / (totalDistance / 1000);
  }

  RunSession copyWith({
    String? id, DateTime? startedAt, DateTime? endedAt,
    RunStatus? status, List<GpsPoint>? path,
    double? totalDistance, Duration? totalDuration,
  }) {
    return RunSession(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      status: status ?? this.status,
      path: path ?? this.path,
      totalDistance: totalDistance ?? this.totalDistance,
      totalDuration: totalDuration ?? this.totalDuration,
    );
  }
}
