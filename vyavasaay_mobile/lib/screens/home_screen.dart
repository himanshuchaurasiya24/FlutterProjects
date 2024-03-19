import 'package:flutter/material.dart';
import 'package:vyavasaay_mobile/screens/diagnosis/diagnosis_history.dart';
import 'package:vyavasaay_mobile/screens/doctors/doctors_screen.dart';
import 'package:vyavasaay_mobile/widgets/custom_elevated_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vyavasaay',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomElevatedButton(
                btnName: 'Doctors List',
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const DoctorsScreen();
                      },
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomElevatedButton(
                btnName: 'Diagnosis Information',
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const DiagnosisInformation();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
