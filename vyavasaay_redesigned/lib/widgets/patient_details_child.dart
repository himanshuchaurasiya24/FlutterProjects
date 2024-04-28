import 'package:flutter/material.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';

class PatientDetailsChild extends StatelessWidget {
  const PatientDetailsChild({
    super.key,
    required this.heading,
    required this.value,
  });
  final String heading;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          heading,
          style: patientChildrenHeading,
        ),
        Text(
          value,
          style: patientHeaderSmall,
        ),
      ],
    );
  }
}
