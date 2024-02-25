import 'package:flutter/material.dart';
import 'package:zaitoon_db_remember/component/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.icon,
    this.passwordVisible,
  });
  final String labelText;
  final TextEditingController controller;
  final Icon icon;
  final bool? passwordVisible;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.9,
      height: 55,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: TextFormField(
        cursorColor: primaryColor,
        controller: controller,
        obscureText: passwordVisible == null ? false : !passwordVisible!,
        decoration: InputDecoration(
          hintText: labelText,
          icon: Padding(
            padding: const EdgeInsets.only(
              left: 15,
            ),
            child: icon,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
