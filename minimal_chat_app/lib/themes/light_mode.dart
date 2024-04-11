import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.light(
      background: Colors.grey.shade300,
      primary: Colors.grey.shade500,
      secondary: Colors.grey.shade200,
      tertiary: Colors.white,
      inversePrimary: Colors.grey.shade900,
    ),
    appBarTheme: const AppBarTheme(
      // backgroundColor: Colors.grey.shade300,
      //         elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.grey,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        letterSpacing: 5,
      ),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey.shade300,
      elevation: 10,
    ),
    iconTheme: IconThemeData(
      color: Colors.grey.shade500,
    ));
