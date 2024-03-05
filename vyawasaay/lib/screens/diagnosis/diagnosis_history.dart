import 'package:flutter/material.dart';
import 'package:vyawasaay/screens/diagnosis/new_diagnosis.dart';
import 'package:vyawasaay/widgets/custom_elevated_button.dart';

class DiagnosisInformation extends StatefulWidget {
  const DiagnosisInformation({super.key});

  @override
  State<DiagnosisInformation> createState() => _DiagnosisInformationState();
}

class _DiagnosisInformationState extends State<DiagnosisInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diagnosis Information',
        ),
        centerTitle: true,
      ),
      floatingActionButton: CustomElevatedButton(
          btnName: 'Make new diagnosis',
          function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return NewDiagnosis();
                },
              ),
            );
          }),
    );
  }
}
