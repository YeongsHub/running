import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 사용자 색상 선택 Provider
final userColorProvider = StateProvider<Color>((ref) => const Color(0xFF2E7D32));

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const List<Color> availableColors = [
    Color(0xFF2E7D32), // 초록
    Color(0xFF1565C0), // 파랑
    Color(0xFFC62828), // 빨강
    Color(0xFF6A1B9A), // 보라
    Color(0xFFE65100), // 주황
    Color(0xFF00838F), // 청록
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(userColorProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('내 영역 색상', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children: availableColors.map((color) => GestureDetector(
              onTap: () => ref.read(userColorProvider.notifier).state = color,
              child: Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selectedColor == color ? Colors.black : Colors.transparent,
                    width: 3,
                  ),
                ),
                child: selectedColor == color
                    ? const Icon(Icons.check, color: Colors.white)
                    : null,
              ),
            )).toList(),
          ),
          const SizedBox(height: 24),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('버전'),
            trailing: const Text('1.0.0 (Free)'),
          ),
        ],
      ),
    );
  }
}
