import 'package:flutter/material.dart';
import 'package:vyavasaay_redesigned/screens/login_signup_screens/login_screen.dart';

import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/default_container.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
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
                        'Sign Up',
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
                      CustomTextField(
                        controller: confirmPasswordController,
                        hintText: 'Confirm Password',
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      CustomTextField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        hintText: 'Phone Number',
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
                              'Sign Up',
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
                                  'Already have an account?',
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
                                          return const LoginScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Log in instead',
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

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.isObscure,
    required this.hintText,
    this.keyboardType,
  });

  final TextEditingController controller;
  final bool? isObscure;
  final String hintText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isObscure ?? false,
      style: TextStyle(
        color: titleLargeTextColor,
      ),
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: titleLargeTextColor,
        ),
        fillColor: primaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            defaultSize,
          ),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
