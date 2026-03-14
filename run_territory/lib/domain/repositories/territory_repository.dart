import 'package:run_territory/domain/entities/territory.dart';

abstract class TerritoryRepository {
  Future<void> saveTerritory(Territory territory);
  Future<void> updateTerritory(Territory territory);
  Future<List<Territory>> getMyTerritories();
}
