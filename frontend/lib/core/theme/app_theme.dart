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

  // --- Official palette (charte ARTIZEN Premium) ---
  /// Bleu nuit (principal) — the dominant dark, primary brand colour.
  static const Color nightBlue = Color(0xFF140E55);

  /// Bleu interface (icônes, focus, statut « envoyé »).
  static const Color blueSecondary = Color(0xFF1156F7);

  /// Or clair (accent premium) — used sparingly: key icons, badges,
  /// confirmations. Never replaces the blue or the violet.
  static const Color gold = Color(0xFFF4C95D);

  /// Fond général — the app background.
  static const Color surfaceLight = Color(0xFFF9F9FC);

  /// Texte principal.
  static const Color textPrimary = Color(0xFF1E293B);

  /// Texte secondaire.
  static const Color textSecondary = Color(0xFF63688E);

  /// Succès (validation).
  static const Color success = Color(0xFF49C25A);

  /// Erreur.
  static const Color error = Color(0xFFE63946);

  /// Info.
  static const Color info = Color(0xFF1156F7);

  /// Avertissement (orange).
  static const Color warning = Color(0xFFF59717);

  // --- Derived tokens (still all from the palette) ---
  static const Color onNightBlue = Colors.white;
  static const Color onGold = nightBlue;

  /// Card / container surface.
  static const Color cardSurface = Color(0xFFFEFFFF);

  /// Field border at rest and hairline dividers.
  static const Color border = Color(0xFFECECF4);

  /// Placeholder text inside fields.
  static const Color placeholder = Color(0xFF9498B0);

  /// Info-card background (the "données sécurisées" block) — soft lavender.
  static const Color infoSurface = Color(0xFFF1EEF9);

  /// Soft shadow used on cards and the primary button.
  static const Color shadow = Color(0x14140E55); // rgba(20,14,85,0.08)

  // --- Quote status tokens (background, foreground) ---
  static const Color statusDraftBg = Color(0xFFECECF4);
  static const Color statusDraftFg = textSecondary;
  // "En attente" — an orange "waiting" tone, distinct from the sent blue.
  static const Color statusPendingBg = Color(0xFFFCEFD3);
  static const Color statusPendingFg = Color(0xFFC77A12);
  static const Color statusSentBg = Color(0xFFE6EDFF);
  static const Color statusSentFg = blueSecondary;
  static const Color statusAcceptedBg = Color(0xFFDFF7E3);
  static const Color statusAcceptedFg = success;
  static const Color statusRefusedBg = Color(0xFFFFE5E7);
  static const Color statusRefusedFg = error;
}

/// The gradients that carry the ARTIZEN "web" identity. Kept as raw stops so
/// widgets can pour them into a [LinearGradient] with whatever direction they
/// need. Violet→magenta is the signature: primary actions, the FAB, the active
/// navigation item. The night-blue→indigo sidebar and the near-white lavender
/// page background frame them.
class ArtizenGradients {
  const ArtizenGradients._();

  /// The signature gradient — blue → violet → pink. Reserved for the "hero"
  /// moment: the active navigation item. This is what gives ARTIZEN its modern
  /// look; used sparingly so it stays special.
  static const List<Color> primary = [
    Color(0xFF4D5AF3),
    Color(0xFF9631DE),
    Color(0xFFF5506D),
  ];

  /// The everyday primary-button / FAB gradient — a sober violet, on-brand but
  /// calmer than the full signature so a screen full of buttons stays clean.
  static const List<Color> button = [Color(0xFF603AF6), Color(0xFF9631DE)];

  /// The desktop sidebar — night blue fading into the deep night.
  static const List<Color> sidebar = [Color(0xFF140E55), Color(0xFF060930)];

  /// The page background — an almost-white lavender wash.
  static const List<Color> background = [Color(0xFFFCFBFE), Color(0xFFF1EAFB)];

  // --- List action gradients (Créer / Modifier / Supprimer) ---
  /// "Créer" — interface blue.
  static const List<Color> create = [Color(0xFF1156F7), Color(0xFF4D5AF3)];

  /// "Modifier" — orange → gold.
  static const List<Color> edit = [Color(0xFFF59717), Color(0xFFF4C95D)];

