import 'package:flutter/material.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';

class PatientDetailsChild extends StatelessWidget {
  const PatientDetailsChild({
    super.key,
    required this.heading,
    required this.value,
    this.isWidgetInValue = false,
    this.valueWidget,
  });
  final String heading;
  final String value;
  final bool? isWidgetInValue;
  final Widget? valueWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          heading,
          style: patientChildrenHeading,
        ),
        isWidgetInValue!
            ? valueWidget!
            : Text(
                value,
                style: patientHeaderSmall,
              ),
      ],
    );
  }
}
