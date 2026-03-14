# Territory Running Game - Architecture & Implementation Plan

## 1. 현재 코드 문제점

### 1.1 루프 감지 없음
- 현재 `RunSessionNotifier.stopAndSave()`에서 정지 버튼을 누를 때 무조건 Territory 생성
- 루프(폐합 경로) 여부를 확인하지 않음
- 스펙: 현재 위치가 시작점에서 **10m 이내**로 돌아오면 루프 완성 → 자동 Territory 생성

### 1.2 pathToPolygon이 버퍼링 방식
- `geo_utils.dart`의 `pathToPolygon()`이 경로 좌우 5m 버퍼 확장 방식
- 스펙: 루프 경로 자체가 폴리곤이므로 별도 버퍼 불필요
- `pathToEnclosedPolygon()` 함수로 교체 필요

### 1.3 Home Screen 없음
- 현재 탭: 지도, 달리기, 기록, 프로필 (4탭)
- 스펙: Home, 지도, 달리기, 기록, 설정 (5탭)

### 1.4 Settings Screen 없음
- 스펙: 지도 스타일, 사용자 색상, 단위 설정 화면 필요

### 1.5 flutter analyze 에러 목록
1. `test/widget_test.dart:16` — `MyApp` 참조 → `RunTerritoryApp`으로 변경 필요
2. `territory_layer.dart:16` — `withOpacity(0.3)` deprecated → `withValues(alpha: 0.3)` 사용
3. `territory_local_source.dart:19` — `color.value` deprecated → `color.toARGB32()` 사용
4. `map_screen.dart:7` — `run_path_layer.dart` unused import 제거

---

## 2. 변경사항 목록

### 2.1 geo_utils.dart — `detectLoop()` 함수 추가

```dart
/// 루프 감지: 마지막 포인트가 첫 포인트에서 thresholdMeters 이내인지 확인
/// 최소 20포인트 이상이어야 유효 (너무 짧은 루프 방지)
static bool detectLoop(List<GpsPoint> path, {double thresholdMeters = 10.0}) {
  if (path.length < 20) return false;
  final first = path.first;
  final last = path.last;
  final distance = haversineDistance(first, last);
  return distance <= thresholdMeters;
}
```

### 2.2 geo_utils.dart — `pathToEnclosedPolygon()` 함수 추가

```dart
/// 루프 경로를 폐합 폴리곤으로 변환
/// Douglas-Peucker(simplifyPath)로 단순화 후 반환
static List<GpsPoint> pathToEnclosedPolygon(List<GpsPoint> path) {
  if (path.length < 3) return path;
  final simplified = simplifyPath(path, epsilon: 3.0);
  // 마지막 점을 첫 점과 동일하게 폐합
  if (simplified.length >= 3) {
    final closed = List<GpsPoint>.from(simplified);
    if (haversineDistance(closed.first, closed.last) > 0.1) {
      closed.add(closed.first);
    }
    return closed;
  }
  return simplified;
}
```

### 2.3 run_providers.dart — 루프 감지 로직 추가

`_onPosition()` 메서드에서 GPS 포인트 추가 후 `detectLoop` 호출:

```dart
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

  // 루프 감지: 시작점으로 돌아왔는지 확인
  if (GeoUtils.detectLoop(newPath)) {
    _onLoopDetected();
  }
}

void _onLoopDetected() {
  stopAndClaim();
}

Future<void> stopAndClaim() async {
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

  if (completed.path.length >= 20) {
    await _ref.read(claimTerritoryUseCaseProvider).call(
      path: completed.path,
      sessionId: completed.id,
    );
  }

  state = null;
}
```

기존 `stopAndSave()` 메서드는 `stopAndClaim()`으로 이름 변경하여 통합.

**필요한 import 추가:**
```dart
import 'package:run_territory/core/utils/geo_utils.dart';
```

### 2.4 claim_territory.dart — pathToEnclosedPolygon 사용

```dart
// 변경 전:
final polygon = GeoUtils.pathToPolygon(path, bufferMeters: 5.0);

// 변경 후:
final polygon = GeoUtils.pathToEnclosedPolygon(path);
```

또한 최소 경로 길이 조건 강화:
```dart
// 변경 전:
if (path.length < 2) return null;

// 변경 후:
if (path.length < 20) return null;
```

### 2.5 app.dart — 5탭 구성으로 확장

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/core/theme/app_theme.dart';
import 'package:run_territory/presentation/screens/home/home_screen.dart';
import 'package:run_territory/presentation/screens/map/map_screen.dart';
import 'package:run_territory/presentation/screens/run/run_screen.dart';
import 'package:run_territory/presentation/screens/history/history_screen.dart';
import 'package:run_territory/presentation/screens/settings/settings_screen.dart';

final selectedTabProvider = StateProvider<int>((ref) => 0);

class RunTerritoryApp extends ConsumerWidget {
  const RunTerritoryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Run Territory',
      theme: AppTheme.light,
      home: const MainShell(),
    );
  }
}

