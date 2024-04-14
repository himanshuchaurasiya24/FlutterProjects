import 'package:flutter/material.dart';
import 'package:food_delivery_mitch/components/constants.dart';
import 'package:food_delivery_mitch/components/my_button.dart';
import 'package:food_delivery_mitch/components/my_textformfield.dart';
import 'package:food_delivery_mitch/pages/login_page.dart';
import 'package:gap/gap.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
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
                  // color: Theme.of(context).colorScheme.inversePrimary,
                ),
                Text(
                  'Create an account',
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
                  isObscure: true,
                  hintText: 'Password',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passwordController,
                ),
                const Gap(10),
                MyTextformfield(
                  isObscure: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  hintText: 'Confirm Password',
                  controller: cPasswordController,
                ),
                const Gap(10),
                MyButton(
                  onTap: () {},
                  text: 'Register Now',
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Gap(4),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginPage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Sign in',
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
