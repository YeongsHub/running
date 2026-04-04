import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:run_territory/app.dart';
import 'package:run_territory/core/providers/app_providers.dart';
import 'package:run_territory/core/theme/app_theme.dart';
import 'package:run_territory/core/utils/format_utils.dart';
import 'package:run_territory/l10n/app_localizations.dart';
import 'package:run_territory/presentation/screens/settings/settings_screen.dart';

// runHistoryProvider 결과를 재사용 — DB 중복 쿼리 방지
final dailyDistanceProvider = FutureProvider<Map<DateTime, double>>((ref) async {
  final sessions = await ref.watch(runHistoryProvider.future);
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
    final imperial = ref.watch(useImperialProvider);
    final statsAsync = ref.watch(statsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context, ref)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 20),
                _buildStartButton(context, ref, l),
                const SizedBox(height: 28),
                const _SectionHeader(title: 'Activity'),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: const RunContributionGraph(),
                  ),
                ),
                const SizedBox(height: 28),
                _SectionHeader(title: l.myStats),
                const SizedBox(height: 12),
                statsAsync.when(
                  data: (stats) => _buildStatsRow(context, l, stats, imperial),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (_, __) => Text(l.statsLoadFailed),
                ),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 16,
        bottom: 20,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.primaryViolet, AppTheme.primaryVioletDark],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Territory Run',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Claim your ground',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => ref.read(selectedTabProvider.notifier).state = 4,
            child: const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white24,
              child: Icon(Icons.settings, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton(BuildContext context, WidgetRef ref, AppLocalizations l) {
    return GestureDetector(
      onTap: () => ref.read(selectedTabProvider.notifier).state = 2,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 90,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppTheme.primaryViolet, AppTheme.primaryVioletDark],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryViolet.withValues(alpha: 0.45),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.directions_run, color: Colors.white, size: 36),
            const SizedBox(width: 14),
            Text(
              l.startRun,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(
    BuildContext context,
    AppLocalizations l,
    dynamic stats,
    bool imperial,
  ) {
    return Row(
      children: [
        Expanded(
          child: _CompactStatCard(
            label: l.totalRuns,
            value: l.totalRunsValue(stats.totalRuns),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _CompactStatCard(
            label: l.totalDistance,
            value: FormatUtils.formatTotalDistance(stats.totalDistanceKm, imperial: imperial),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _CompactStatCard(
            label: l.totalArea,
            value: FormatUtils.formatArea(stats.totalAreaM2, imperial: imperial),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: AppTheme.primaryViolet,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(title, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

class _CompactStatCard extends StatelessWidget {
  final String label;
  final String value;
  const _CompactStatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: AppTheme.primaryViolet.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.grey[600],
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              value,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryViolet,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class RunContributionGraph extends ConsumerWidget {
  const RunContributionGraph({super.key});

  static const int _weeks = 16;
  static const double _cellSize = 12.0;
  static const double _cellGap = 4.0;

  static Color _cellColor(double km, Color base) {
    if (km == 0) return AppTheme.surfaceContainerHighest;
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
            Text('Activity', style: Theme.of(context).textTheme.labelMedium),
            Row(
              children: [
                Text('0km', style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(width: 4),
                ...[0.0, 0.25, 0.5, 0.75, 1.0].map((alpha) => Container(
                      width: _cellSize,
                      height: _cellSize,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: alpha == 0
                            ? AppTheme.surfaceContainerHighest
                            : baseColor.withValues(alpha: alpha),
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
          loading: () => const SizedBox(
              height: 100, child: Center(child: CircularProgressIndicator())),
          error: (_, __) => const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildGrid(
      BuildContext context, Map<DateTime, double> dailyKm, Color baseColor) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final daysBack = (todayDate.weekday - 1) + (_weeks - 1) * 7;
    final startDate = todayDate.subtract(Duration(days: daysBack));

    final monthLabels = <int, String>{};
    for (int w = 0; w < _weeks; w++) {
      final weekStart = startDate.add(Duration(days: w * 7));
      final weekEnd = weekStart.add(const Duration(days: 6));
      if (w == 0 || weekStart.month != weekEnd.month || weekStart.day <= 7) {
        final date = w == 0 ? weekStart : weekEnd;
        if (w == 0 ||
            monthLabels.isEmpty ||
            monthLabels.values.last != _monthLabel(date)) {
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
          Column(
            children: [
              SizedBox(height: _cellSize + _cellGap),
              ...List.generate(7, (i) => SizedBox(
                    height: _cellSize + _cellGap,
                    child: Text(dayLabels[i],
                        style: Theme.of(context).textTheme.labelSmall),
                  )),
            ],
          ),
          const SizedBox(width: _cellGap),
          ...List.generate(_weeks, (w) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: _cellSize + _cellGap,
                  child: monthLabels.containsKey(w)
                      ? Text(monthLabels[w]!,
                          style: Theme.of(context).textTheme.labelSmall)
                      : null,
                ),
                ...List.generate(7, (d) {
                  final date = startDate.add(Duration(days: w * 7 + d));
                  final isFuture = date.isAfter(todayDate);
                  final km = isFuture ? 0.0 : (dailyKm[date] ?? 0.0);
                  return Tooltip(
                    message:
                        '${date.month}/${date.day}  ${km > 0 ? "${km.toStringAsFixed(1)}km" : ""}',
                    child: Container(
                      width: _cellSize,
                      height: _cellSize,
                      margin: const EdgeInsets.all(_cellGap / 2),
                      decoration: BoxDecoration(
                        color: isFuture
                            ? Colors.transparent
                            : _cellColor(km, baseColor),
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

  static String _monthLabel(DateTime date) => DateFormat('MMM').format(date);
}
