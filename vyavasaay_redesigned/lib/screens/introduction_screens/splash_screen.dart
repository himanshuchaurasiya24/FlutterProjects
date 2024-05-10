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
  String centerName = '';
  String loggedInName = 'null';

  @override
  void initState() {
    isIntro();
    database.initDB();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void isIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isIntro = prefs.getBool('isIntrodu') ?? false;
    bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    int? loggedInId = prefs.getInt('loggedInId') ?? 0;
    debugPrint('${loggedInId}splash id');
    String? logInType = prefs.getString('logInType') ?? 'Technician';
    String centerName = prefs.getString('centerName') ?? '';
    loggedInName = loggedInId == 0
        ? 'null'
        : await database.getAccountName(id: loggedInId);
    debugPrint(loggedInName);
    final adminActLength = await database.getAdminAccountLength();
    if (adminActLength == 0) {
      await prefs.clear().then((value) {
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
      if (isLoggedIn && loggedInName != 'null') {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isLoggedIn.toString() + loggedInId.toString() + loggedInName,
              ),
            ),
          );
        }

        Timer(
          const Duration(seconds: 1),
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen(
                    centerName: centerName,
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
                'Vyavasaay',
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
