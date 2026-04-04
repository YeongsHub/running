import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:run_territory/core/constants/map_constants.dart';
import 'package:run_territory/core/providers/app_providers.dart';
import 'package:run_territory/domain/entities/gps_point.dart';
import 'package:run_territory/domain/entities/run_session.dart';
import 'package:run_territory/l10n/app_localizations.dart';
import 'package:run_territory/presentation/screens/friends/friends_screen.dart';
import 'package:run_territory/presentation/screens/map/map_providers.dart';
import 'package:run_territory/presentation/screens/map/widgets/territory_layer.dart';
import 'package:run_territory/presentation/screens/settings/settings_screen.dart';
import 'package:uuid/uuid.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final mapController = ref.watch(mapControllerProvider);
    final positionAsync = ref.watch(currentPositionProvider);
    final territoriesAsync = ref.watch(territoriesProvider);
    final userColor = ref.watch(userColorProvider);

    positionAsync.whenData((pos) {
      mapController.move(LatLng(pos.latitude, pos.longitude), MapConstants.defaultZoom);
    });

    final isProAsync = ref.watch(isProProvider);
    final isPro = isProAsync.valueOrNull ?? false;
    final friendsAsync = ref.watch(friendsProvider);
    final friends = friendsAsync.valueOrNull ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(l.navMap),
        actions: [
          if (isPro)
            IconButton(
              icon: const Icon(Icons.group),
              tooltip: 'Friends',
              onPressed: () => FriendsScreen.show(context),
            ),
        ],
      ),
      floatingActionButton: kDebugMode
          ? FloatingActionButton.extended(
              onPressed: () => _injectMockTerritory(context, ref),
              icon: const Icon(Icons.bug_report),
              label: const Text('Demo Loop'),
            )
          : null,
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: const MapOptions(
              initialCenter: LatLng(37.5665, 126.9780),
              initialZoom: MapConstants.defaultZoom,
              minZoom: MapConstants.minZoom,
              maxZoom: MapConstants.maxZoom,
            ),
            children: [
              TileLayer(
                urlTemplate: MapConstants.osmTileUrl,
                userAgentPackageName: 'com.gridnflow.rundone',
              ),
              territoriesAsync.when(
                data: (territories) => TerritoryLayer(territories: territories, colorOverride: userColor),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              if (isPro && friends.isNotEmpty)
                PolygonLayer(
                  polygons: friends.expand((f) => f.territories.map((t) {
                    final c = f.color;
                    return Polygon(
                      points: t.polygon.map((p) => LatLng(p[0], p[1])).toList(),
                      color: c.withValues(alpha: 0.25),
                      borderColor: c,
                      borderStrokeWidth: 2.0,
                    );
                  })).toList(),
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
          // 줌 버튼
          Positioned(
            right: 12,
            bottom: 90,
            child: Column(
              children: [
                _ZoomButton(
                  icon: Icons.add,
                  onTap: () => mapController.move(
                    mapController.camera.center,
                    (mapController.camera.zoom + 1).clamp(MapConstants.minZoom, MapConstants.maxZoom),
                  ),
                ),
                const SizedBox(height: 4),
                _ZoomButton(
                  icon: Icons.remove,
                  onTap: () => mapController.move(
                    mapController.camera.center,
                    (mapController.camera.zoom - 1).clamp(MapConstants.minZoom, MapConstants.maxZoom),
                  ),
                ),
              ],
            ),
          ),
          // 내 위치로 이동 버튼
          Positioned(
            right: 12,
            bottom: 12,
            child: _ZoomButton(
              icon: Icons.my_location,
              onTap: () => positionAsync.whenData((pos) {
                mapController.move(LatLng(pos.latitude, pos.longitude), MapConstants.defaultZoom);
              }),
            ),
          ),
        ],
      ),
    );
  }

  /// 목 GPS 루프 데이터를 생성하고 territory를 클레임하는 디버그 기능
  Future<void> _injectMockTerritory(BuildContext context, WidgetRef ref) async {
    final mapController = ref.read(mapControllerProvider);
    final color = ref.read(userColorProvider);

    // 경복궁 주변 사각형 루프 (약 400m × 300m)
    const centerLat = 37.5796;
    const centerLng = 126.9770;
    const latOffset = 0.0015; // ~167m
    const lngOffset = 0.0020; // ~177m

    final now = DateTime.now();
    final corners = [
      (centerLat + latOffset, centerLng - lngOffset), // 북서
      (centerLat + latOffset, centerLng + lngOffset), // 북동
      (centerLat - latOffset, centerLng + lngOffset), // 남동
      (centerLat - latOffset, centerLng - lngOffset), // 남서
    ];

    // 각 변을 따라 GPS 포인트를 생성 (총 ~80포인트 → 루프 감지 조건 충족)
    final path = <GpsPoint>[];
    const pointsPerSide = 20;
    var sec = 0;
    for (int side = 0; side < 4; side++) {
      final from = corners[side];
      final to = corners[(side + 1) % 4];
      for (int i = 0; i < pointsPerSide; i++) {
        final t = i / pointsPerSide;
        path.add(GpsPoint(
          latitude: from.$1 + (to.$1 - from.$1) * t,
          longitude: from.$2 + (to.$2 - from.$2) * t,
          accuracy: 5.0,
          speed: 3.0,
          timestamp: now.add(Duration(seconds: sec++)),
        ));
      }
    }
    // 루프를 닫기 위해 시작점 근처로 복귀
    path.add(path.first.copyWith(timestamp: now.add(Duration(seconds: sec))));

    // 런 세션 저장
    final sessionId = const Uuid().v4();
    final session = RunSession(
      id: sessionId,
      startedAt: now,
      endedAt: now.add(Duration(seconds: sec)),
      status: RunStatus.completed,
      path: path,
      totalDistance: _calculateTotalDistance(path),
      totalDuration: Duration(seconds: sec),
    );
    await ref.read(runRepositoryProvider).saveSession(session);

    // ClaimTerritoryUseCase로 territory 생성
    final territory = await ref.read(claimTerritoryUseCaseProvider).call(
      path: path,
      sessionId: sessionId,
      color: color,
    );

    // providers 갱신
    ref.invalidate(territoriesProvider);
    ref.invalidate(runHistoryProvider);
    ref.invalidate(statsProvider);

    // 지도를 새 territory 중심으로 이동
    mapController.move(const LatLng(centerLat, centerLng), 16);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(territory != null
              ? 'Demo territory claimed! (${territory.areaM2.toStringAsFixed(0)} m²)'
              : 'Territory creation failed'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  static double _calculateTotalDistance(List<GpsPoint> path) {
    double total = 0;
    for (int i = 1; i < path.length; i++) {
      total += path[i - 1].distanceTo(path[i]);
    }
    return total;
  }
}

class _ZoomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ZoomButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, size: 22),
        ),
      ),
    );
  }
}
