import 'package:flutter/material.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';

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
      validator: (value) {
        if (value != null && value.trim().isEmpty) {
          return 'Please enter $hintText';
        }
        if (value != null &&
            keyboardType != null &&
            keyboardType == TextInputType.number) {
          final intvalue = int.tryParse(value);
          if (intvalue == null) {
            return 'Invalid $hintText';
          }
        }
        return null;
      },
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
