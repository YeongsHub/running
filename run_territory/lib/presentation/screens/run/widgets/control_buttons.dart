import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/domain/entities/run_session.dart';
import 'package:run_territory/presentation/screens/run/run_providers.dart';

class ControlButtons extends ConsumerWidget {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(runSessionProvider);
    final notifier = ref.read(runSessionProvider.notifier);
    final status = session?.status;

    if (status == null || status == RunStatus.idle) {
      return _BigButton(
        label: '달리기 시작',
        icon: Icons.play_arrow,
        color: Colors.green,
        onTap: notifier.startRun,
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (status == RunStatus.running)
          _BigButton(label: '일시정지', icon: Icons.pause, color: Colors.orange, onTap: notifier.pauseRun)
        else
          _BigButton(label: '재개', icon: Icons.play_arrow, color: Colors.green, onTap: notifier.resumeRun),
        _BigButton(
          label: '정지',
          icon: Icons.stop,
          color: Colors.red,
          onTap: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('달리기 종료'),
                content: const Text('달리기를 종료하고 영역을 저장할까요?'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('취소')),
                  FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('저장')),
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
