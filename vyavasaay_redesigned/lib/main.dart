import 'package:flutter/material.dart';
import 'package:vyavasaay_redesigned/screens/introduction_screen.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
