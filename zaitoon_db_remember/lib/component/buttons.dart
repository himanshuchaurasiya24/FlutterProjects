import 'package:flutter/material.dart';
import 'package:zaitoon_db_remember/component/colors.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.buttonText,
    required this.press,
  });
  final String buttonText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      height: 55,
      width: width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: primaryColor,
      ),
      child: TextButton(
        onPressed: press,
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
