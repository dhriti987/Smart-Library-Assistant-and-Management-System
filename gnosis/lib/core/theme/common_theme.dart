import 'package:flutter/material.dart';

const Color primaryColor = Color.fromARGB(255, 0, 80, 146);
ThemeData lightTheme = ThemeData();
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    filled: true,
    fillColor: Colors.white,
    hintStyle: const TextStyle(color: Colors.black),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    labelMedium: TextStyle(color: Colors.white,fontSize: 14),
    titleMedium: TextStyle(color: Colors.black),
    titleLarge: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
    labelLarge: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
    labelSmall: TextStyle(color: Colors.white,fontSize: 10),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white10,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white10,
  )
);
