import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The single source of truth for the ARTIZEN visual identity — colours,
/// spacing, radii and the app-wide [ThemeData]. No widget hardcodes a
/// colour: they read either the [ColorScheme]/theme built here or the
/// semantic tokens on [ArtizenColors].
///
/// The rule the palette encodes: **night blue dominates, gold only accents.**
/// Gold ([ArtizenColors.gold]) draws the eye to what matters — a screen's
/// primary action, a confirmation, a key badge — and never stands in for the
/// blue that carries the whole app's identity.
class ArtizenColors {
  const ArtizenColors._();

  // --- Official palette ---
  /// Bleu nuit (principal) — the dominant colour.
  static const Color nightBlue = Color(0xFF10233F);

  /// Bleu secondaire — focus borders, secondary accents.
  static const Color blueSecondary = Color(0xFF1C355E);

  /// Or premium (accent) — used sparingly: primary actions, key icons,
  /// badges, confirmations. Never replaces the blue.
  static const Color gold = Color(0xFFD4AF37);

  /// Fond — the app background.
  static const Color surfaceLight = Color(0xFFF8FAFC);

  /// Texte principal.
  static const Color textPrimary = Color(0xFF1E293B);

  /// Texte secondaire.
  static const Color textSecondary = Color(0xFF64748B);

  /// Succès.
  static const Color success = Color(0xFF16A34A);

  /// Erreur.
  static const Color error = Color(0xFFDC2626);

  /// Info.
  static const Color info = Color(0xFF0EA5E9);

  /// Avertissement.
  static const Color warning = Color(0xFFF59E0B);

  // --- Derived tokens (still all from the palette) ---
  static const Color onNightBlue = Colors.white;
  static const Color onGold = nightBlue;

  /// Card / container surface.
  static const Color cardSurface = Color(0xFFFEFFFF);

  /// Field border at rest and hairline dividers.
  static const Color border = Color(0xFFE2E8F0);

  /// Placeholder text inside fields.
  static const Color placeholder = Color(0xFF94A3B8);

  /// Info-card background (the "données sécurisées" block).
  static const Color infoSurface = Color(0xFFF1F5F9);

  /// Soft shadow used on cards and the primary button.
  static const Color shadow = Color(0x1410233F); // rgba(16,35,63,0.08)

  // --- Quote status tokens (background, foreground) ---
  static const Color statusDraftBg = Color(0xFFE2E8F0);
  static const Color statusDraftFg = textSecondary;
  static const Color statusSentBg = Color(0xFFDCE5F2);
  static const Color statusSentFg = blueSecondary;
  static const Color statusAcceptedBg = Color(0xFFDCFCE7);
  static const Color statusAcceptedFg = success;
  static const Color statusRefusedBg = Color(0xFFFDE2E2);
  static const Color statusRefusedFg = error;
}

/// The 8-pt spacing system (8 / 16 / 24 / 32 / 48 / 64).
class ArtizenSpacing {
  const ArtizenSpacing._();
  static const double xs = 8;
  static const double sm = 16;
  static const double md = 24;
  static const double lg = 32;
  static const double xl = 48;
  static const double xxl = 64;
}

/// Corner radii used across the design system.
class ArtizenRadii {
  const ArtizenRadii._();
  static const double field = 12;
  static const double button = 12;
  static const double card = 16;
  static const double pill = 999;
}

/// Builds the app-wide [ThemeData] from [ArtizenColors]. Kept as
/// `AppTheme.light()` so `main.dart` needs no change.
class AppTheme {
  const AppTheme._();

  /// The app text font — Exo 2 (geometric, technical, ENR-inspired).
  static const String fontFamily = 'Exo2';

