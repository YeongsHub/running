import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/data/repositories/run_repository_impl.dart';
import 'package:run_territory/data/repositories/territory_repository_impl.dart';
import 'package:run_territory/data/sources/local/database_helper.dart';
import 'package:run_territory/data/sources/local/run_local_source.dart';
import 'package:run_territory/data/sources/local/territory_local_source.dart';
import 'package:run_territory/domain/repositories/run_repository.dart';
import 'package:run_territory/domain/repositories/territory_repository.dart';
import 'package:run_territory/domain/usecases/claim_territory.dart';
import 'package:run_territory/domain/usecases/get_my_territories.dart';

final databaseHelperProvider = Provider<DatabaseHelper>((ref) => DatabaseHelper());

final runLocalSourceProvider = Provider<RunLocalSource>((ref) {
  return RunLocalSource(ref.watch(databaseHelperProvider));
});

final runRepositoryProvider = Provider<RunRepository>((ref) {
  return RunRepositoryImpl(ref.watch(runLocalSourceProvider));
});

final territoryLocalSourceProvider = Provider<TerritoryLocalSource>((ref) {
  return TerritoryLocalSource(ref.watch(databaseHelperProvider));
});

final territoryRepositoryProvider = Provider<TerritoryRepository>((ref) {
  return TerritoryRepositoryImpl(ref.watch(territoryLocalSourceProvider));
});

final claimTerritoryUseCaseProvider = Provider<ClaimTerritoryUseCase>((ref) {
  return ClaimTerritoryUseCase(ref.watch(territoryRepositoryProvider));
});

final getMyTerritoriesUseCaseProvider = Provider<GetMyTerritoriesUseCase>((ref) {
  return GetMyTerritoriesUseCase(ref.watch(territoryRepositoryProvider));
});
