import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/app.dart';
import 'package:run_territory/core/providers/app_providers.dart';
import 'package:run_territory/core/utils/format_utils.dart';
import 'package:run_territory/l10n/app_localizations.dart';
import 'package:run_territory/presentation/screens/profile/profile_screen.dart';
import 'package:run_territory/presentation/screens/settings/settings_screen.dart';

// 날짜별 km 합산 Provider (최근 16주)
final dailyDistanceProvider = FutureProvider<Map<DateTime, double>>((ref) async {
  final sessions = await ref.watch(runRepositoryProvider).getAllSessions();
  final map = <DateTime, double>{};
  for (final s in sessions) {
    final day = DateTime(s.startedAt.year, s.startedAt.month, s.startedAt.day);
    map[day] = (map[day] ?? 0) + s.totalDistance / 1000;
  }
  return map;
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final statsAsync = ref.watch(statsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Territory Run')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: () => ref.read(selectedTabProvider.notifier).state = 2,
            icon: const Icon(Icons.directions_run, size: 28),
            label: Text(l.startRun, style: const TextStyle(fontSize: 18)),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
          ),
          const SizedBox(height: 24),
          // 잔디 그래프
          const RunContributionGraph(),
          const SizedBox(height: 24),
          Text(l.myStats, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          statsAsync.when(
            data: (stats) => Column(
              children: [
                _QuickStat(label: l.totalRuns, value: l.totalRunsValue(stats.totalRuns)),
                const SizedBox(height: 8),
                _QuickStat(label: l.totalDistance, value: '${stats.totalDistanceKm.toStringAsFixed(1)}km'),
                const SizedBox(height: 8),
                _QuickStat(label: l.totalArea, value: FormatUtils.formatArea(stats.totalAreaM2)),
              ],
            ),
            loading: () => const CircularProgressIndicator(),
            error: (_, __) => Text(l.statsLoadFailed),
          ),
        ],
      ),
    );
  }
}

class RunContributionGraph extends ConsumerWidget {
  const RunContributionGraph({super.key});

  static const int _weeks = 16;
  static const double _cellSize = 13.0;
  static const double _cellGap = 2.5;

  Color _cellColor(double km, Color base) {
    if (km == 0) return Colors.grey.shade200;
    if (km <= 5) return base.withValues(alpha: 0.25);
    if (km <= 10) return base.withValues(alpha: 0.5);
    if (km <= 15) return base.withValues(alpha: 0.75);
    return base;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyAsync = ref.watch(dailyDistanceProvider);
    final baseColor = ref.watch(userColorProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Activity', style: Theme.of(context).textTheme.titleMedium),
            // 범례
            Row(
              children: [
                Text('0km', style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(width: 4),
                ...[ 0.0, 0.25, 0.5, 0.75, 1.0 ].map((alpha) => Container(
                  width: _cellSize,
                  height: _cellSize,
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    color: alpha == 0 ? Colors.grey.shade200 : baseColor.withValues(alpha: alpha),
                    borderRadius: BorderRadius.circular(2),
                  ),
                )),
                const SizedBox(width: 4),
                Text('15km+', style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        dailyAsync.when(
          data: (dailyKm) => _buildGrid(context, dailyKm, baseColor),
          loading: () => const SizedBox(height: 100, child: Center(child: CircularProgressIndicator())),
          error: (_, __) => const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildGrid(BuildContext context, Map<DateTime, double> dailyKm, Color baseColor) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    // 오늘 기준으로 (weeks)주 전 월요일부터 시작
    final daysBack = (todayDate.weekday - 1) + (_weeks - 1) * 7;
    final startDate = todayDate.subtract(Duration(days: daysBack));

    // 월 라벨 계산 (어느 열에서 월이 바뀌는지)
    final monthLabels = <int, String>{};
    for (int w = 0; w < _weeks; w++) {
      final weekStart = startDate.add(Duration(days: w * 7));
      final weekEnd = weekStart.add(const Duration(days: 6));
      if (w == 0 || weekStart.month != weekEnd.month || weekStart.day <= 7) {
        final date = w == 0 ? weekStart : weekEnd;
        if (w == 0 || monthLabels.values.last != _monthLabel(date)) {
          monthLabels[w] = _monthLabel(date);
        }
      }
    }

    final dayLabels = ['M', '', 'W', '', 'F', '', ''];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 요일 라벨
          Column(
            children: [
              SizedBox(height: _cellSize + _cellGap), // 월 라벨 공간
              ...List.generate(7, (i) => SizedBox(
                height: _cellSize + _cellGap,
                child: Text(
                  dayLabels[i],
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              )),
            ],
          ),
          const SizedBox(width: 4),
          // 주 컬럼들
          ...List.generate(_weeks, (w) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 월 라벨
                SizedBox(
                  height: _cellSize + _cellGap,
                  child: monthLabels.containsKey(w)
                      ? Text(monthLabels[w]!, style: Theme.of(context).textTheme.labelSmall)
                      : null,
                ),
                // 7일 셀
                ...List.generate(7, (d) {
                  final date = startDate.add(Duration(days: w * 7 + d));
                  final isFuture = date.isAfter(todayDate);
                  final km = isFuture ? 0.0 : (dailyKm[date] ?? 0.0);

                  return Tooltip(
                    message: '${date.month}/${date.day}  ${km > 0 ? "${km.toStringAsFixed(1)}km" : ""}',
                    child: Container(
                      width: _cellSize,
                      height: _cellSize,
                      margin: const EdgeInsets.all(_cellGap / 2),
                      decoration: BoxDecoration(
                        color: isFuture ? Colors.transparent : _cellColor(km, baseColor),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ],
            );
          }),
        ],
      ),
    );
  }

  String _monthLabel(DateTime date) {
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return months[date.month - 1];
  }
}

class _QuickStat extends StatelessWidget {
  final String label;
  final String value;
  const _QuickStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(label),
        trailing: Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
