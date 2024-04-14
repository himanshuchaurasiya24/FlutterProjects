import 'package:flutter/material.dart';
import 'package:food_delivery_mitch/components/constants.dart';

class MyTextformfield extends StatelessWidget {
  const MyTextformfield({
    super.key,
    required this.hintText,
    this.isObscure,
    required this.controller,
    this.autovalidateMode,
  });
  final String hintText;
  final bool? isObscure;
  final AutovalidateMode? autovalidateMode;

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure ?? false,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
      validator: (value) {
        if (value != null) {
          if (value.isEmpty) {
            return 'Please enter $hintText';
          }
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.titleSmall,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
            borderRadius: BorderRadius.circular(defaultPadding)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}
