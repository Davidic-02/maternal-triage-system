import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maternal_triage/constant/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightBg,
  primaryColor: AppColors.primaryGreen,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryGreen,
    secondary: AppColors.accentGreen,
    surface: AppColors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.textDark,
    elevation: 0,
  ),
  cardColor: AppColors.white,
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.sofiaSans(color: AppColors.textDark),
    bodyMedium: GoogleFonts.sofiaSans(color: AppColors.textDark),
    bodySmall: GoogleFonts.sofiaSans(color: AppColors.textGrey),
    headlineSmall: GoogleFonts.sofiaSans(
      color: AppColors.textDark,
      fontWeight: FontWeight.bold,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.primaryGreen.withValues(alpha: .05),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryGreen,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBg,
  primaryColor: AppColors.accentGreen,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.accentGreen,
    secondary: AppColors.primaryGreen,
    surface: AppColors.darkSurface,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkSurface,
    foregroundColor: AppColors.textLight,
    elevation: 0,
  ),
  cardColor: AppColors.darkSurface,
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.sofiaSans(color: AppColors.textLight),
    bodyMedium: GoogleFonts.sofiaSans(color: AppColors.textLight),
    bodySmall: GoogleFonts.sofiaSans(color: AppColors.textLight),
    headlineSmall: GoogleFonts.sofiaSans(
      color: AppColors.textLight,
      fontWeight: FontWeight.bold,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkSurface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.accentGreen,
      foregroundColor: AppColors.darkBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
);
