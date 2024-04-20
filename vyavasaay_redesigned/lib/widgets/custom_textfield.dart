import 'package:flutter/material.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.isObscure,
    required this.hintText,
    this.keyboardType,
    this.passwordController,
    this.isConfirm,
    this.readOnly,
    this.maxLines,
    this.onChanged,
    this.valueLimit,
  });

  final TextEditingController controller;
  final bool? isObscure;
  final String hintText;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextEditingController? passwordController;
  final bool? isConfirm;
  final bool? readOnly;
  final int? maxLines;
  final int? valueLimit;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      obscureText: isObscure ?? false,
      readOnly: readOnly ?? false,
      style: TextStyle(
        color: titleLargeTextColor,
        fontWeight: FontWeight.w600,
      ),
      validator: (value) {
        if (isConfirm == true && passwordController != null) {
          if (value != passwordController!.text) {
            return 'Password does\'nt match';
          }
        }
        if (value != null && value.trim().isEmpty) {
          return 'Please enter $hintText';
        }
        if (valueLimit != null &&
            keyboardType == TextInputType.number &&
            value != null) {
          int pValue = int.tryParse(value)!;
          if (pValue > valueLimit!) {
            return 'Range is only upto $valueLimit';
          }
        }
        if (value != null && keyboardType == TextInputType.number) {
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
