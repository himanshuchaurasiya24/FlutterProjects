import 'package:flutter/material.dart';
import 'package:zaitoon_db_remember/component/buttons.dart';
import 'package:zaitoon_db_remember/component/colors.dart';
import 'package:zaitoon_db_remember/component/textfield.dart';
import 'package:zaitoon_db_remember/json/user_model.dart';
import 'package:zaitoon_db_remember/sqlite/database_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final fullNameController = TextEditingController();

  final emailController = TextEditingController();

  final usernameController = TextEditingController();

  final passwrodController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final DatabaseHelper db = DatabaseHelper();

  signup() async {
    final res = await db.createUser(
      UserModel(
        fullName: fullNameController.text,
        email: emailController.text,
        userName: usernameController.text,
        usrPassword: passwrodController.text,
      ),
    );
    if (res > 0) {
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: Text(
                  'Register a new account',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 55,
                      fontWeight: FontWeight.bold),
                ),
              ),
              CustomTextField(
                labelText: 'Full Name',
                controller: fullNameController,
                icon: const Icon(Icons.person),
              ),
              CustomTextField(
                labelText: 'Email',
                controller: emailController,
                icon: const Icon(Icons.email),
              ),
              CustomTextField(
                labelText: 'Username',
                controller: usernameController,
                icon: const Icon(Icons.person_2),
              ),
              CustomTextField(
                labelText: 'Password',
                controller: passwrodController,
                icon: const Icon(Icons.password),
              ),
              CustomTextField(
                labelText: 'Confirm Password',
                controller: confirmPasswordController,
                icon: const Icon(Icons.password),
              ),
              Button(
                  buttonText: 'Sign up',
                  press: () async {
                    signup();
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
