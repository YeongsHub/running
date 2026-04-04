import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/core/providers/app_providers.dart';
import 'package:run_territory/l10n/app_localizations.dart';
import 'package:run_territory/presentation/screens/settings/settings_screen.dart';

class UpgradeScreen extends ConsumerWidget {
  const UpgradeScreen({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const UpgradeScreen()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final isProAsync = ref.watch(isProProvider);
    final isPro = isProAsync.valueOrNull ?? false;
    final color = ref.watch(userColorProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.proFeatures)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withValues(alpha: 0.6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(Icons.workspace_premium, size: 56, color: Colors.white),
                const SizedBox(height: 12),
                Text(
                  l.planPro,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                if (isPro) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('✓ Active', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Feature list
          _ProFeatureTile(
            icon: Icons.people,
            title: l.proFeatureMultiplayer,
            description: l.proFeatureMultiplayerDesc,
          ),
          _ProFeatureTile(
            icon: Icons.leaderboard,
            title: l.proFeatureLeaderboard,
            description: l.proFeatureLeaderboardDesc,
          ),
          _ProFeatureTile(
            icon: Icons.cloud_sync,
            title: l.proFeatureCloudSync,
            description: l.proFeatureCloudSyncDesc,
          ),
          _ProFeatureTile(
            icon: Icons.group,
            title: l.proFeatureFriends,
            description: l.proFeatureFriendsDesc,
          ),

          const SizedBox(height: 32),

          if (isPro)
            FilledButton.icon(
              onPressed: null,
              icon: const Icon(Icons.check_circle),
              label: Text(l.proAlreadyOwned),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
            )
          else
            FilledButton.icon(
              onPressed: () => _purchase(context, ref, l),
              icon: const Icon(Icons.workspace_premium),
              label: Text(l.proPrice),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
            ),
        ],
      ),
    );
  }

  Future<void> _purchase(BuildContext context, WidgetRef ref, AppLocalizations l) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.proUpgradeConfirmTitle),
        content: Text(l.proUpgradeConfirmMessage),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l.cancel)),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l.confirm)),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await ref.read(isProProvider.notifier).unlock();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.proUnlocked), backgroundColor: Colors.green),
        );
      }
    }
  }
}

class _ProFeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _ProFeatureTile({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 2),
                Text(description, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
