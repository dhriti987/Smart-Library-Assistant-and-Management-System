import 'package:flutter/material.dart';

const Color primaryColor = Color.fromARGB(250, 205, 97, 129);
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
  textTheme:const  TextTheme(
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    labelMedium: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.black),
  ),
);
