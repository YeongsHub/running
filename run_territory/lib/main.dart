import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:run_territory/app.dart';
import 'package:run_territory/core/services/interstitial_ad_service.dart' show AppOpenAdService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(
    const ProviderScope(
      child: RunTerritoryApp(),
    ),
  );
  // Show App Open ad at startup, max once per day
  AppOpenAdService.showIfEligible();
}
