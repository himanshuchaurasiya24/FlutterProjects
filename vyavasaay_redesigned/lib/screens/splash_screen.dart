import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyavasaay_redesigned/screens/introduction_screen.dart';
import 'package:vyavasaay_redesigned/screens/login_signup_screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    isIntro();
    super.initState();
  }

  void isIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isIntro = prefs.getBool('isIntrodu') ?? false;
    if (isIntro) {
      Timer(
        const Duration(seconds: 1),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LoginScreen();
              },
            ),
          );
        },
      );
    } else {
      Timer(
        const Duration(seconds: 1),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const IntroductionScreen();
              },
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Vyavassay'),
      ),
    );
  }
}
