import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.light(
      background: Colors.grey.shade300,
      primary: Colors.grey.shade500,
      secondary: Colors.grey.shade200,
      tertiary: Colors.white,
      inversePrimary: Colors.grey.shade900,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade300,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey.shade300,
      elevation: 10,
    ),
    iconTheme: IconThemeData(
      color: Colors.grey.shade500,
    ));
