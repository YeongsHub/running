import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/core/providers/app_providers.dart';
import 'package:run_territory/domain/entities/gps_point.dart';
import 'package:run_territory/domain/entities/run_session.dart';
import 'package:run_territory/core/utils/geo_utils.dart';
import 'package:run_territory/presentation/screens/map/map_providers.dart';
import 'package:uuid/uuid.dart';

class RunSessionNotifier extends StateNotifier<RunSession?> {
  final Ref _ref;
  Timer? _timer;
  StreamSubscription<GpsPoint>? _gpsSub;
  GpsPoint? _lastPoint;
  Duration _elapsed = Duration.zero;
  double _distance = 0;

  RunSessionNotifier(this._ref) : super(null);

  void startRun() {
    final session = RunSession(
      id: const Uuid().v4(),
      startedAt: DateTime.now(),
      status: RunStatus.running,
      path: [],
      totalDistance: 0,
      totalDuration: Duration.zero,
    );
    state = session;
    _elapsed = Duration.zero;
    _distance = 0;

    _ref.read(locationServiceProvider).startTracking();
    _gpsSub = _ref.read(locationServiceProvider).positionStream.listen(_onPosition);

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state?.status == RunStatus.running) {
        _elapsed += const Duration(seconds: 1);
        state = state?.copyWith(totalDuration: _elapsed);
      }
    });
  }

  void _onPosition(GpsPoint point) {
    if (state?.status != RunStatus.running) return;
    if (_lastPoint != null) {
      final dist = point.distanceTo(_lastPoint!);
      _distance += dist;
    }
    _lastPoint = point;
    final newPath = <GpsPoint>[...(state?.path ?? []), point];
    state = state?.copyWith(
      path: newPath,
      totalDistance: _distance,
      totalDuration: _elapsed,
    );

    // 루프 감지: 시작점에서 10m 이내로 돌아오면 자동 종료
    if (GeoUtils.detectLoop(newPath)) {
      stopAndSave();
    }
  }

  void pauseRun() {
    state = state?.copyWith(status: RunStatus.paused);
  }

  void resumeRun() {
    state = state?.copyWith(status: RunStatus.running);
  }

  Future<void> stopAndSave() async {
    _timer?.cancel();
    _gpsSub?.cancel();
    _ref.read(locationServiceProvider).stopTracking();

    if (state == null) return;
    final completed = state!.copyWith(
      status: RunStatus.completed,
      endedAt: DateTime.now(),
    );
    state = completed;
    await _ref.read(runRepositoryProvider).saveSession(completed);

    if (completed.path.length >= 2) {
      await _ref.read(claimTerritoryUseCaseProvider).call(
        path: completed.path,
        sessionId: completed.id,
      );
    }

    state = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _gpsSub?.cancel();
    super.dispose();
  }
}

final runSessionProvider = StateNotifierProvider<RunSessionNotifier, RunSession?>((ref) {
  return RunSessionNotifier(ref);
});
