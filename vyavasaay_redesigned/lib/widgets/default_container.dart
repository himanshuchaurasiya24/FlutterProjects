import 'package:flutter/material.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';

class DefaultContainer extends StatelessWidget {
  const DefaultContainer({
    super.key,
    required this.child,
    this.width,
    this.color,
    this.height,
    this.boxShadow,
  });
  final Widget child;
  final double? width;
  final double? height;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(defaultSize),
      child: Container(
        height: height ?? getDeviceHeight(context: context),
        width: width ?? getDeviceWidth(context: context),
        decoration: BoxDecoration(
          color: color ?? primaryColorDark,
          borderRadius: BorderRadius.circular(
            defaultSize,
          ),
          boxShadow: boxShadow,
        ),
        child: child,
      ),
    );
  }
}
