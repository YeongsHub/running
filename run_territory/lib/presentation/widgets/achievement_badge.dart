import 'package:flutter/material.dart';
import 'package:run_territory/domain/entities/achievement.dart';

class AchievementBadge extends StatelessWidget {
  final Achievement achievement;

  const AchievementBadge({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unlocked = achievement.isUnlocked;

    return Card(
      elevation: unlocked ? 4 : 1,
      color: unlocked
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: unlocked
                      ? theme.colorScheme.primary.withValues(alpha: 0.2)
                      : theme.colorScheme.onSurface.withValues(alpha: 0.08),
                  child: Text(
                    achievement.emoji,
                    style: TextStyle(
                      fontSize: 26,
                      color: unlocked ? null : Colors.transparent,
                    ),
                  ),
                ),
                if (!unlocked)
                  const Icon(Icons.lock, size: 24, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              achievement.label,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: unlocked
                    ? theme.colorScheme.onPrimaryContainer
                    : theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              achievement.description,
              style: theme.textTheme.bodySmall?.copyWith(
                color: unlocked
                    ? theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.7)
                    : theme.colorScheme.onSurface.withValues(alpha: 0.35),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (unlocked)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Icon(
                  Icons.check_circle,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
