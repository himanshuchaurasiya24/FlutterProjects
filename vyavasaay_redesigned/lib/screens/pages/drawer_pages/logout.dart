import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/screens/introduction_screens/splash_screen.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';

class Logout extends StatelessWidget {
  Logout({super.key});
  final database = DatabaseHelper();
  void navigate(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const SplashScreen();
        },
      ),
    );
  }

  void logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('isLoggedIn', false);

    navigate(context);
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      logOut(context);
    });
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Logging you out!',
            style: TextStyle(
              fontSize: titleLargeTextSize,
            ),
          ),
        ],
      ),
    );
  }
}
