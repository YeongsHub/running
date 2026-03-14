import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 사용자 색상 선택 Provider
final userColorProvider = StateProvider<Color>((ref) => const Color(0xFF2E7D32));

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const List<Color> paletteColors = [
    // 빨강 계열
    Color(0xFFB71C1C), Color(0xFFC62828), Color(0xFFD32F2F), Color(0xFFE53935), Color(0xFFEF5350),
    // 분홍 계열
    Color(0xFF880E4F), Color(0xFFAD1457), Color(0xFFC2185B), Color(0xFFE91E63), Color(0xFFF06292),
    // 보라 계열
    Color(0xFF4A148C), Color(0xFF6A1B9A), Color(0xFF7B1FA2), Color(0xFF9C27B0), Color(0xFFBA68C8),
    // 파랑 계열
    Color(0xFF0D47A1), Color(0xFF1565C0), Color(0xFF1976D2), Color(0xFF2196F3), Color(0xFF64B5F6),
    // 청록 계열
    Color(0xFF006064), Color(0xFF00838F), Color(0xFF00ACC1), Color(0xFF00BCD4), Color(0xFF80DEEA),
    // 초록 계열
    Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF388E3C), Color(0xFF4CAF50), Color(0xFF81C784),
    // 노랑/주황 계열
    Color(0xFFE65100), Color(0xFFF57C00), Color(0xFFFFA000), Color(0xFFFFC107), Color(0xFFFFD54F),
    // 갈색/회색 계열
    Color(0xFF3E2723), Color(0xFF4E342E), Color(0xFF546E7A), Color(0xFF607D8B), Color(0xFF90A4AE),
  ];

  void _openColorPicker(BuildContext context, WidgetRef ref, Color current) {
    Color pickerColor = current;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('색상 직접 선택'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: (color) => pickerColor = color,
            enableAlpha: false,
            labelTypes: const [],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              ref.read(userColorProvider.notifier).state = pickerColor;
              Navigator.pop(context);
            },
            child: const Text('선택'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(userColorProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('내 영역 색상', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          // 현재 선택 색상 미리보기
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: selectedColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black26, width: 1),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '#${selectedColor.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
                style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => _openColorPicker(context, ref, selectedColor),
                icon: const Icon(Icons.colorize, size: 18),
                label: const Text('직접 입력'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 컬러 팔레트 그리드
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: paletteColors.length,
            itemBuilder: (context, index) {
              final color = paletteColors[index];
              final isSelected = selectedColor.toARGB32() == color.toARGB32();
              return GestureDetector(
                onTap: () => ref.read(userColorProvider.notifier).state = color,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.transparent,
                      width: 2.5,
                    ),
                    boxShadow: isSelected
                        ? [BoxShadow(color: color.withValues(alpha: 0.6), blurRadius: 6, spreadRadius: 1)]
                        : null,
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
                ),
              );
            },
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
