import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:run_territory/core/constants/map_constants.dart';
import 'package:run_territory/presentation/screens/map/map_providers.dart';
import 'package:run_territory/presentation/screens/map/widgets/territory_layer.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapController = ref.watch(mapControllerProvider);
    final positionAsync = ref.watch(currentPositionProvider);
    final territoriesAsync = ref.watch(territoriesProvider);

    positionAsync.whenData((pos) {
      mapController.move(LatLng(pos.latitude, pos.longitude), MapConstants.defaultZoom);
    });

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: const MapOptions(
              initialCenter: LatLng(37.5665, 126.9780), // 서울
              initialZoom: MapConstants.defaultZoom,
              minZoom: MapConstants.minZoom,
              maxZoom: MapConstants.maxZoom,
            ),
            children: [
              TileLayer(
                urlTemplate: MapConstants.osmTileUrl,
                userAgentPackageName: 'com.runningapp.run_territory',
              ),
              territoriesAsync.when(
                data: (territories) => TerritoryLayer(territories: territories),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              positionAsync.when(
                data: (pos) => MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(pos.latitude, pos.longitude),
                      width: 20,
                      height: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read(locationServiceProvider).startTracking();
        },
        icon: const Icon(Icons.directions_run),
        label: const Text('달리기 시작'),
      ),
    );
  }
}
