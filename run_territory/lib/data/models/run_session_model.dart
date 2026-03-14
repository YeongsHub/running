import 'package:run_territory/domain/entities/run_session.dart';

class RunSessionModel extends RunSession {
  const RunSessionModel({
    required super.id,
    required super.startedAt,
    super.endedAt,
    required super.status,
    required super.path,
    required super.totalDistance,
    required super.totalDuration,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'started_at': startedAt.millisecondsSinceEpoch,
    'ended_at': endedAt?.millisecondsSinceEpoch,
    'status': status.name,
    'distance_m': totalDistance,
    'duration_s': totalDuration.inSeconds,
    'avg_pace': avgPace,
  };

  factory RunSessionModel.fromMap(Map<String, dynamic> map) => RunSessionModel(
    id: map['id'] as String,
    startedAt: DateTime.fromMillisecondsSinceEpoch(map['started_at'] as int),
    endedAt: map['ended_at'] != null
        ? DateTime.fromMillisecondsSinceEpoch(map['ended_at'] as int)
        : null,
    status: RunStatus.values.byName(map['status'] as String),
    path: const [],
    totalDistance: (map['distance_m'] as num).toDouble(),
    totalDuration: Duration(seconds: map['duration_s'] as int),
  );
}
