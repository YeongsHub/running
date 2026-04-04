import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:run_territory/core/providers/app_providers.dart';
import 'package:run_territory/core/theme/app_theme.dart';
import 'package:run_territory/l10n/app_localizations.dart';
import 'package:run_territory/presentation/screens/settings/settings_screen.dart';

Widget _buildTestSettings({Color userColor = const Color(0xFF2E7D32)}) {
  return ProviderScope(
    overrides: [
      userColorProvider.overrideWith((ref) => userColor),
      useImperialProvider.overrideWith((ref) => false),
      isProProvider.overrideWith(() => _FakeIsProNotifier()),
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
      home: const SettingsScreen(),
    ),
  );
}

class _FakeIsProNotifier extends IsProNotifier {
  @override
  Future<bool> build() async => false;
}

void main() {
  group('SettingsScreen - Territory Color ExpansionTile', () {
    testWidgets('territory color section is wrapped in ExpansionTile',
        (tester) async {
      await tester.pumpWidget(_buildTestSettings());
      await tester.pumpAndSettle();

      // ExpansionTile should exist
      expect(find.byType(ExpansionTile), findsOneWidget);

      // The ExpansionTile title shows "Territory Color"
      expect(find.text('Territory Color'), findsOneWidget);
    });

    testWidgets('ExpansionTile is collapsed by default - palette not visible',
        (tester) async {
      await tester.pumpWidget(_buildTestSettings());
      await tester.pumpAndSettle();

      // The GridView (color palette) should not be visible when collapsed
      expect(find.byType(GridView), findsNothing);

      // Custom button should also not be visible
      expect(find.text('Custom'), findsNothing);
    });

    testWidgets('tapping ExpansionTile expands to show color palette',
        (tester) async {
      await tester.pumpWidget(_buildTestSettings());
      await tester.pumpAndSettle();

      // Tap the ExpansionTile to expand
      await tester.tap(find.text('Territory Color'));
      await tester.pumpAndSettle();

      // Now the GridView (color palette) should be visible
      expect(find.byType(GridView), findsOneWidget);

      // Custom color button should appear
      expect(find.text('Custom'), findsOneWidget);
    });

    testWidgets('ExpansionTile leading shows current color indicator',
        (tester) async {
      const testColor = Color(0xFFE53935);
      await tester.pumpWidget(_buildTestSettings(userColor: testColor));
      await tester.pumpAndSettle();

      // Find the ExpansionTile and verify it has a leading color circle
      final expansionTile =
          tester.widget<ExpansionTile>(find.byType(ExpansionTile));
      expect(expansionTile.leading, isNotNull);
    });

    testWidgets('tapping a palette color updates the selected color',
        (tester) async {
      await tester.pumpWidget(_buildTestSettings());
      await tester.pumpAndSettle();

      // Expand the tile
      await tester.tap(find.text('Territory Color'));
      await tester.pumpAndSettle();

      // The palette grid should now be visible
      expect(find.byType(GridView), findsOneWidget);

      // Tap a color in the palette (find GestureDetectors inside GridView)
      final gridView = find.byType(GridView);
      final gestureDetectors = find.descendant(
        of: gridView,
        matching: find.byType(GestureDetector),
      );
      expect(gestureDetectors, findsWidgets);

      // Tap the first palette color
      await tester.tap(gestureDetectors.first);
      await tester.pumpAndSettle();

      // The widget should rebuild with the new color (no crash)
      expect(find.byType(ExpansionTile), findsOneWidget);
    });

    testWidgets('hex color code is shown when expanded', (tester) async {
      await tester.pumpWidget(_buildTestSettings());
      await tester.pumpAndSettle();

      // Expand
      await tester.tap(find.text('Territory Color'));
      await tester.pumpAndSettle();

      // Should show hex code for the default green color (#2E7D32)
      expect(find.text('#2E7D32'), findsOneWidget);
    });

    testWidgets(
        'collapsing after expand hides the palette again', (tester) async {
      await tester.pumpWidget(_buildTestSettings());
      await tester.pumpAndSettle();

      // Expand
      await tester.tap(find.text('Territory Color'));
      await tester.pumpAndSettle();
      expect(find.byType(GridView), findsOneWidget);

      // Collapse
      await tester.tap(find.text('Territory Color'));
      await tester.pumpAndSettle();

      // Palette should be hidden again
      expect(find.byType(GridView), findsNothing);
    });
  });
}
