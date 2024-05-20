import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:vyavasaay_mobile/screens/home_screen.dart';
// write a code to add two numbers.

void main() {
  if (Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactoryOrNull = databaseFactoryFfi;
  }
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.red[400],
            hoverElevation: 20,
            splashColor: Colors.blue,
            elevation: 1,
            extendedTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )
            // highlightElevation: 20,
            ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primarySwatch: Colors.red,
        primaryColor: Colors.red[400],
        primaryTextTheme: TextTheme(
          bodyLarge: const TextStyle(
            color: Colors.black,
          ),
          bodySmall: TextStyle(
            color: Colors.red[400],
          ),
          bodyMedium: TextStyle(
            color: Colors.red[400],
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.red[400],
          selectionColor: Colors.red[400],
          selectionHandleColor: Colors.red[400]!,
        ),
        appBarTheme: AppBarTheme(
          color: Colors.red[50],
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        scaffoldBackgroundColor: Colors.red[50],
      ),
      home: const HomeScreen(),
    );
  }
}
