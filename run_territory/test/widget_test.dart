import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:run_territory/app.dart';

void main() {
  testWidgets('앱 시작 시 네비게이션 바 표시', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: RunTerritoryApp()));

    // 네비게이션 바가 렌더링되는지 확인
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('홈'), findsOneWidget);
    expect(find.text('지도'), findsOneWidget);
    expect(find.text('달리기'), findsOneWidget);
    expect(find.text('기록'), findsOneWidget);
    expect(find.text('설정'), findsOneWidget);
  });
}
