import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/services/auth/auth_service.dart';
import 'package:minimal_chat_app/components/my_button.dart';
import 'package:minimal_chat_app/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPController = TextEditingController();
  bool isLoading = false;
  void register() {
    AuthService authService = AuthService();
    if (passwordController.text == confirmPController.text) {
      try {
        setState(() {
          isLoading = true;
        });
        authService
            .signUpWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        )
            .then((value) {
          setState(() {
            isLoading = false;
          });
        }).onError((error, stackTrace) {
          setState(() {
            isLoading = false;
          });
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          error.toString(),
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )));
            },
          );
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
                child: Text(
              e.toString(),
            ));
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      'Password doesn\'t match',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message_outlined,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'Let\'s create an account for you!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            MyTextfield(
              hintText: 'Email',
              controller: emailController,
            ),
            const SizedBox(
              height: 50,
            ),
            MyTextfield(
              hintText: 'Password',
              isObscure: true,
              controller: passwordController,
            ),
            const SizedBox(
              height: 50,
            ),
            MyTextfield(
              hintText: 'Confirm Password',
              isObscure: true,
              controller: confirmPController,
            ),
            const SizedBox(
              height: 50,
            ),
            MyButton(
              isLoading: isLoading,
              btnName: 'Register',
              ontap: register,
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already a member?',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                TextButton(
                  onPressed: widget.onTap,
                  child: const Text(
                    'Login Now',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
