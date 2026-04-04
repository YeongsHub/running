import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:run_territory/app.dart';
import 'package:run_territory/core/constants/map_constants.dart';
import 'package:run_territory/core/providers/app_providers.dart';
import 'package:run_territory/core/utils/format_utils.dart';
import 'package:run_territory/core/utils/geo_utils.dart';
import 'package:run_territory/domain/entities/run_session.dart';
import 'package:run_territory/l10n/app_localizations.dart';
import 'package:run_territory/presentation/screens/map/map_providers.dart';
import 'package:run_territory/presentation/screens/run/run_providers.dart';
import 'package:run_territory/presentation/screens/settings/settings_screen.dart';

class RunCompleteScreen extends ConsumerWidget {
  final RunSession session;

  const RunCompleteScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final imperial = ref.watch(useImperialProvider);
    final color = ref.watch(userColorProvider);

    final polygon = GeoUtils.pathToEnclosedPolygon(session.path);
    final areaM2 = GeoUtils.calculateAreaM2(polygon);

    // 폴리곤 중심점 계산
    final centerLat =
        polygon.map((p) => p.latitude).reduce((a, b) => a + b) /
            polygon.length;
    final centerLng =
        polygon.map((p) => p.longitude).reduce((a, b) => a + b) /
            polygon.length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // 제목
            Icon(Icons.emoji_events, size: 48, color: color),
            const SizedBox(height: 12),
            Text(
              l.territoryClaimed,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            // 미니 지도
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(centerLat, centerLng),
                      initialZoom: 16,
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.none,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: MapConstants.osmTileUrl,
                        userAgentPackageName:
                            'com.gridnflow.rundone',
                      ),
                      // 폴리곤 (territory)
                      PolygonLayer(
                        polygons: [
                          Polygon(
                            points: polygon
                                .map((p) =>
                                    LatLng(p.latitude, p.longitude))
                                .toList(),
                            color: color.withValues(alpha: 0.3),
                            borderColor: color,
                            borderStrokeWidth: 2.0,
                          ),
                        ],
                      ),
                      // 폴리라인 (경로)
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: session.path
                                .map((p) =>
                                    LatLng(p.latitude, p.longitude))
                                .toList(),
                            strokeWidth: 3.0,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 통계
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(
                    label: l.distance,
                    value: FormatUtils.formatDistance(
                        session.totalDistance,
                        imperial: imperial),
                  ),
                  _StatItem(
                    label: l.time,
                    value: FormatUtils.formatDuration(
                        session.totalDuration),
                  ),
                  _StatItem(
                    label: imperial ? l.paceUnitImperial : l.paceUnit,
                    value: FormatUtils.formatPace(session.avgPace,
                        imperial: imperial),
                  ),
                  _StatItem(
                    label: l.areaLabel,
                    value: FormatUtils.formatArea(areaM2,
                        imperial: imperial),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 완료 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    ref.read(runSessionProvider.notifier).clearSession();
                    ref.invalidate(territoriesProvider);
                    ref.invalidate(runHistoryProvider);
                    ref.invalidate(statsProvider);
                    Navigator.of(context).pop();
                    ref.read(selectedTabProvider.notifier).state = 0;
                  },
                  child: Text(l.done,
                      style: const TextStyle(fontSize: 18)),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
