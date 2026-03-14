import 'package:run_territory/data/models/gps_point_model.dart';
import 'package:run_territory/data/models/run_session_model.dart';
import 'package:run_territory/data/sources/local/run_local_source.dart';
import 'package:run_territory/domain/entities/run_session.dart';
import 'package:run_territory/domain/entities/run_stats.dart';
import 'package:run_territory/domain/repositories/run_repository.dart';

class RunRepositoryImpl implements RunRepository {
  final RunLocalSource _source;

  RunRepositoryImpl(this._source);

  @override
  Future<void> saveSession(RunSession session) async {
    final model = RunSessionModel(
      id: session.id, startedAt: session.startedAt, endedAt: session.endedAt,
      status: session.status, path: session.path,
      totalDistance: session.totalDistance, totalDuration: session.totalDuration,
    );
    await _source.insertSession(model);
    if (session.path.isNotEmpty) {
      final points = session.path.map((p) => GpsPointModel.fromEntity(p, session.id)).toList();
      await _source.insertGpsPoints(points);
    }
  }

  @override
  Future<RunSession?> getSessionById(String id) => _source.getSessionById(id);

  @override
  Future<List<RunSession>> getAllSessions() => _source.getAllSessions();

  @override
  Future<RunStats> getStats() async {
    final sessions = await _source.getAllSessions();
    if (sessions.isEmpty) return RunStats.empty;
    final totalDistance = sessions.fold(0.0, (sum, s) => sum + s.totalDistance) / 1000;
    final totalDuration = sessions.fold(Duration.zero, (sum, s) => sum + s.totalDuration);
    final bestPace = sessions.where((s) => s.avgPace > 0).fold(
        double.infinity, (best, s) => s.avgPace < best ? s.avgPace : best);
    final longestRun = sessions.fold(0.0, (max, s) => s.totalDistance > max ? s.totalDistance : max) / 1000;
    return RunStats(
      totalRuns: sessions.length,
      totalDistanceKm: totalDistance,
      totalDuration: totalDuration,
      totalAreaM2: 0,
      bestPace: bestPace == double.infinity ? 0 : bestPace,
      longestRunKm: longestRun,
    );
  }
}
