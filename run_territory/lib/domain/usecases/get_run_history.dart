import 'package:run_territory/domain/entities/run_session.dart';
import 'package:run_territory/domain/repositories/run_repository.dart';

class GetRunHistory {
  final RunRepository _repository;

  GetRunHistory(this._repository);

  Future<List<RunSession>> call() => _repository.getAllSessions();
}
