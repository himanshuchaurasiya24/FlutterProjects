import 'package:flutter/material.dart';
import 'package:vyavasaay_redesigned/screens/login_signup_screens/signup_screen.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/default_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Color containerColor = primaryColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/login_signup.png',
            ),
            Form(
              key: _formKey,
              child: Expanded(
                child: Padding(
                  padding: EdgeInsets.all(defaultSize),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Log In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: titleLargeTextSize,
                          color: titleLargeTextColor,
                        ),
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      CustomTextField(
                        controller: nameController,
                        hintText: 'Name',
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'Password',
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      MouseRegion(
                        onEnter: (event) {
                          setState(() {
                            containerColor = primaryColorDarker;
                          });
                        },
                        onExit: (event) {
                          setState(() {
                            containerColor = primaryColor;
                          });
                        },
                        child: Container(
                          height: getDeviceHeight(context: context) * 0.1,
                          width: getDeviceWidth(context: context) * 0.55,
                          decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: BorderRadius.circular(
                              defaultSize,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                color: titleLargeTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: titleLargeTextSize - 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(
                                    color: titleLargeTextColor,
                                    fontSize: 20,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const SignUpScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Sign up instead',
                                    style: TextStyle(
                                      color: titleLargeTextColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
