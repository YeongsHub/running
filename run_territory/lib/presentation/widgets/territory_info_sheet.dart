import 'package:flutter/material.dart';
import 'package:run_territory/core/utils/format_utils.dart';
import 'package:run_territory/domain/entities/territory.dart';
import 'package:intl/intl.dart';

class TerritoryInfoSheet extends StatelessWidget {
  final Territory territory;

  const TerritoryInfoSheet({super.key, required this.territory});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(width: 16, height: 16, color: territory.color),
            const SizedBox(width: 8),
            Text('내 영역', style: Theme.of(context).textTheme.titleLarge),
          ]),
          const SizedBox(height: 16),
          Text('면적: ${FormatUtils.formatArea(territory.areaM2)}'),
          Text('클레임 일시: ${DateFormat('yyyy-MM-dd HH:mm').format(territory.claimedAt)}'),
        ],
      ),
    );
  }
}
