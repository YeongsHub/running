import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:run_territory/core/theme/app_theme.dart';
import 'package:run_territory/l10n/app_localizations.dart';
import 'package:run_territory/presentation/screens/home/home_screen.dart';
import 'package:run_territory/presentation/screens/map/map_screen.dart';
import 'package:run_territory/presentation/screens/run/run_screen.dart';
import 'package:run_territory/presentation/screens/history/history_screen.dart';
import 'package:run_territory/presentation/screens/settings/settings_screen.dart';
import 'package:run_territory/presentation/widgets/banner_ad_widget.dart';

final selectedTabProvider = StateProvider<int>((ref) => 0);

class RunTerritoryApp extends ConsumerWidget {
  const RunTerritoryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Run Territory',
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
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
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      body: IndexedStack(
        index: selectedTab,
        children: _screens,
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BannerAdWidget(),
          NavigationBar(
            selectedIndex: selectedTab,
            onDestinationSelected: (index) =>
                ref.read(selectedTabProvider.notifier).state = index,
            destinations: [
              NavigationDestination(icon: const Icon(Icons.home), label: l.navHome),
              NavigationDestination(icon: const Icon(Icons.terrain), label: l.navMap),
              NavigationDestination(icon: const Icon(Icons.directions_run), label: l.navRun),
              NavigationDestination(icon: const Icon(Icons.history), label: l.navHistory),
              NavigationDestination(icon: const Icon(Icons.settings), label: l.navSettings),
            ],
          ),
        ],
      ),
    );
  }
}
