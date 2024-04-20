import 'package:flutter/material.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';

class CustomSelectorCircle extends StatelessWidget {
  const CustomSelectorCircle({
    super.key,
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 28,
        backgroundColor: primaryColor,
        foregroundColor: titleLargeTextColor,
        child: Icon(
          icon,
          size: 40,
        ),
      ),
    );
  }
}
