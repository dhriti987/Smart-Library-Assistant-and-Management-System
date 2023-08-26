import 'package:flutter/material.dart';

Color PRIMARY_COLOR = Color.fromARGB(250, 205, 97, 129);
ThemeData lightTheme = ThemeData();
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: PRIMARY_COLOR,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: PRIMARY_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    filled: true,
    fillColor: Colors.white,
    hintStyle: TextStyle(color: Colors.black),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    labelMedium: TextStyle(color: Colors.white),
  ),
);
