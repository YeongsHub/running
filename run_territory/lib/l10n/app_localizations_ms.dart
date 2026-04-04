// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get navHome => 'Utama';

  @override
  String get navMap => 'Wilayah Saya';

  @override
  String get navRun => 'Lari';

  @override
  String get navHistory => 'Sejarah';

  @override
  String get navSettings => 'Tetapan';

  @override
  String get startRun => 'Mula Berlari';

  @override
  String get myStats => 'Statistik Saya';

  @override
  String get totalRuns => 'Jumlah Larian';

  @override
  String totalRunsValue(int count) {
    return '$count larian';
  }

  @override
  String get totalDistance => 'Jumlah Jarak';

  @override
  String get totalArea => 'Wilayah Dituntut';

  @override
  String get statsLoadFailed => 'Gagal memuatkan statistik';

  @override
  String get noRunsYet =>
      'Tiada rekod larian lagi.\nMula berlari untuk menuntut wilayah!';

  @override
  String errorMessage(Object error) {
    return 'Ralat: $error';
  }

  @override
  String get territoryColor => 'Warna Wilayah';

  @override
  String get customColor => 'Tersuai';

  @override
  String get customColorTitle => 'Pilih Warna';

  @override
  String get cancel => 'Batal';

  @override
  String get select => 'Pilih';

  @override
  String get version => 'Versi';

  @override
  String get pause => 'Jeda';

  @override
  String get resume => 'Teruskan';

  @override
  String get stop => 'Berhenti';

  @override
  String get endRunTitle => 'Tamatkan Larian';

  @override
  String get endRunMessage => 'Tamatkan larian dan simpan wilayah?';

  @override
  String get save => 'Simpan';

  @override
  String get distance => 'Jarak';

  @override
  String get time => 'Masa';

  @override
  String get pace => 'Kadar';

  @override
  String get unitSystem => 'Sistem Unit';

  @override
  String get metric => 'Metrik (km, m)';

  @override
  String get imperial => 'Imperial (mi, ft)';

  @override
  String get paceUnit => 'min/km';

  @override
  String get paceUnitImperial => 'min/mi';

  @override
  String get planFree => 'Percuma';

  @override
  String get planPro => 'Pro';

  @override
  String get upgradeToPro => 'Naik Taraf ke Pro';

  @override
  String get proFeatures => 'Ciri Pro';

  @override
  String get proFeatureMultiplayer => 'Peta Berbilang Pemain';

  @override
  String get proFeatureMultiplayerDesc =>
      'Lihat wilayah pemain lain secara masa nyata';

  @override
  String get proFeatureLeaderboard => 'Papan Pendahulu';

  @override
  String get proFeatureLeaderboardDesc =>
      'Bersaing secara global mengikut luas wilayah';

  @override
  String get proFeatureCloudSync => 'Segerak Awan';

  @override
  String get proFeatureCloudSyncDesc =>
      'Sandaran larian dan wilayah merentasi peranti';

  @override
  String get proFeatureFriends => 'Rakan';

  @override
  String get proFeatureFriendsDesc => 'Cabaran rakan dan lihat wilayah mereka';

  @override
  String get proPrice => 'Buka Kunci Pro — \$4.99 (sekali sahaja)';

  @override
  String get proUpgradeConfirmTitle => 'Naik Taraf ke Pro?';

  @override
  String get proUpgradeConfirmMessage =>
      'Ini adalah pembelian simulasi. Ketik Sahkan untuk membuka kunci semua ciri Pro.';

  @override
  String get confirm => 'Sahkan';

  @override
  String get proUnlocked => 'Pro dibuka kunci! Nikmati semua ciri.';

  @override
  String get proAlreadyOwned => 'Anda sudah memiliki Pro.';

  @override
  String get proLockedHint => 'Ciri Pro — ketik untuk naik taraf';

  @override
  String get currentPlan => 'Pelan Semasa';

  @override
  String get territoryClaimed => 'Wilayah Berjaya Dituntut!';

  @override
  String get areaLabel => 'Luas';

  @override
  String get done => 'Selesai';

  @override
  String get loopCompleted => 'Gelung Selesai!';

  @override
  String get privacyPolicy => 'Dasar Privasi';

  @override
  String get termsOfUse => 'Terma Penggunaan';
}
