import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/core/providers/app_providers.dart';
import 'package:run_territory/l10n/app_localizations.dart';
import 'package:run_territory/presentation/screens/legal/legal_screen.dart';
import 'package:run_territory/presentation/screens/pro/upgrade_screen.dart';

final userColorProvider = StateProvider<Color>((ref) => const Color(0xFFBF5FFF));

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const List<Color> paletteColors = [
    Color(0xFFB71C1C), Color(0xFFC62828), Color(0xFFD32F2F), Color(0xFFE53935), Color(0xFFEF5350),
    Color(0xFF880E4F), Color(0xFFAD1457), Color(0xFFC2185B), Color(0xFFE91E63), Color(0xFFF06292),
    Color(0xFF4A148C), Color(0xFF6A1B9A), Color(0xFF7B1FA2), Color(0xFF9C27B0), Color(0xFFBA68C8),
    Color(0xFF0D47A1), Color(0xFF1565C0), Color(0xFF1976D2), Color(0xFF2196F3), Color(0xFF64B5F6),
    Color(0xFF006064), Color(0xFF00838F), Color(0xFF00ACC1), Color(0xFF00BCD4), Color(0xFF80DEEA),
    Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF388E3C), Color(0xFF4CAF50), Color(0xFF81C784),
    Color(0xFFE65100), Color(0xFFF57C00), Color(0xFFFFA000), Color(0xFFFFC107), Color(0xFFFFD54F),
    Color(0xFF3E2723), Color(0xFF4E342E), Color(0xFF546E7A), Color(0xFF607D8B), Color(0xFF90A4AE),
  ];

  void _openColorPicker(BuildContext context, WidgetRef ref, Color current) {
    Color pickerColor = current;
    showDialog(
      context: context,
      builder: (context) {
        final l = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l.customColorTitle),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) => pickerColor = color,
              enableAlpha: false,
              labelTypes: const [],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text(l.cancel)),
            TextButton(
              onPressed: () {
                ref.read(userColorProvider.notifier).state = pickerColor;
                Navigator.pop(context);
              },
              child: Text(l.select),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final selectedColor = ref.watch(userColorProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.navSettings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            leading: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: selectedColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black26, width: 1),
              ),
            ),
            title: Text(l.territoryColor, style: Theme.of(context).textTheme.titleMedium),
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '#${selectedColor.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () => _openColorPicker(context, ref, selectedColor),
                    icon: const Icon(Icons.colorize, size: 18),
                    label: Text(l.customColor),
                  ),
                ],
              ),
              const SizedBox(height: 8),
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
                      child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(),
          Text(l.unitSystem, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Builder(builder: (context) {
            final isImperial = ref.watch(useImperialProvider);
            return SegmentedButton<bool>(
              segments: [
                ButtonSegment(value: false, label: Text(l.metric), icon: const Icon(Icons.straighten)),
                ButtonSegment(value: true, label: Text(l.imperial), icon: const Icon(Icons.flag)),
              ],
              selected: {isImperial},
              onSelectionChanged: (v) => ref.read(useImperialProvider.notifier).state = v.first,
            );
          }),
          const SizedBox(height: 24),
          const Divider(),
          const _PlanTile(),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(l.privacyPolicy),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (_) => const LegalScreen(type: LegalType.privacyPolicy),
            )),
          ),
          ListTile(
            leading: const Icon(Icons.gavel_outlined),
            title: Text(l.termsOfUse),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (_) => const LegalScreen(type: LegalType.termsOfUse),
            )),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l.version),
            trailing: const Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}

class _PlanTile extends ConsumerWidget {
  const _PlanTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final isProAsync = ref.watch(isProProvider);
    final isPro = isProAsync.valueOrNull ?? false;

    return ListTile(
      leading: Icon(
        isPro ? Icons.workspace_premium : Icons.lock_open,
        color: isPro ? Colors.amber : null,
      ),
      title: Text(l.currentPlan),
      trailing: isPro
          ? Chip(
              label: Text(l.planPro, style: const TextStyle(fontWeight: FontWeight.bold)),
              backgroundColor: Colors.amber.shade100,
            )
          : FilledButton.tonal(
              onPressed: () => UpgradeScreen.show(context),
              child: Text(l.upgradeToPro),
            ),
    );
  }
}