class MainShell extends ConsumerWidget {
  const MainShell({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    MapScreen(),
    RunScreen(),
    HistoryScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTabProvider);
    return Scaffold(
      body: IndexedStack(
        index: selectedTab,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,
        onDestinationSelected: (index) =>
            ref.read(selectedTabProvider.notifier).state = index,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: '홈'),
          NavigationDestination(icon: Icon(Icons.map), label: '지도'),
          NavigationDestination(icon: Icon(Icons.directions_run), label: '달리기'),
          NavigationDestination(icon: Icon(Icons.history), label: '기록'),
          NavigationDestination(icon: Icon(Icons.settings), label: '설정'),
        ],
      ),
    );
  }
}
```

### 2.6 새 파일: `presentation/screens/home/home_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/core/providers/app_providers.dart';
import 'package:run_territory/presentation/screens/run/run_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final territories = ref.watch(getMyTerritoriesUseCaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Run Territory'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 달리기 시작 버튼
            ElevatedButton.icon(
              onPressed: () {
                ref.read(runSessionProvider.notifier).startRun();
                // 달리기 탭(index 2)으로 이동
                ref.read(selectedTabProvider.notifier).state = 2;
              },
              icon: const Icon(Icons.directions_run, size: 32),
              label: const Text('달리기 시작', style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // 빠른 통계
            const Text('내 Territory', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            FutureBuilder(
              future: territories.call(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final list = snapshot.data!;
                final totalArea = list.fold<double>(0, (sum, t) => sum + t.areaM2);
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _StatRow(label: '총 Territory', value: '${list.length}개'),
                        const Divider(),
                        _StatRow(
                          label: '총 면적',
                          value: totalArea >= 1000000
                              ? '${(totalArea / 1000000).toStringAsFixed(2)} km²'
                              : '${totalArea.toStringAsFixed(0)} m²',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// selectedTabProvider는 app.dart에서 import
import 'package:run_territory/app.dart' show selectedTabProvider;

class _StatRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
```

### 2.7 새 파일: `presentation/screens/settings/settings_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/core/constants/app_constants.dart';

// 사용자 색상 설정 Provider
final userColorProvider = StateProvider<Color>((ref) => AppConstants.defaultUserColors[0]);

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(userColorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Territory 색상 선택
          const Text('Territory 색상', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: AppConstants.defaultUserColors.map((color) {
              final isSelected = selectedColor.toARGB32() == color.toARGB32();
              return GestureDetector(
                onTap: () => ref.read(userColorProvider.notifier).state = color,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, color: Colors.white)
                      : null,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          // 단위 설정
          const Text('단위', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ListTile(
            title: const Text('거리 단위'),
            subtitle: const Text('km / miles'),
            trailing: const Text('km'),
            onTap: () {
              // TODO: 단위 변경 구현
            },
          ),
        ],
      ),
    );
  }
}
```

### 2.8 app_constants.dart — 기본 사용자 색상 목록 추가

```dart
import 'dart:ui';

class AppConstants {
  static const String appName = 'Run Territory';
  static const String dbName = 'run_territory.db';
  static const int dbVersion = 1;
  static const String defaultUserId = 'local_user';
  static const Color defaultTerritoryColor = Color(0x4D2E7D32);

  /// 사용자가 선택 가능한 Territory 색상 목록
  static const List<Color> defaultUserColors = [
    Color(0xFF2E7D32), // Green
    Color(0xFF1565C0), // Blue
    Color(0xFFC62828), // Red
    Color(0xFFEF6C00), // Orange
    Color(0xFF6A1B9A), // Purple
    Color(0xFF00838F), // Teal
    Color(0xFFAD1457), // Pink
    Color(0xFF4E342E), // Brown
  ];
}
```

### 2.9 flutter analyze 에러 수정

#### test/widget_test.dart
```dart
// 변경 전:
await tester.pumpWidget(const MyApp());

// 변경 후:
await tester.pumpWidget(const ProviderScope(child: RunTerritoryApp()));

// import도 변경:
// 변경 전:
import 'package:run_territory/main.dart';
// 변경 후:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/app.dart';
```

#### territory_layer.dart:16
```dart
// 변경 전:
color: t.color.withOpacity(0.3),

// 변경 후:
color: t.color.withValues(alpha: 0.3),
```

#### territory_local_source.dart:19
```dart
// 변경 전:
'color_hex': '#${territory.color.value.toRadixString(16).padLeft(8, '0')}',

// 변경 후:
'color_hex': '#${territory.color.toARGB32().toRadixString(16).padLeft(8, '0')}',
```

#### map_screen.dart:7 — unused import 제거
```dart
// 삭제:
import 'package:run_territory/presentation/screens/map/widgets/run_path_layer.dart';
```

---

## 3. 파일별 변경 요약

| 파일 | 변경 유형 | 내용 |
|------|-----------|------|
| `lib/core/utils/geo_utils.dart` | 수정 | `detectLoop()`, `pathToEnclosedPolygon()` 추가 |
| `lib/domain/usecases/claim_territory.dart` | 수정 | `pathToPolygon` → `pathToEnclosedPolygon`, 최소 길이 20 |
| `lib/presentation/screens/run/run_providers.dart` | 수정 | 루프 감지 로직, `stopAndSave` → `stopAndClaim`, GeoUtils import |
| `lib/app.dart` | 수정 | 5탭 구성 (Home, Map, Run, History, Settings) |
| `lib/core/constants/app_constants.dart` | 수정 | `defaultUserColors` 목록 추가 |
| `lib/presentation/screens/home/home_screen.dart` | **신규** | Home Screen |
| `lib/presentation/screens/settings/settings_screen.dart` | **신규** | Settings Screen |
| `test/widget_test.dart` | 수정 | `MyApp` → `RunTerritoryApp` + ProviderScope |
| `lib/presentation/screens/map/widgets/territory_layer.dart` | 수정 | `withOpacity` → `withValues` |
| `lib/data/sources/local/territory_local_source.dart` | 수정 | `.value` → `.toARGB32()` |
| `lib/presentation/screens/map/map_screen.dart` | 수정 | unused import 제거 |
