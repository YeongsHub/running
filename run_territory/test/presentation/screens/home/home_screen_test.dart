import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:run_territory/core/theme/app_theme.dart';
import 'package:run_territory/l10n/app_localizations.dart';
import 'package:run_territory/presentation/screens/home/home_screen.dart';
import 'package:run_territory/presentation/screens/settings/settings_screen.dart';

Widget _buildTestGraph({
  Map<DateTime, double> dailyKm = const {},
  Color userColor = const Color(0xFF2E7D32),
}) {
  return ProviderScope(
    overrides: [
      dailyDistanceProvider.overrideWith((ref) async => dailyKm),
      userColorProvider.overrideWith((ref) => userColor),
    ],
    child: MaterialApp(
      theme: AppTheme.dark,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(
        body: SingleChildScrollView(child: RunContributionGraph()),
      ),
    ),
  );
}

/// Finds grid cell BoxDecorations. Grid cells are the Container children of
/// Tooltip widgets (legend boxes are not wrapped in Tooltip).
List<BoxDecoration> _findGridCellDecorations(WidgetTester tester) {
  final cells = <BoxDecoration>[];
  final tooltips = find.byType(Tooltip);
  for (final tooltipElement in tooltips.evaluate()) {
    final container = find.descendant(
      of: find.byWidget(tooltipElement.widget),
      matching: find.byType(Container),
    );
    for (final cElement in container.evaluate()) {
      final widget = cElement.widget as Container;
      final decoration = widget.decoration;
      if (decoration is BoxDecoration) {
        cells.add(decoration);
      }
    }
  }
  return cells;
}

void main() {
  group('RunContributionGraph', () {
    testWidgets('empty cells use AppTheme.surfaceContainerHighest color',
        (tester) async {
      await tester.pumpWidget(_buildTestGraph());
      await tester.pumpAndSettle();

      final cellDecorations = _findGridCellDecorations(tester);

      expect(cellDecorations, isNotEmpty,
          reason: 'Should find grid cells');

      // All non-transparent cells (past/today with 0km) should be surfaceContainerHighest
      final nonTransparentCells = cellDecorations
          .where((d) => d.color != Colors.transparent)
          .toList();
      expect(nonTransparentCells, isNotEmpty,
          reason: 'Should have non-transparent (past/today) cells');

      for (final decoration in nonTransparentCells) {
        expect(
          decoration.color,
          equals(AppTheme.surfaceContainerHighest),
          reason:
              'Empty cell should use AppTheme.surfaceContainerHighest, '
              'got ${decoration.color}',
        );
      }
    });

    testWidgets('cells with activity use user color with alpha',
        (tester) async {
      final today = DateTime.now();
      final todayDate = DateTime(today.year, today.month, today.day);
      const testColor = Color(0xFF2196F3);

      await tester.pumpWidget(_buildTestGraph(
        dailyKm: {todayDate: 8.0}, // 8km → alpha 0.5 bracket
        userColor: testColor,
      ));
      await tester.pumpAndSettle();

      final cellDecorations = _findGridCellDecorations(tester);
      final activeCells = cellDecorations
          .where((d) =>
              d.color != Colors.transparent &&
              d.color != AppTheme.surfaceContainerHighest)
          .toList();

      expect(activeCells, isNotEmpty,
          reason: 'Should find at least one active cell');

      for (final decoration in activeCells) {
        final c = decoration.color!;
        expect(c.r, closeTo(testColor.r, 0.01));
        expect(c.g, closeTo(testColor.g, 0.01));
        expect(c.b, closeTo(testColor.b, 0.01));
        expect(c.a, lessThan(1.0),
            reason: 'Active cell should have alpha < 1.0');
      }
    });

    testWidgets('legend row shows labels', (tester) async {
      await tester.pumpWidget(_buildTestGraph());
      await tester.pumpAndSettle();

      expect(find.text('0km'), findsOneWidget);
      expect(find.text('15km+'), findsOneWidget);
    });
  });
}
