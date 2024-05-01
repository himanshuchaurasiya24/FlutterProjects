import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/default_container.dart';

class ContainerButton extends StatefulWidget {
  const ContainerButton({
    super.key,
    required this.iconData,
    required this.btnName,
  });
  final IconData iconData;
  final String btnName;

  @override
  State<ContainerButton> createState() => _ContainerButtonState();
}

class _ContainerButtonState extends State<ContainerButton> {
  Color containerColor = primaryColor;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          containerColor = primaryColorDarker;
        });
      },
      onExit: (event) {
        setState(() {
          containerColor = primaryColor;
        });
      },
      child: DefaultContainer(
        color: containerColor,
        height: getDeviceHeight(context: context) * 0.125,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.iconData,
                size: 30,
              ),
              Gap(defaultSize),
              Text(
                widget.btnName,
                style: patientHeader,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
