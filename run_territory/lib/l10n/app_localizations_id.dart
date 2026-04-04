// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get navHome => 'Beranda';

  @override
  String get navMap => 'Wilayah Saya';

  @override
  String get navRun => 'Berlari';

  @override
  String get navHistory => 'Riwayat';

  @override
  String get navSettings => 'Pengaturan';

  @override
  String get startRun => 'Mulai Berlari';

  @override
  String get myStats => 'Statistik Saya';

  @override
  String get totalRuns => 'Total Lari';

  @override
  String totalRunsValue(int count) {
    return '$count kali';
  }

  @override
  String get totalDistance => 'Total Jarak';

  @override
  String get totalArea => 'Wilayah Diklaim';

  @override
  String get statsLoadFailed => 'Gagal memuat statistik';

  @override
  String get noRunsYet =>
      'Belum ada catatan lari.\nMulai berlari untuk klaim wilayah!';

  @override
  String errorMessage(Object error) {
    return 'Kesalahan: $error';
  }

  @override
  String get territoryColor => 'Warna Wilayah';

  @override
  String get customColor => 'Kustom';

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
  String get resume => 'Lanjutkan';

  @override
  String get stop => 'Berhenti';

  @override
  String get endRunTitle => 'Akhiri Lari';

  @override
  String get endRunMessage => 'Akhiri lari dan simpan wilayah?';

  @override
  String get save => 'Simpan';

  @override
  String get distance => 'Jarak';

  @override
  String get time => 'Waktu';

  @override
  String get pace => 'Kecepatan';

  @override
  String get unitSystem => 'Sistem Satuan';

  @override
  String get metric => 'Metrik (km, m)';

  @override
  String get imperial => 'Imperial (mi, ft)';

  @override
  String get paceUnit => 'menit/km';

  @override
  String get paceUnitImperial => 'menit/mi';

  @override
  String get planFree => 'Gratis';

  @override
  String get planPro => 'Pro';

  @override
  String get upgradeToPro => 'Upgrade ke Pro';

  @override
  String get proFeatures => 'Fitur Pro';

  @override
  String get proFeatureMultiplayer => 'Peta Multiplayer';

  @override
  String get proFeatureMultiplayerDesc =>
      'Lihat wilayah pemain lain secara real time';

  @override
  String get proFeatureLeaderboard => 'Papan Peringkat';

  @override
  String get proFeatureLeaderboardDesc =>
      'Bersaing secara global berdasarkan luas wilayah';

  @override
  String get proFeatureCloudSync => 'Sinkronisasi Cloud';

  @override
  String get proFeatureCloudSyncDesc =>
      'Cadangkan lari dan wilayah di berbagai perangkat';

  @override
  String get proFeatureFriends => 'Teman';

  @override
  String get proFeatureFriendsDesc => 'Tantang teman dan lihat wilayah mereka';

  @override
  String get proPrice => 'Buka Pro — \$4.99 (sekali bayar)';

  @override
  String get proUpgradeConfirmTitle => 'Upgrade ke Pro?';

  @override
  String get proUpgradeConfirmMessage =>
      'Ini adalah pembelian simulasi. Ketuk Konfirmasi untuk membuka semua fitur Pro.';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get proUnlocked => 'Pro terbuka! Nikmati semua fitur.';

  @override
  String get proAlreadyOwned => 'Anda sudah memiliki Pro.';

  @override
  String get proLockedHint => 'Fitur Pro — ketuk untuk upgrade';

  @override
  String get currentPlan => 'Paket Saat Ini';

  @override
  String get territoryClaimed => 'Wilayah Berhasil Diklaim!';

  @override
  String get areaLabel => 'Luas';

  @override
  String get done => 'Selesai';

  @override
  String get loopCompleted => 'Putaran Selesai!';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get termsOfUse => 'Syarat Penggunaan';
}
