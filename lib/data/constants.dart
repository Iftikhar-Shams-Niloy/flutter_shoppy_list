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

class MyAppTextTheme {
  static final light = TextTheme(
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: MyAppScheme.lightScheme.onInverseSurface,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: MyAppScheme.lightScheme.onSurface,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: MyAppScheme.lightScheme.onSurface,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: MyAppScheme.lightScheme.onSurface,
    ),
  );

  static final dark = TextTheme(
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: MyAppScheme.darkScheme.onPrimary,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: MyAppScheme.darkScheme.onSurface,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: MyAppScheme.darkScheme.onSurface,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: MyAppScheme.darkScheme.onSurface,
    ),
  );
}

class MyAppTheme {
  static final lightTheme = ThemeData.from(colorScheme: MyAppScheme.lightScheme)
      .copyWith(
        textTheme: MyAppTextTheme.light,
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
        textTheme: MyAppTextTheme.dark,
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
