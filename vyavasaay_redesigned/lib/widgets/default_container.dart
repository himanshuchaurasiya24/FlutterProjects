import 'package:flutter/material.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';

class DefaultContainer extends StatelessWidget {
  const DefaultContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(defaultSize),
      child: Container(
        height: getDeviceHeight(context: context),
        width: getDeviceWidth(context: context),
        decoration: BoxDecoration(
          color: primaryColorDark,
          borderRadius: BorderRadius.circular(
            defaultSize,
          ),
        ),
        child: child,
      ),
    );
  }
}
