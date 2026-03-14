import 'package:flutter/material.dart';
import 'package:run_territory/core/utils/format_utils.dart';
import 'package:run_territory/domain/entities/run_session.dart';
import 'package:run_territory/l10n/app_localizations.dart';

class StatsPanel extends StatelessWidget {
  final RunSession? session;

  const StatsPanel({super.key, this.session});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: const Offset(0, -2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatCol(label: l.distance, value: FormatUtils.formatDistance(session?.totalDistance ?? 0)),
          _Divider(),
          _StatCol(label: l.time, value: FormatUtils.formatDuration(session?.totalDuration ?? Duration.zero)),
          _Divider(),
          _StatCol(label: l.pace, value: FormatUtils.formatPace(session?.avgPace ?? 0)),
        ],
      ),
    );
  }
}

class _StatCol extends StatelessWidget {
  final String label;
  final String value;

  const _StatCol({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(height: 40, width: 1, color: Colors.grey.shade300);
}
