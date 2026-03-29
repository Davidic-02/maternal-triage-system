import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maternal_triage/constant/app_colors.dart';

//========================= LIGHT THEME =========================//
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
);

//========================= DARK THEME =========================//

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBg,
  primaryColor: AppColors.primaryGreen.withOpacity(0.1),
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryGreen,
    secondary: AppColors.accentNeon,
    surface: AppColors.darkSurface,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primaryGreen.withOpacity(0.2),
    foregroundColor: AppColors.white,
    elevation: 0,
    titleTextStyle: GoogleFonts.sofiaSans(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.sofiaSans(color: AppColors.white),
    bodyMedium: GoogleFonts.sofiaSans(color: AppColors.white),
    bodySmall: GoogleFonts.sofiaSans(color: AppColors.mutedText),
    displaySmall: GoogleFonts.sofiaSans(
      color: AppColors.accentNeon,
      fontSize: 18,
    ),
    headlineSmall: GoogleFonts.sofiaSans(
      color: AppColors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
  cardColor: AppColors.darkSurface,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkSurface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.accentNeon,
      foregroundColor: AppColors.darkBg,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkSurface,
    selectedIconTheme: const IconThemeData(color: AppColors.primaryGreen),
    unselectedIconTheme: IconThemeData(
      color: AppColors.primaryGreen.withOpacity(0.5),
    ),
  ),
);
