import 'package:run_territory/domain/entities/run_session.dart';
import 'package:run_territory/domain/entities/run_stats.dart';

abstract class RunRepository {
  Future<void> saveSession(RunSession session);
  Future<RunSession?> getSessionById(String id);
  Future<List<RunSession>> getAllSessions();
  Future<RunStats> getStats();
}
