import 'package:flutter/material.dart';

class MyAppColors {
  static const seedGreen = Color.fromARGB(255, 173, 225, 115);
  static const accentYellow = Color.fromARGB(255, 255, 241, 112);
}

class MyAppScheme {
  static final lightScheme = ColorScheme.fromSeed(
    seedColor: MyAppColors.seedGreen,
    brightness: Brightness.light,
  ).copyWith(secondary: MyAppColors.accentYellow);

  static final darkScheme = ColorScheme.fromSeed(
    seedColor: MyAppColors.seedGreen,
    brightness: Brightness.dark,
  ).copyWith(secondary: MyAppColors.accentYellow);
}

class MyAppTheme {
  static final lightTheme = ThemeData.from(colorScheme: MyAppScheme.lightScheme)
      .copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: MyAppScheme.lightScheme.primary,
          foregroundColor: MyAppScheme.lightScheme.onPrimary,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: MyAppScheme.lightScheme.secondary,
          foregroundColor: MyAppScheme.lightScheme.onSecondary,
        ),
      );

  static final darkTheme = ThemeData.from(colorScheme: MyAppScheme.lightScheme)
      .copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: MyAppScheme.darkScheme.primary,
          foregroundColor: MyAppScheme.darkScheme.onPrimary,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: MyAppScheme.darkScheme.secondary,
          foregroundColor: MyAppScheme.darkScheme.onSecondary,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 41, 54, 43),
      );
}
