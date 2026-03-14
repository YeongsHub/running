import 'package:flutter/material.dart';
import 'package:run_territory/core/utils/format_utils.dart';
import 'package:run_territory/domain/entities/run_session.dart';

class RunHud extends StatelessWidget {
  final RunSession session;

  const RunHud({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: Card(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(label: '거리', value: FormatUtils.formatDistance(session.totalDistance)),
              _StatItem(label: '시간', value: FormatUtils.formatDuration(session.totalDuration)),
              _StatItem(label: '페이스', value: FormatUtils.formatPace(session.avgPace)),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}
