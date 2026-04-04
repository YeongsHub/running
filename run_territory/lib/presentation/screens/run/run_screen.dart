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

class _RunScreenState extends ConsumerState<RunScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flashController;
  late final Animation<double> _flashAnimation;
  bool _navigating = false;

  @override
  void initState() {
    super.initState();
    _flashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _flashAnimation = Tween<double>(begin: 0.4, end: 0.0).animate(
      CurvedAnimation(parent: _flashController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _flashController.dispose();
    super.dispose();
  }

  Future<void> _onLoopCompleted() async {
    if (_navigating) return;
    _navigating = true;

    // 햅틱 피드백
    HapticFeedback.heavyImpact();

    // 화면 플래시
    _flashController.forward(from: 0);

    // territory 저장
    final color = ref.read(userColorProvider);
    final completed = await ref.read(runSessionProvider.notifier)
        .saveLoopCompleted(color: color);

    if (completed != null && mounted) {
      // 잠시 플래시가 보이도록 대기
      await Future.delayed(const Duration(milliseconds: 400));
      if (!mounted) return;

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
    final color = ref.watch(userColorProvider);

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
                      userAgentPackageName: 'com.runningapp.run_territory',
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
          // 유저 컬러 플래시 오버레이
          AnimatedBuilder(
            animation: _flashAnimation,
            builder: (context, _) => _flashAnimation.value > 0
                ? Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        color: color.withValues(alpha: _flashAnimation.value),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
