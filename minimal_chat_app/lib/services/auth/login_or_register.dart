import 'package:flutter/material.dart';
import 'package:minimal_chat_app/pages/login_page.dart';
import 'package:minimal_chat_app/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;
  void onTap() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoginPage ? LoginPage(onTap: onTap) : RegisterPage(onTap: onTap);
  }
}
