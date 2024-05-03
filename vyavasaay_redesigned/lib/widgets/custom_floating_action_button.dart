import 'package:flutter/material.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    required this.onTap,
    required this.title,
  });
  final void Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: primaryColorDark,
      onPressed: onTap,
      label: Text(
        title,
        style: patientHeader.copyWith(color: titleLargeTextColor),
      ),
    );
  }
}
