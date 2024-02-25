import 'package:flutter/material.dart';
import 'package:zaitoon_db_remember/component/buttons.dart';
import 'package:zaitoon_db_remember/component/colors.dart';
import 'package:zaitoon_db_remember/views/login.dart';
import 'package:zaitoon_db_remember/views/signup.dart';

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Authentication',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const Text(
                  'Authentication to access your vital information',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    'assets/startup.jpg',
                    // fit: BoxFit.contain,
                  ),
                ),
                Button(
                  buttonText: 'Log in',
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
                        },
                      ),
                    );
                  },
                ),
                Button(
                  buttonText: 'Sign Up',
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
