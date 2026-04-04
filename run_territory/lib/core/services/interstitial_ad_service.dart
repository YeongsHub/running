import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppOpenAdService {
  static const String _lastShownKey = 'app_open_ad_last_shown_date';

  static String get _adUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6139362725426823/2597686904';
    } else {
      // iOS ad unit ID — update when available
      return 'ca-app-pub-3940256099942544/5575463023'; // test ID for now
    }
  }

  static Future<bool> _wasShownToday() async {
    final prefs = await SharedPreferences.getInstance();
    final lastShown = prefs.getString(_lastShownKey);
    if (lastShown == null) return false;
    final today = DateTime.now().toIso8601String().substring(0, 10);
    return lastShown == today;
  }

  static Future<void> _markShownToday() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);
    await prefs.setString(_lastShownKey, today);
  }

  static Future<void> showIfEligible() async {
    if (await _wasShownToday()) return;

    AppOpenAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) async {
          await _markShownToday();
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) => ad.dispose(),
            onAdFailedToShowFullScreenContent: (ad, error) => ad.dispose(),
          );
          ad.show();
        },
        onAdFailedToLoad: (error) {
          // Silently fail — don't block app startup
        },
      ),
    );
  }
}
