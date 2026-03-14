import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/app.dart';
import 'package:run_territory/core/utils/format_utils.dart';
import 'package:run_territory/presentation/screens/profile/profile_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(statsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Territory Run')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            // 메인 시작 버튼
            FilledButton.icon(
              onPressed: () => ref.read(selectedTabProvider.notifier).state = 2,
              icon: const Icon(Icons.directions_run, size: 28),
              label: const Text('달리기 시작', style: TextStyle(fontSize: 18)),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
            ),
            const SizedBox(height: 32),
            Text('내 기록', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            statsAsync.when(
              data: (stats) => Column(
                children: [
                  _QuickStat(label: '총 달리기', value: '${stats.totalRuns}회'),
                  const SizedBox(height: 8),
                  _QuickStat(label: '총 거리', value: '${stats.totalDistanceKm.toStringAsFixed(1)}km'),
                  const SizedBox(height: 8),
                  _QuickStat(label: '확보 영역', value: FormatUtils.formatArea(stats.totalAreaM2)),
                ],
              ),
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text('통계 로드 실패'),
            ),
          ],
        ),
      ),
    );
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
