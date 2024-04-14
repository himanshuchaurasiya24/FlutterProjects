import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade100,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade700,
    error: Colors.grey.shade600,
  ),
  useMaterial3: true,
  primaryIconTheme: IconThemeData(
    color: Colors.grey.shade500,
  ),
  iconTheme: IconThemeData(
    color: Colors.grey.shade700,
  ),
  textTheme: TextTheme(
    titleSmall: TextStyle(
      fontSize: 16,
      color: Colors.grey.shade600,
    ),
    titleMedium: TextStyle(
      fontSize: 32,
      color: Colors.grey.shade700,
    ),
    titleLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.grey.shade700,
    ),
  ),
  fontFamily: 'Ubuntu',
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.grey.shade700,
      fontSize: 32,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.transparent,
  ),
);