  /// The brand-wordmark font — Orbitron, used only for the "ARTIZEN" mark.
  static const String displayFontFamily = 'Orbitron';

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: ArtizenColors.nightBlue,
      brightness: Brightness.light,
    ).copyWith(
      primary: ArtizenColors.nightBlue,
      onPrimary: ArtizenColors.onNightBlue,
      secondary: ArtizenColors.blueSecondary,
      onSecondary: Colors.white,
      tertiary: ArtizenColors.gold,
      onTertiary: ArtizenColors.onGold,
      surface: Colors.white,
      onSurface: ArtizenColors.textPrimary,
      onSurfaceVariant: ArtizenColors.textSecondary,
      error: ArtizenColors.error,
      outline: ArtizenColors.border,
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: fontFamily,
    );

    return base.copyWith(
      scaffoldBackgroundColor: ArtizenColors.surfaceLight,
      textTheme: base.textTheme.apply(
        bodyColor: ArtizenColors.textPrimary,
        displayColor: ArtizenColors.textPrimary,
      ),
      // Night-blue app bars everywhere: what makes blue the dominant colour.
      appBarTheme: const AppBarTheme(
        backgroundColor: ArtizenColors.nightBlue,
        foregroundColor: ArtizenColors.onNightBlue,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          color: ArtizenColors.onNightBlue,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: ArtizenColors.onNightBlue),
      ),
      // Primary action = gold, night-blue label, 56 high, soft shadow.
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: ArtizenColors.gold,
          foregroundColor: ArtizenColors.onGold,
          disabledBackgroundColor: ArtizenColors.gold.withValues(alpha: 0.6),
          disabledForegroundColor: ArtizenColors.onGold.withValues(alpha: 0.7),
          minimumSize: const Size.fromHeight(56),
          elevation: 2,
          shadowColor: ArtizenColors.nightBlue.withValues(alpha: 0.10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ArtizenRadii.button),
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // Secondary action = night blue.
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ArtizenColors.nightBlue,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: ArtizenColors.nightBlue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ArtizenRadii.button),
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ArtizenColors.nightBlue,
          textStyle: const TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ArtizenColors.gold,
        foregroundColor: ArtizenColors.onGold,
      ),
      cardTheme: CardThemeData(
        color: ArtizenColors.cardSurface,
        elevation: 1.5,
        shadowColor: ArtizenColors.nightBlue.withValues(alpha: 0.08),
        surfaceTintColor: Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ArtizenRadii.card),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        isDense: false,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        hintStyle: const TextStyle(color: ArtizenColors.placeholder),
        labelStyle: const TextStyle(color: ArtizenColors.textSecondary),
        prefixIconColor: ArtizenColors.textSecondary,
        suffixIconColor: ArtizenColors.textSecondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ArtizenRadii.field),
          borderSide: const BorderSide(color: ArtizenColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ArtizenRadii.field),
          borderSide: const BorderSide(color: ArtizenColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ArtizenRadii.field),
          borderSide: const BorderSide(color: ArtizenColors.blueSecondary, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ArtizenRadii.field),
          borderSide: const BorderSide(color: ArtizenColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ArtizenRadii.field),
          borderSide: const BorderSide(color: ArtizenColors.error, width: 1.6),
        ),
        errorStyle: const TextStyle(color: ArtizenColors.error, fontSize: 12),
      ),
      // Bottom navigation: white, active icon night blue, active indicator gold.
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 3,
        indicatorColor: ArtizenColors.gold.withValues(alpha: 0.22),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? ArtizenColors.nightBlue
                : ArtizenColors.textSecondary,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontFamily: fontFamily,
            fontSize: 12,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w400,
            color: states.contains(WidgetState.selected)
                ? ArtizenColors.nightBlue
                : ArtizenColors.textSecondary,
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(color: ArtizenColors.border, space: 1),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ArtizenRadii.card),
        ),
        titleTextStyle: const TextStyle(
          fontFamily: fontFamily,
          color: ArtizenColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: const TextStyle(
          fontFamily: fontFamily,
          color: ArtizenColors.textSecondary,
          fontSize: 14,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ArtizenColors.gold,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ArtizenColors.nightBlue,
        contentTextStyle: const TextStyle(color: ArtizenColors.onNightBlue, fontFamily: fontFamily),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
