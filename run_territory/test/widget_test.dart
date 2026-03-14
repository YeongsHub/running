import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:run_territory/app.dart';
import 'package:run_territory/l10n/app_localizations.dart';

Widget _appWithLocale({Locale locale = const Locale('en')}) {
  return ProviderScope(
    child: MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MainShell(),
    ),
  );
}

void main() {
  testWidgets('네비게이션 바 렌더링 확인 (영어)', (tester) async {
    await tester.pumpWidget(_appWithLocale(locale: const Locale('en')));
    await tester.pump();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Map'), findsOneWidget);
    expect(find.text('Run'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('네비게이션 바 렌더링 확인 (한국어)', (tester) async {
    await tester.pumpWidget(_appWithLocale(locale: const Locale('ko')));
    await tester.pump();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('홈'), findsOneWidget);
    expect(find.text('지도'), findsOneWidget);
    expect(find.text('달리기'), findsOneWidget);
    expect(find.text('기록'), findsOneWidget);
    expect(find.text('설정'), findsOneWidget);
  });

  testWidgets('네비게이션 바 렌더링 확인 (독일어)', (tester) async {
    await tester.pumpWidget(_appWithLocale(locale: const Locale('de')));
    await tester.pump();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
    expect(find.text('Karte'), findsOneWidget);
    expect(find.text('Laufen'), findsOneWidget);
    expect(find.text('Verlauf'), findsOneWidget);
    expect(find.text('Einstellungen'), findsOneWidget);
  });

  testWidgets('탭 선택 시 화면 전환 확인', (tester) async {
    await tester.pumpWidget(_appWithLocale());
    await tester.pump();

    // 기본 탭은 홈(0)
    expect(find.byType(NavigationBar), findsOneWidget);

    // History 탭 탭
    await tester.tap(find.text('History'));
    await tester.pump();

    // NavigationBar는 여전히 존재
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
