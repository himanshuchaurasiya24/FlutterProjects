import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.onChanged,
    required this.controller,
    required this.labelText,
    this.inputType,
  });
  final String labelText;
  final Function(String)? onChanged;
  final TextInputType? inputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: inputType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText can\'nt be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
