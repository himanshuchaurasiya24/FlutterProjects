import 'package:flutter/material.dart';
import 'package:vyavasaay_redesigned/screens/introduction_screens/intro_1.dart';
import 'package:vyavasaay_redesigned/screens/introduction_screens/intro_2.dart';
import 'package:vyavasaay_redesigned/screens/introduction_screens/intro_3.dart';
import 'package:vyavasaay_redesigned/screens/introduction_screens/intro_4.dart';
import 'package:vyavasaay_redesigned/screens/login_signup_screens/login_screen.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  List<Widget> introScreens = <Widget>[
    const IntroScreen1(),
    const IntroScreen2(),
    const IntroScreen3(),
    const IntroScreen4(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            if (currentIndex < 3) {
              currentIndex++;
            } else {
              if (currentIndex == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginSignUpScreen();
                    },
                  ),
                );
              }
            }
          });
        },
        label: Text(currentIndex == 3 ? 'Get Started' : ''),
        icon: const Icon(
          Icons.arrow_right_alt_outlined,
        ),
      ),
      body: introScreens[currentIndex],
    );
  }
}
