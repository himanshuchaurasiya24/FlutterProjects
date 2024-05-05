import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/screens/introduction_screens/introduction_screen.dart';
import 'package:vyavasaay_redesigned/screens/login_signup_screens/login_screen.dart';
import 'package:vyavasaay_redesigned/screens/main_screen/home_screen.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final DatabaseHelper database = DatabaseHelper();
  @override
  void initState() {
    isIntro();
    database.initDB();
    super.initState();
  }

  void isIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isIntro = prefs.getBool('isIntrodu') ?? false;
    bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String? loggedInName = prefs.getString('loggedInName') ?? 'empty';
    String? logInType = prefs.getString('logInType') ?? 'Technician';
    final adminActLength = await database.getAdminAccountLength();
    if (adminActLength == 0) {
      await prefs.setBool('isIntrodu', false);
      await prefs.setBool('isLoggedIn', false).then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const IntroductionScreen();
            },
          ),
        );
      });

      return;
    }
    if (isIntro) {
      if (isLoggedIn) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isLoggedIn.toString() + loggedInName,
            ),
          ),
        );
        Timer(
          const Duration(seconds: 1),
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen(
                    name: loggedInName,
                    logInType: logInType,
                  );
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
                  debugPrint(adminActLength.toString());
                  return const LoginScreen();
                },
              ),
            );
          },
        );
      }
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 300,
                backgroundColor: Colors.transparent,
                child: Image.asset('assets/app_icon.png'),
              ),
              Text(
                'Vyavassay',
                style: TextStyle(
                  fontSize: titleLargeTextSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
