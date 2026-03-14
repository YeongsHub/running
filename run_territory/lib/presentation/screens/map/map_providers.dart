import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/core/providers/app_providers.dart';
import 'package:run_territory/data/sources/gps/location_service.dart';
import 'package:run_territory/domain/entities/gps_point.dart';
import 'package:run_territory/domain/entities/territory.dart';

final locationServiceProvider = Provider<LocationService>((ref) {
  final service = LocationService();
  ref.onDispose(service.dispose);
  return service;
});

final currentPositionProvider = StreamProvider<GpsPoint>((ref) {
  return ref.watch(locationServiceProvider).positionStream;
});

final mapControllerProvider = Provider<MapController>((ref) => MapController());

final territoriesProvider = FutureProvider<List<Territory>>((ref) async {
  final useCase = ref.watch(getMyTerritoriesUseCaseProvider);
  return useCase.call();
});
