import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData buildKalaTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: terracotta,
      primary: terracotta,
      secondary: teal,
      tertiary: ochre,
      surface: ivory,
    ),
    scaffoldBackgroundColor: ivory,
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: terracotta.withValues(alpha: .12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: ochre.withValues(alpha: .35),
    ),
  );
}
