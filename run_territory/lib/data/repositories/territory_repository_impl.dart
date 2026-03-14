import 'package:run_territory/data/sources/local/territory_local_source.dart';
import 'package:run_territory/domain/entities/territory.dart';
import 'package:run_territory/domain/repositories/territory_repository.dart';
import 'package:run_territory/core/constants/app_constants.dart';

class TerritoryRepositoryImpl implements TerritoryRepository {
  final TerritoryLocalSource _source;

  TerritoryRepositoryImpl(this._source);

  @override
  Future<void> saveTerritory(Territory territory) => _source.insertTerritory(territory);

  @override
  Future<void> updateTerritory(Territory territory) => _source.updateTerritory(territory);

  @override
  Future<List<Territory>> getMyTerritories() =>
      _source.getTerritoriesByOwner(AppConstants.defaultUserId);
}