  /// "Supprimer" — red → signature pink.
  static const List<Color> delete = [Color(0xFFE63946), Color(0xFFF5506D)];
}

/// A pastel accent: the soft [bg] behind an icon chip, the saturated [fg] of
/// the icon/number, and the [gradient] used for the thin progress bar under a
/// stat card. One per semantic colour so a card picks an accent, never a raw
/// colour.
class ArtizenAccent {
  const ArtizenAccent({
    required this.bg,
    required this.fg,
    required this.gradient,
  });

  final Color bg;
  final Color fg;
  final List<Color> gradient;
}

/// The named accents used across the dashboard and lists.
class ArtizenAccents {
  const ArtizenAccents._();

  static const ArtizenAccent blue = ArtizenAccent(
    bg: Color(0xFFE9EFFF),
    fg: Color(0xFF1156F7),
    gradient: [Color(0xFF1156F7), Color(0xFF4D5AF3)],
  );
  static const ArtizenAccent violet = ArtizenAccent(
    bg: Color(0xFFECE4FE),
    fg: Color(0xFF603AF6),
    gradient: [Color(0xFF603AF6), Color(0xFF9631DE)],
  );
  static const ArtizenAccent amber = ArtizenAccent(
    bg: Color(0xFFFCEFD3),
    fg: Color(0xFFC77A12),
    gradient: [Color(0xFFF59717), Color(0xFFF4C95D)],
  );
  static const ArtizenAccent green = ArtizenAccent(
    bg: Color(0xFFDFF7E3),
    fg: Color(0xFF49C25A),
    gradient: [Color(0xFF49C25A), Color(0xFF7FD79A)],
  );
  static const ArtizenAccent red = ArtizenAccent(
    bg: Color(0xFFFFE5E7),
    fg: Color(0xFFE63946),
    gradient: [Color(0xFFE63946), Color(0xFFF5506D)],
  );
  static const ArtizenAccent cyan = ArtizenAccent(
    bg: Color(0xFFE9EFFF),
    fg: Color(0xFF1156F7),
    gradient: [Color(0xFF1156F7), Color(0xFF4D5AF3)],
  );
  static const ArtizenAccent slate = ArtizenAccent(
    bg: Color(0xFFECECF4),
    fg: Color(0xFF63688E),
    gradient: [Color(0xFF9498B0), Color(0xFFC6C9D9)],
  );
}

/// Violet principal — the interactive accent hue (active nav, pastille icons,
/// focus). The middle of the ARTIZEN identity (bleu nuit / violet / or).
const Color kArtizenViolet = Color(0xFF603AF6);

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
      // A near-white lavender base. Tab screens paint the real
      // white→lavender gradient via the shell's AppBackground; pushed routes
      // fall back to this tint until they carry their own AppBackground.
      scaffoldBackgroundColor: ArtizenColors.surfaceLight,
      textTheme: base.textTheme.apply(
        bodyColor: ArtizenColors.textPrimary,
        displayColor: ArtizenColors.textPrimary,
      ),
      // Light, borderless app bars: the title reads as dark text on the page
      // background (the "web" identity), not a night-blue band. Screens supply
      // a white-circle back button in `leading` where they need one.
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: ArtizenColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          color: ArtizenColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: ArtizenColors.textPrimary),
      ),
      // Filled action = solid violet, white label, 56 high, soft shadow. The
      // signature-gradient CTA is `AppPrimaryButton`; this covers the plain
      // FilledButtons (wizard nav, pickers) so they read violet, not gold.
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: kArtizenViolet,
          foregroundColor: Colors.white,
          disabledBackgroundColor: kArtizenViolet.withValues(alpha: 0.45),
          disabledForegroundColor: Colors.white.withValues(alpha: 0.85),
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
      // Safety net for any default FAB — the exact violet→magenta gradient FAB
      // is the `GradientFab` widget; this keeps a plain FAB on-brand too.
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: kArtizenViolet,
        foregroundColor: Colors.white,
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
      // Bottom navigation: white, active icon/label violet, violet indicator.
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 3,
        indicatorColor: kArtizenViolet.withValues(alpha: 0.14),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? kArtizenViolet
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
                ? kArtizenViolet
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
