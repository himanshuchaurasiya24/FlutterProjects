import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:vyavasaay_redesigned/screens/introduction_screens/splash_screen.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences pref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();

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
        ).copyWith(error: Colors.red).copyWith(error: titleLargeTextColor),
      ),
      home: const SplashScreen(),
    );
  }
}
