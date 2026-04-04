enum AchievementType {
  firstRun,
  runs5,
  runs20,
  runs50,
  distance5k,
  distance10k,
  distance42k,
  distance100k,
  firstTerritory,
  territories5,
  territories20,
  earlyBird,
}

class Achievement {
  final AchievementType type;
  final String label;
  final String description;
  final String emoji;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  const Achievement({
    required this.type,
    required this.label,
    required this.description,
    required this.emoji,
    required this.isUnlocked,
    this.unlockedAt,
  });

  Achievement copyWith({bool? isUnlocked, DateTime? unlockedAt}) {
    return Achievement(
      type: type,
      label: label,
      description: description,
      emoji: emoji,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }

  static const List<Achievement> allDefinitions = [
    Achievement(
      type: AchievementType.firstRun,
      label: '첫 번째 달리기',
      description: '처음으로 달리기를 완료했습니다',
      emoji: '🏃',
      isUnlocked: false,
    ),
    Achievement(
      type: AchievementType.runs5,
      label: '꾸준한 러너',
      description: '총 5회 달리기를 완료했습니다',
      emoji: '🔥',
      isUnlocked: false,
    ),
    Achievement(
      type: AchievementType.runs20,
      label: '달리기 습관',
      description: '총 20회 달리기를 완료했습니다',
      emoji: '💪',
      isUnlocked: false,
    ),
    Achievement(
      type: AchievementType.runs50,
      label: '달리기 마스터',
      description: '총 50회 달리기를 완료했습니다',
      emoji: '🏆',
      isUnlocked: false,
    ),
    Achievement(
      type: AchievementType.distance5k,
      label: '5K 달성',
      description: '누적 거리 5km를 달성했습니다',
      emoji: '📍',
      isUnlocked: false,
    ),
    Achievement(
      type: AchievementType.distance10k,
      label: '10K 달성',
      description: '누적 거리 10km를 달성했습니다',
      emoji: '🗺️',
      isUnlocked: false,
    ),
    Achievement(
      type: AchievementType.distance42k,
      label: '마라톤 거리',
      description: '누적 거리 42.195km를 달성했습니다',
      emoji: '🎖️',
      isUnlocked: false,
    ),
    Achievement(
      type: AchievementType.distance100k,
      label: '울트라 러너',
      description: '누적 거리 100km를 달성했습니다',
      emoji: '🌟',
      isUnlocked: false,
    ),
    Achievement(
      type: AchievementType.firstTerritory,
      label: '첫 번째 영역',
      description: '처음으로 영역을 점령했습니다',
      emoji: '🗾',
      isUnlocked: false,
    ),
    Achievement(
      type: AchievementType.territories5,
      label: '영역 확장',
      description: '5개의 영역을 점령했습니다',
      emoji: '🌍',
      isUnlocked: false,
    ),
    Achievement(
      type: AchievementType.territories20,
      label: '영토 정복자',
      description: '20개의 영역을 점령했습니다',
      emoji: '👑',
      isUnlocked: false,
    ),
    Achievement(
      type: AchievementType.earlyBird,
      label: '얼리버드',
      description: '앱을 처음 실행했습니다',
      emoji: '🐦',
      isUnlocked: false,
    ),
  ];
}
