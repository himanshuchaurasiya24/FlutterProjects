import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    background: const Color.fromARGB(255, 20, 20, 20),
    primary: const Color.fromARGB(255, 122, 122, 122),
    secondary: const Color.fromARGB(106, 116, 114, 114),
    tertiary: const Color.fromARGB(255, 47, 47, 47),
    inversePrimary: Colors.grey.shade300,
    error: Colors.grey.shade200,
  ),
  useMaterial3: true,
  iconTheme: IconThemeData(
    color: Colors.grey.shade300,
  ),
  textTheme: TextTheme(
    titleSmall: TextStyle(
      fontSize: 16,
      color: Colors.grey.shade200,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      color: Colors.grey.shade300,
    ),
    titleLarge: TextStyle(
      fontSize: 32,
      color: Colors.grey.shade300,
      fontWeight: FontWeight.bold,
    ),
  ),
  fontFamily: 'Ubuntu',
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.grey.shade300,
      fontSize: 32,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.transparent,
  ),
);
