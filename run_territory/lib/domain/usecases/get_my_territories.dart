import 'package:run_territory/domain/entities/territory.dart';
import 'package:run_territory/domain/repositories/territory_repository.dart';

class GetMyTerritoriesUseCase {
  final TerritoryRepository _repo;
  GetMyTerritoriesUseCase(this._repo);
  Future<List<Territory>> call() => _repo.getMyTerritories();
}
