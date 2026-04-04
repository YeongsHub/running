import 'package:run_territory/domain/entities/achievement.dart';
import 'package:run_territory/domain/entities/run_stats.dart';

class CheckAchievementsUseCase {
  List<Achievement> call({
    required RunStats stats,
    required int territoryCount,
  }) {
    final now = DateTime.now();

    bool check(AchievementType type) {
      switch (type) {
        case AchievementType.firstRun:
          return stats.totalRuns >= 1;
        case AchievementType.runs5:
          return stats.totalRuns >= 5;
        case AchievementType.runs20:
          return stats.totalRuns >= 20;
        case AchievementType.runs50:
          return stats.totalRuns >= 50;
        case AchievementType.distance5k:
          return stats.totalDistanceKm >= 5;
        case AchievementType.distance10k:
          return stats.totalDistanceKm >= 10;
        case AchievementType.distance42k:
          return stats.totalDistanceKm >= 42.195;
        case AchievementType.distance100k:
          return stats.totalDistanceKm >= 100;
        case AchievementType.firstTerritory:
          return territoryCount >= 1;
        case AchievementType.territories5:
          return territoryCount >= 5;
        case AchievementType.territories20:
          return territoryCount >= 20;
        case AchievementType.earlyBird:
          return true;
      }
    }

    return Achievement.allDefinitions.map((a) {
      final unlocked = check(a.type);
      return a.copyWith(
        isUnlocked: unlocked,
        unlockedAt: unlocked ? now : null,
      );
    }).toList();
  }
}
