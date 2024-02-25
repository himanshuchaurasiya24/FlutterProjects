import 'package:desktop_sqlite_app/components/colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback press;
  const Button({
    super.key,
    required this.label,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: press,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
