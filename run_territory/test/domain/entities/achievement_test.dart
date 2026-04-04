import 'package:flutter_test/flutter_test.dart';
import 'package:run_territory/domain/entities/achievement.dart';
import 'package:run_territory/domain/entities/run_stats.dart';
import 'package:run_territory/domain/usecases/check_achievements.dart';

void main() {
  group('Achievement 엔티티', () {
    test('allDefinitions에 12개 업적 존재', () {
      expect(Achievement.allDefinitions.length, 12);
    });

    test('모든 업적 초기 상태는 잠금', () {
      for (final a in Achievement.allDefinitions) {
        expect(a.isUnlocked, isFalse);
      }
    });

    test('copyWith으로 잠금 해제 가능', () {
      final a = Achievement.allDefinitions.first;
      final unlocked = a.copyWith(isUnlocked: true);
      expect(unlocked.isUnlocked, isTrue);
      expect(unlocked.type, a.type);
      expect(unlocked.label, a.label);
    });

    test('모든 업적에 이모지, 레이블, 설명 존재', () {
      for (final a in Achievement.allDefinitions) {
        expect(a.emoji, isNotEmpty);
        expect(a.label, isNotEmpty);
        expect(a.description, isNotEmpty);
      }
    });

    test('업적 타입 중복 없음', () {
      final types = Achievement.allDefinitions.map((a) => a.type).toSet();
      expect(types.length, Achievement.allDefinitions.length);
    });
  });

  group('CheckAchievementsUseCase', () {
    final useCase = CheckAchievementsUseCase();

    test('달리기 0회 → firstRun 잠금', () {
      final result = useCase(stats: RunStats.empty, territoryCount: 0);
      final firstRun =
          result.firstWhere((a) => a.type == AchievementType.firstRun);
      expect(firstRun.isUnlocked, isFalse);
    });

    test('달리기 1회 → firstRun 해제', () {
      final stats = const RunStats(
        totalRuns: 1,
        totalDistanceKm: 3,
        totalDuration: Duration(minutes: 20),
        totalAreaM2: 0,
        bestPace: 6.0,
        longestRunKm: 3,
      );
      final result = useCase(stats: stats, territoryCount: 0);
      final firstRun =
          result.firstWhere((a) => a.type == AchievementType.firstRun);
      expect(firstRun.isUnlocked, isTrue);
    });

    test('거리 100km → distance100k 해제', () {
      final stats = const RunStats(
        totalRuns: 30,
        totalDistanceKm: 100,
        totalDuration: Duration(hours: 10),
        totalAreaM2: 0,
        bestPace: 5.0,
        longestRunKm: 15,
      );
      final result = useCase(stats: stats, territoryCount: 0);
      final ultra =
          result.firstWhere((a) => a.type == AchievementType.distance100k);
      expect(ultra.isUnlocked, isTrue);
    });

    test('영역 20개 → territories20 해제', () {
      final result = useCase(stats: RunStats.empty, territoryCount: 20);
      final t20 =
          result.firstWhere((a) => a.type == AchievementType.territories20);
      expect(t20.isUnlocked, isTrue);
    });

    test('earlyBird는 항상 해제', () {
      final result = useCase(stats: RunStats.empty, territoryCount: 0);
      final early =
          result.firstWhere((a) => a.type == AchievementType.earlyBird);
      expect(early.isUnlocked, isTrue);
    });

    test('빈 stats → 12개 결과 반환', () {
      final result = useCase(stats: RunStats.empty, territoryCount: 0);
      expect(result.length, 12);
    });
  });
}
