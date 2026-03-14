import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:run_territory/core/providers/app_providers.dart';
import 'package:run_territory/core/utils/format_utils.dart';
import 'package:run_territory/l10n/app_localizations.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final imperial = ref.watch(useImperialProvider);
    final historyAsync = ref.watch(runHistoryProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l.navHistory)),
      body: historyAsync.when(
        data: (sessions) {
          if (sessions.isEmpty) {
            return Center(child: Text(l.noRunsYet, textAlign: TextAlign.center));
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
                  title: Text(DateFormat('M/d (E)').format(s.startedAt)),
                  subtitle: Text('${FormatUtils.formatDistance(s.totalDistance, imperial: imperial)} · ${FormatUtils.formatDuration(s.totalDuration)}'),
                  trailing: Text(FormatUtils.formatPace(s.avgPace, imperial: imperial), style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l.errorMessage(e))),
      ),
    );
  }
}
