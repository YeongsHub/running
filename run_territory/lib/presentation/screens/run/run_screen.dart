import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:run_territory/core/constants/map_constants.dart';
import 'package:run_territory/domain/entities/run_session.dart';
import 'package:run_territory/presentation/screens/map/map_providers.dart';
import 'package:run_territory/presentation/screens/map/widgets/run_path_layer.dart';
import 'package:run_territory/presentation/screens/run/run_complete_screen.dart';
import 'package:run_territory/presentation/screens/run/run_providers.dart';
import 'package:run_territory/presentation/screens/run/widgets/control_buttons.dart';
import 'package:run_territory/presentation/screens/run/widgets/stats_panel.dart';
import 'package:run_territory/presentation/screens/settings/settings_screen.dart';

class RunScreen extends ConsumerStatefulWidget {
  const RunScreen({super.key});

  @override
  ConsumerState<RunScreen> createState() => _RunScreenState();
}

class _RunScreenState extends ConsumerState<RunScreen> {
  bool _navigating = false;

  Future<void> _onLoopCompleted() async {
    if (_navigating) return;
    _navigating = true;

    HapticFeedback.heavyImpact();

    final color = ref.read(userColorProvider);
    final completed = await ref.read(runSessionProvider.notifier)
        .saveLoopCompleted(color: color);

    if (completed != null && mounted) {

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => RunCompleteScreen(session: completed),
        ),
      );
    }
    _navigating = false;
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(runSessionProvider);
    final positionAsync = ref.watch(currentPositionProvider);

    // loopCompleted 감지
    ref.listen<RunSession?>(runSessionProvider, (prev, next) {
      if (next?.status == RunStatus.loopCompleted &&
          prev?.status != RunStatus.loopCompleted) {
        _onLoopCompleted();
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          Column(
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
                      userAgentPackageName: 'com.gridnflow.rundone',
                    ),
                    if (session != null) RunPathLayer(path: session.path),
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
                                border:
                                    Border.all(color: Colors.white, width: 2),
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
              ),
              StatsPanel(session: session),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: ControlButtons(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
