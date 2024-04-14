import 'package:flutter/material.dart';
import 'package:food_delivery_mitch/components/constants.dart';
import 'package:food_delivery_mitch/components/my_button.dart';
import 'package:food_delivery_mitch/components/my_textformfield.dart';
import 'package:food_delivery_mitch/pages/home_page.dart';
import 'package:food_delivery_mitch/pages/register_page.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    super.key,
  });
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void login() {
    //
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock_open_outlined,
                  size: 100,
                ),
                Text(
                  'Food Delivery App',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Gap(10),
                MyTextformfield(
                  hintText: 'Email',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                ),
                const Gap(10),
                MyTextformfield(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  isObscure: true,
                  hintText: 'Password',
                  controller: passwordController,
                ),
                const Gap(10),
                MyButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const HomePage();
                          },
                        ),
                      );
                    }
                  },
                  text: 'Sign in',
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Gap(4),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return RegisterPage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Register Now!',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
