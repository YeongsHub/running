import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================
// RUN TERRITORY — DESIGN SYSTEM
// ============================================================
//
// Design Philosophy:
//   Dark-first premium fitness app. Electric violet primary
//   conveys energy & premium feel against near-black slate,
//   deep orange rewards territory conquest with fiery warmth,
//   vivid red signals stop/danger. OLED-friendly.
//
// Color Roles:
//   primary      — Electric violet #7C4DFF  → CTAs, active states
//   secondary    — Deep orange     #FF6D00  → achievements, territory
//   tertiary     — Vivid red       #FF1744  → stop/danger actions
//   surface      — Deep slate      #0D1117  → main backgrounds
//   surfaceContainerHigh — #1A2233         → card backgrounds
//   onSurface    — Off-white       #E8EDF5  → primary text
// ============================================================

class AppTheme {
  AppTheme._();

  // ── Core palette ──────────────────────────────────────────
  static const Color primaryViolet      = Color(0xFF7C4DFF);
  static const Color primaryVioletDark  = Color(0xFF5E35B1);
  static const Color secondaryOrange    = Color(0xFFFF6D00);
  static const Color tertiaryRed        = Color(0xFFFF1744);
  static const Color goGreen            = Color(0xFF00E676);
  static const Color pauseOrange        = Color(0xFFFF9100);

  // ── Surface palette ───────────────────────────────────────
  static const Color surfaceBase              = Color(0xFF0D1117);
  static const Color surfaceContainer         = Color(0xFF131C2B);
  static const Color surfaceContainerHigh     = Color(0xFF1A2233);
  static const Color surfaceContainerHighest  = Color(0xFF1F2D42);

  // ── Text palette ──────────────────────────────────────────
  static const Color onSurfacePrimary   = Color(0xFFE8EDF5);
  static const Color onSurfaceSecondary = Color(0xFF8899AA);
  static const Color onSurfaceDisabled  = Color(0xFF3D4F66);

