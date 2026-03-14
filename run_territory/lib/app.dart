import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/core/theme/app_theme.dart';
import 'package:run_territory/presentation/screens/home/home_screen.dart';
import 'package:run_territory/presentation/screens/map/map_screen.dart';
import 'package:run_territory/presentation/screens/run/run_screen.dart';
import 'package:run_territory/presentation/screens/history/history_screen.dart';
import 'package:run_territory/presentation/screens/settings/settings_screen.dart';

final selectedTabProvider = StateProvider<int>((ref) => 0);

class RunTerritoryApp extends ConsumerWidget {
  const RunTerritoryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Run Territory',
      theme: AppTheme.light,
      home: const MainShell(),
    );
  }
}

class MainShell extends ConsumerWidget {
  const MainShell({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    MapScreen(),
    RunScreen(),
    HistoryScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTabProvider);
    return Scaffold(
      body: IndexedStack(
        index: selectedTab,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,
        onDestinationSelected: (index) =>
            ref.read(selectedTabProvider.notifier).state = index,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: '홈'),
          NavigationDestination(icon: Icon(Icons.map), label: '지도'),
          NavigationDestination(icon: Icon(Icons.directions_run), label: '달리기'),
          NavigationDestination(icon: Icon(Icons.history), label: '기록'),
          NavigationDestination(icon: Icon(Icons.settings), label: '설정'),
        ],
      ),
    );
  }
}
