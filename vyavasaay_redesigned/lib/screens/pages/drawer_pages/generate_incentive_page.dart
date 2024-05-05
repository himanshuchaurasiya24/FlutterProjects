import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';

class GenerateIncentive extends StatelessWidget {
  const GenerateIncentive({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Generate Incentive',
          style: appbar,
        ),
        Gap(defaultSize),
      ],
    );
  }
}
