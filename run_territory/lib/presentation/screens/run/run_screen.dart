import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:run_territory/core/constants/map_constants.dart';
import 'package:run_territory/core/utils/geo_utils.dart';
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
  final _mapController = MapController();
  bool _mapInitialized = false;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

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
    final userColor = ref.watch(userColorProvider);

    // 달리는 중 경로로 미리보기 폴리곤 생성 (최소 10포인트 이상)
    final previewPolygon = (session != null && session.path.length >= 10)
        ? GeoUtils.pathToEnclosedPolygon(session.path)
        : null;

    // 첫 위치 수신 시 지도 이동
    ref.listen(currentPositionProvider, (prev, next) {
      if (!_mapInitialized) {
        next.whenData((pos) {
          _mapInitialized = true;
          _mapController.move(LatLng(pos.latitude, pos.longitude), MapConstants.defaultZoom);
        });
      }
    });

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
                  mapController: _mapController,
                  options: const MapOptions(
                    initialCenter: LatLng(0, 0),
                    initialZoom: MapConstants.defaultZoom,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: MapConstants.osmTileUrl,
                      userAgentPackageName: 'com.gridnflow.rundone',
                    ),
                    if (session != null) RunPathLayer(path: session.path),
                    if (previewPolygon != null && previewPolygon.length >= 3)
                      PolygonLayer(
                        polygons: [
                          Polygon(
                            points: previewPolygon
                                .map((p) => LatLng(p.latitude, p.longitude))
                                .toList(),
                            color: userColor.withValues(alpha: 0.20),
                            borderColor: userColor.withValues(alpha: 0.5),
                            borderStrokeWidth: 1.5,
                          ),
                        ],
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
