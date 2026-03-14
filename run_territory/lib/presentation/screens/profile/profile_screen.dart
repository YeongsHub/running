import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/core/providers/app_providers.dart';
import 'package:run_territory/core/utils/format_utils.dart';

final statsProvider = FutureProvider((ref) async {
  return ref.watch(runRepositoryProvider).getStats();
});

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(statsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('내 프로필')),
      body: statsAsync.when(
        data: (stats) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _StatCard(label: '총 달리기 횟수', value: '${stats.totalRuns}회', icon: Icons.directions_run),
            const SizedBox(height: 12),
            _StatCard(label: '총 달린 거리', value: '${stats.totalDistanceKm.toStringAsFixed(2)}km', icon: Icons.straighten),
            const SizedBox(height: 12),
            _StatCard(label: '총 달린 시간', value: FormatUtils.formatDuration(stats.totalDuration), icon: Icons.timer),
            const SizedBox(height: 12),
            _StatCard(label: '확보한 영역', value: FormatUtils.formatArea(stats.totalAreaM2), icon: Icons.map),
            const SizedBox(height: 12),
            _StatCard(label: '최고 페이스', value: FormatUtils.formatPace(stats.bestPace), icon: Icons.speed),
            const SizedBox(height: 12),
            _StatCard(label: '최장 달리기', value: '${stats.longestRunKm.toStringAsFixed(2)}km', icon: Icons.emoji_events),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류: $e')),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(label),
        trailing: Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
