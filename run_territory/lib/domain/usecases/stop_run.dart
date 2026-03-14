import 'package:run_territory/domain/entities/gps_point.dart';
import 'package:run_territory/domain/entities/run_session.dart';
import 'package:run_territory/domain/repositories/run_repository.dart';

class StopRun {
  final RunRepository _repository;

  StopRun(this._repository);

  Future<RunSession> call({
    required RunSession session,
    required List<GpsPoint> path,
  }) async {
    double totalDistance = 0;
    for (int i = 1; i < path.length; i++) {
      totalDistance += path[i - 1].distanceTo(path[i]);
    }

    final endedAt = DateTime.now();
    final totalDuration = endedAt.difference(session.startedAt);

    final completed = session.copyWith(
      status: RunStatus.completed,
      endedAt: endedAt,
      path: path,
      totalDistance: totalDistance,
      totalDuration: totalDuration,
    );

    await _repository.saveSession(completed);
    return completed;
  }
}
