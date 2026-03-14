import 'package:run_territory/domain/entities/run_session.dart';
import 'package:run_territory/domain/repositories/run_repository.dart';
import 'package:uuid/uuid.dart';

class StartRun {
  final RunRepository _repository;

  StartRun(this._repository);

  Future<RunSession> call() async {
    final session = RunSession(
      id: const Uuid().v4(),
      startedAt: DateTime.now(),
      status: RunStatus.running,
      path: const [],
      totalDistance: 0,
      totalDuration: Duration.zero,
    );
    await _repository.saveSession(session);
    return session;
  }
}
