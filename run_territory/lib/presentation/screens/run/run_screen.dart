import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:run_territory/core/constants/map_constants.dart';
import 'package:run_territory/presentation/screens/map/map_providers.dart';
import 'package:run_territory/presentation/screens/map/widgets/run_path_layer.dart';
import 'package:run_territory/presentation/screens/run/run_providers.dart';
import 'package:run_territory/presentation/screens/run/widgets/control_buttons.dart';
import 'package:run_territory/presentation/screens/run/widgets/stats_panel.dart';

class RunScreen extends ConsumerWidget {
  const RunScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(runSessionProvider);
    final positionAsync = ref.watch(currentPositionProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: positionAsync.when(
                  data: (p) => LatLng(p.latitude, p.longitude),
                  loading: () => const LatLng(37.5665, 126.9780),
                  error: (_, __) => const LatLng(37.5665, 126.9780),
                ),
                initialZoom: MapConstants.defaultZoom,
              ),
              children: [
                TileLayer(
                  urlTemplate: MapConstants.osmTileUrl,
                  userAgentPackageName: 'com.runningapp.run_territory',
                ),
                if (session != null) RunPathLayer(path: session.path),
                positionAsync.when(
                  data: (pos) => MarkerLayer(
                    markers: [Marker(
                      point: LatLng(pos.latitude, pos.longitude),
                      width: 20, height: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue, shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    )],
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          StatsPanel(session: session),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: const ControlButtons(),
          ),
        ],
      ),
    );
  }
}
