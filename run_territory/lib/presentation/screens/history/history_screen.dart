import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/core/providers/app_providers.dart';
import 'package:run_territory/core/utils/format_utils.dart';
import 'package:run_territory/domain/entities/run_session.dart';
import 'package:intl/intl.dart';

final runHistoryProvider = FutureProvider<List<RunSession>>((ref) async {
  return ref.watch(runRepositoryProvider).getAllSessions();
});

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(runHistoryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('기록')),
      body: historyAsync.when(
        data: (sessions) {
          if (sessions.isEmpty) {
            return const Center(child: Text('아직 달리기 기록이 없어요.\n달려서 땅을 차지해보세요!', textAlign: TextAlign.center));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: sessions.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) {
              final s = sessions[i];
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.directions_run)),
                  title: Text(DateFormat('M월 d일 (E)', 'ko').format(s.startedAt)),
                  subtitle: Text('${FormatUtils.formatDistance(s.totalDistance)} · ${FormatUtils.formatDuration(s.totalDuration)}'),
                  trailing: Text(FormatUtils.formatPace(s.avgPace), style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류: $e')),
      ),
    );
  }
}
