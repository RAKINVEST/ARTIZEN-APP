import 'package:flutter/material.dart';

/// ARTIZEN brand theme — the "copilote des artisans" identity from the
/// marketing site: a deep navy canvas with warm gold accents and white
/// text. Everything else in the app reads its colours from `colorScheme`,
/// so restyling happens here in one place.
class AppTheme {
  const AppTheme._();

  // --- Brand palette (from the ARTIZEN landing page) ---
  static const Color gold = Color(0xFFE7A92E); // primary accent
  static const Color _onGold = Color(0xFF20160A); // near-black text on gold
  static const Color _navy = Color(0xFF0B1322); // app background
  static const Color _navySurface = Color(0xFF16223A); // cards, fields
  static const Color _navySurfaceHigh = Color(0xFF1E2E4A); // raised surfaces
  static const Color _navyBar = Color(0xFF0E1830); // bottom nav / bars
  static const Color _onNavy = Color(0xFFE9EDF6); // primary text
  static const Color _muted = Color(0xFF9AA7BD); // secondary text
  static const Color _border = Color(0xFF283A58); // hairline borders

  static ThemeData brand() {
    final scheme = ColorScheme.fromSeed(
      seedColor: gold,
      brightness: Brightness.dark,
    ).copyWith(
      primary: gold,
      onPrimary: _onGold,
      secondary: gold,
      onSecondary: _onGold,
      surface: _navy,
      onSurface: _onNavy,
      surfaceContainerHighest: _navySurfaceHigh,
      surfaceContainerHigh: _navySurface,
      surfaceContainer: _navySurface,
      onSurfaceVariant: _muted,
      outline: _border,
      outlineVariant: _border,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: _navy,
      appBarTheme: const AppBarTheme(
        backgroundColor: _navy,
        foregroundColor: _onNavy,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: _navySurface,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: _border),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: gold,
        foregroundColor: _onGold,
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: _navySurface,
        hintStyle: const TextStyle(color: _muted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: gold, width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: gold,
          foregroundColor: _onGold,
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: gold),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: _navyBar,
        elevation: 0,
        indicatorColor: gold.withValues(alpha: 0.20),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: states.contains(WidgetState.selected) ? gold : _muted,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected) ? gold : _muted,
          ),
        ),
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: gold,
        unselectedLabelColor: _muted,
        labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        indicatorColor: gold,
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      dialogTheme: const DialogThemeData(backgroundColor: _navySurface),
      listTileTheme: const ListTileThemeData(iconColor: gold),
      dividerTheme: const DividerThemeData(color: _border),
    );
  }
}
