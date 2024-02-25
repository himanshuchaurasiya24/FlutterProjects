import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaitoon_db_remember/component/buttons.dart';
import 'package:zaitoon_db_remember/component/colors.dart';
import 'package:zaitoon_db_remember/component/textfield.dart';
import 'package:zaitoon_db_remember/json/user_model.dart';
import 'package:zaitoon_db_remember/provider/provider.dart';
import 'package:zaitoon_db_remember/sqlite/database_helper.dart';
import 'package:zaitoon_db_remember/views/home.dart';

import 'package:zaitoon_db_remember/views/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  bool isChecked = false;
  bool isLogIn = false;
  final db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Log in',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/background.jpg',
                ),
              ),
              CustomTextField(
                labelText: 'Username',
                icon: const Icon(
                  Icons.person,
                ),
                passwordVisible: true,
                controller: usernameController,
              ),
              CustomTextField(
                labelText: 'Password',
                icon: const Icon(
                  Icons.password,
                ),
                passwordVisible: false,
                controller: passwordController,
              ),
              Consumer<UiProvider>(
                builder: (context, UiProvider notifier, child) {
                  return ListTile(
                    horizontalTitleGap: 10,
                    title: const Text(
                      'Remember me',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    leading: Checkbox(
                        activeColor: primaryColor,
                        value: notifier.ischecked,
                        onChanged: (value) {
                          notifier.toggleCheck();
                        }),
                  );
                },
              ),
              Consumer(
                builder: (context, UiProvider notifier, child) {
                  return Button(
                    buttonText: 'Log in',
                    press: () async {
                      // UserModel? userDetails =
                      //     await db.getUser(usernameController.text);
                      var res = await db.authenticate(UserModel(
                        userName: usernameController.text,
                        usrPassword: passwordController.text,
                      ));
                      if (res == true) {
                        if (notifier.ischecked) {
                          notifier.setRememberMe();
                        }
                        if (!mounted) return;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const HomeScreen();
                            },
                          ),
                        );
                      } else {
                        setState(() {
                          isLogIn = true;
                        });
                      }
                    },
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              isLogIn
                  ? const Text(
                      'Username or password is incorrect!',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
