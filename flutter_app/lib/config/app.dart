import 'package:flutter/material.dart';

import '../services/theme_services.dart';

class AppConfig {
  AppConfig._();

  static const String appName = 'Maternal Triage';
  static const Color primaryColor = Colors.teal;

  static ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      );

  static ThemeData get darkTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      );

  static ValueNotifier<ThemeMode> get themeNotifier =>
      ThemeService.themeModeNotifier;
}