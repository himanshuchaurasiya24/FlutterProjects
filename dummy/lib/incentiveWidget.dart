import 'package:flutter/material.dart';

class IncentiveWidget extends StatelessWidget {
  IncentiveWidget({
    super.key,
    required this.doctorName,
    required this.incentiveAmount,
  });
  int incentiveAmount;
  String doctorName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctorName),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          incentiveAmount.toString(),
        ),
      ),
    );
  }
}
