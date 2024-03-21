import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:vyavasaay_redesigned/screens/introduction_screen.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white30,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: primaryColor,
        hintColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
        ).copyWith(error: Colors.red),
      ),
      home: const IntroductionScreen(),
    );
  }
}
