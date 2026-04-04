import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/domain/entities/run_session.dart';
import 'package:run_territory/l10n/app_localizations.dart';
import 'package:run_territory/presentation/screens/run/run_providers.dart';

class ControlButtons extends ConsumerWidget {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final session = ref.watch(runSessionProvider);
    final notifier = ref.read(runSessionProvider.notifier);
    final status = session?.status;

    if (status == null || status == RunStatus.idle) {
      return _BigButton(
        label: l.startRun,
        icon: Icons.play_arrow,
        color: Colors.green,
        onTap: notifier.startRun,
      );
    }

    // loopCompleted 상태에서는 버튼 숨김 (결과 화면으로 전환 중)
    if (status == RunStatus.loopCompleted) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (status == RunStatus.running)
          _BigButton(label: l.pause, icon: Icons.pause, color: Colors.orange, onTap: notifier.pauseRun)
        else
          _BigButton(label: l.resume, icon: Icons.play_arrow, color: Colors.green, onTap: notifier.resumeRun),
        _BigButton(
          label: l.stop,
          icon: Icons.stop,
          color: Colors.red,
          onTap: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(l.endRunTitle),
                content: Text(l.endRunMessage),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l.cancel)),
                  FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l.save)),
                ],
              ),
            );
            if (confirm == true) await notifier.stopAndSave();
          },
        ),
      ],
    );
  }
}

class _BigButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _BigButton({required this.label, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
