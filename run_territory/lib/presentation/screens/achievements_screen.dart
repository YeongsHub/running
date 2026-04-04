import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/core/providers/app_providers.dart';
import 'package:run_territory/domain/entities/achievement.dart';
import 'package:run_territory/domain/entities/run_stats.dart';
import 'package:run_territory/domain/usecases/check_achievements.dart';
import 'package:run_territory/presentation/widgets/achievement_badge.dart';

final _checkAchievementsUseCaseProvider = Provider(
  (_) => CheckAchievementsUseCase(),
);

final achievementsProvider = FutureProvider<List<Achievement>>((ref) async {
  final statsAsync = await ref.watch(statsProvider.future);
  final territories = await ref.watch(
    getMyTerritoriesUseCaseProvider,
  ).call('local_user');

  final stats = statsAsync ?? RunStats.empty;
  final useCase = ref.read(_checkAchievementsUseCaseProvider);

  return useCase(stats: stats, territoryCount: territories.length);
});

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementsAsync = ref.watch(achievementsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('업적'),
        centerTitle: true,
      ),
      body: achievementsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류: $e')),
        data: (achievements) {
          final unlockedCount = achievements.where((a) => a.isUnlocked).length;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Chip(
                  avatar: Icon(
                    Icons.emoji_events,
                    color: theme.colorScheme.primary,
                  ),
                  label: Text(
                    '$unlockedCount / ${achievements.length} 달성',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: theme.colorScheme.primaryContainer,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: achievements.length,
                  itemBuilder: (context, index) {
                    return AchievementBadge(achievement: achievements[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
