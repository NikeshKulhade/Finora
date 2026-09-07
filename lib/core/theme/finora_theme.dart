import 'package:flutter/material.dart';

abstract final class FinoraColors {
  static const ink = Color(0xFF172126);
  static const canvas = Color(0xFFF6F8F7);
  static const surface = Colors.white;
  static const mint = Color(0xFF1E8E72);
  static const mintSoft = Color(0xFFDDF3EA);
  static const coral = Color(0xFFE06A53);
  static const coralSoft = Color(0xFFFBE4DE);
  static const gold = Color(0xFFE3AA3F);
  static const line = Color(0xFFE3E9E6);
  static const muted = Color(0xFF71807A);
}

abstract final class FinoraTheme {
  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: FinoraColors.mint,
      brightness: brightness,
      surface: isDark ? const Color(0xFF172321) : FinoraColors.surface,
    );
    return ThemeData(
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark ? const Color(0xFF101816) : FinoraColors.canvas,
      fontFamily: 'Arial',
      useMaterial3: true,
      appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}