  // ── Gradients ─────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7C4DFF), Color(0xFFB388FF)],
  );
  static const LinearGradient orangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF6D00), Color(0xFFFF9100)],
  );
  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0A1628), Color(0xFF0D1F3C)],
  );

  // ── Glow shadows ──────────────────────────────────────────
  static List<BoxShadow> violetGlow({double intensity = 0.45}) => [
    BoxShadow(
      color: primaryViolet.withValues(alpha: intensity),
      blurRadius: 20,
      spreadRadius: 0,
      offset: const Offset(0, 6),
    ),
  ];

  // ── Theme ─────────────────────────────────────────────────
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primaryViolet,
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF3A1D99),
      onPrimaryContainer: Color(0xFFD4C4FF),
      secondary: secondaryOrange,
      onSecondary: Color(0xFF3D2000),
      secondaryContainer: Color(0xFF4A2800),
      onSecondaryContainer: Color(0xFFFFBE80),
      tertiary: tertiaryRed,
      onTertiary: Color(0xFF3D0008),
      tertiaryContainer: Color(0xFF52000F),
      onTertiaryContainer: Color(0xFFFF8F99),
      surface: surfaceBase,
      onSurface: onSurfacePrimary,
      surfaceContainerLowest: Color(0xFF090E18),
      surfaceContainerLow: surfaceContainer,
      surfaceContainer: surfaceContainerHigh,
      surfaceContainerHigh: surfaceContainerHighest,
      surfaceContainerHighest: Color(0xFF253550),
      outline: Color(0xFF2A3D5C),
      outlineVariant: Color(0xFF1A2A40),
      error: tertiaryRed,
      onError: Color(0xFF3D0008),
      errorContainer: Color(0xFF52000F),
      onErrorContainer: Color(0xFFFF8F99),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: onSurfacePrimary,
      onInverseSurface: surfaceBase,
      inversePrimary: primaryVioletDark,
    ),
    scaffoldBackgroundColor: surfaceBase,
    canvasColor: surfaceBase,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: onSurfacePrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: surfaceBase,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
        color: onSurfacePrimary,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: surfaceContainer,
      elevation: 0,
      height: 68,
      indicatorColor: Color(0x2E7C4DFF),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: primaryViolet, size: 26);
        }
        return const IconThemeData(color: onSurfaceSecondary, size: 24);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
              color: primaryViolet, fontSize: 11, fontWeight: FontWeight.w600);
        }
        return const TextStyle(color: onSurfaceSecondary, fontSize: 11);
      }),
    ),
    cardTheme: const CardThemeData(
      color: surfaceContainerHigh,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      margin: EdgeInsets.zero,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryViolet,
        foregroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        textStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.5),
        padding:
            const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: primaryViolet,
        foregroundColor: Color(0xFFFFFFFF),
        textStyle: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.4),
        padding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14))),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryViolet,
        textStyle:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryViolet,
      foregroundColor: Color(0xFFFFFFFF),
      elevation: 8,
      shape: CircleBorder(),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceContainerHigh,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF2A3D5C)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF2A3D5C)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: primaryViolet, width: 2),
      ),
      labelStyle: const TextStyle(color: onSurfaceSecondary),
      hintStyle: const TextStyle(color: onSurfaceDisabled),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: surfaceContainerHighest,
      selectedColor: const Color(0x337C4DFF),
      labelStyle: const TextStyle(color: onSurfacePrimary, fontSize: 13),
      side: const BorderSide(color: Color(0xFF2A3D5C)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    dividerTheme: const DividerThemeData(
        color: Color(0xFF1A2A40), thickness: 1, space: 1),
    listTileTheme: const ListTileThemeData(
      tileColor: Colors.transparent,
      iconColor: onSurfaceSecondary,
      textColor: onSurfacePrimary,
      subtitleTextStyle:
          TextStyle(color: onSurfaceSecondary, fontSize: 13),
      contentPadding:
          EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: primaryViolet),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceContainerHighest,
      contentTextStyle: const TextStyle(color: onSurfacePrimary),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: surfaceContainer,
      elevation: 0,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titleTextStyle: const TextStyle(
          color: onSurfacePrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700),
    ),
    textTheme: const TextTheme(
      displayLarge:  TextStyle(color: onSurfacePrimary, fontWeight: FontWeight.w900, letterSpacing: -1.5),
      displayMedium: TextStyle(color: onSurfacePrimary, fontWeight: FontWeight.w800, letterSpacing: -1.0),
      displaySmall:  TextStyle(color: onSurfacePrimary, fontWeight: FontWeight.w800, letterSpacing: -0.5),
      headlineLarge: TextStyle(color: onSurfacePrimary, fontWeight: FontWeight.w800, letterSpacing: -0.5),
      headlineMedium:TextStyle(color: onSurfacePrimary, fontWeight: FontWeight.w700, letterSpacing: -0.3),
      headlineSmall: TextStyle(color: onSurfacePrimary, fontWeight: FontWeight.w700),
      titleLarge:    TextStyle(color: onSurfacePrimary, fontWeight: FontWeight.w700, fontSize: 20, letterSpacing: -0.2),
      titleMedium:   TextStyle(color: onSurfacePrimary, fontWeight: FontWeight.w600, fontSize: 16),
      titleSmall:    TextStyle(color: onSurfacePrimary, fontWeight: FontWeight.w600, fontSize: 14),
      bodyLarge:     TextStyle(color: onSurfacePrimary, fontWeight: FontWeight.w400, fontSize: 16),
      bodyMedium:    TextStyle(color: onSurfaceSecondary, fontWeight: FontWeight.w400, fontSize: 14),
      bodySmall:     TextStyle(color: onSurfaceSecondary, fontWeight: FontWeight.w400, fontSize: 12),
      labelLarge:    TextStyle(color: onSurfacePrimary, fontWeight: FontWeight.w600, fontSize: 14),
      labelMedium:   TextStyle(color: onSurfaceSecondary, fontWeight: FontWeight.w500, fontSize: 12),
      labelSmall:    TextStyle(color: onSurfaceSecondary, fontWeight: FontWeight.w400, fontSize: 11),
    ),
    iconTheme: const IconThemeData(color: onSurfaceSecondary, size: 24),
    primaryIconTheme: const IconThemeData(color: primaryViolet, size: 24),
  );

  // Light alias — app is dark-only
  static ThemeData get light => dark;
}
