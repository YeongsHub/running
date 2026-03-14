import 'package:run_territory/domain/entities/run_stats.dart';
import 'package:run_territory/domain/repositories/run_repository.dart';

class CalculateStats {
  final RunRepository _repository;

  CalculateStats(this._repository);

  Future<RunStats> call() => _repository.getStats();
}
