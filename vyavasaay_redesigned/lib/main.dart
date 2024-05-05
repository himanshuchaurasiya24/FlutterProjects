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
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          useMaterial3: true,
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          scaffoldBackgroundColor: primaryColorDark,
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: btnColor),
          appBarTheme: AppBarTheme(
            backgroundColor: primaryColorDark,
            centerTitle: true,
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              overlayColor: MaterialStatePropertyAll(btnColor),
              foregroundColor: const MaterialStatePropertyAll(
                Colors.black,
              ),
            ),
          ),
          checkboxTheme: CheckboxThemeData(
            overlayColor: MaterialStatePropertyAll(primaryColorLite),
            checkColor: MaterialStatePropertyAll(btnColor),
            fillColor: MaterialStatePropertyAll(primaryColorDark),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColorLite,
          ).copyWith(error: Colors.black),
          textSelectionTheme: TextSelectionThemeData(
              cursorColor: btnColor, selectionColor: btnColor)),
      home: const SplashScreen(),
    );
  }
}
