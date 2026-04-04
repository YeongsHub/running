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

final currentPositionProvider = StreamProvider<GpsPoint>((ref) async* {
  final service = ref.watch(locationServiceProvider);

  // 즉시 현재 위치 한 번 가져와서 지도 초기 위치 설정
  final initial = await service.getCurrentPosition();
  if (initial != null) yield initial;

  // 이후 스트림으로 지속 업데이트 (달리기 중에만 흐름)
  await for (final point in service.positionStream) {
    yield point;
  }
});

final mapControllerProvider = Provider<MapController>((ref) => MapController());

final territoriesProvider = FutureProvider<List<Territory>>((ref) async {
  final useCase = ref.watch(getMyTerritoriesUseCaseProvider);
  return useCase.call();
});
