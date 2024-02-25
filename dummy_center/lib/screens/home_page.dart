import 'package:dummy_center/screens/doctor/doctor_page.dart';
import 'package:dummy_center/screens/patient/patient_page.dart';
import 'package:dummy_center/screens/payment/payment_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const PatientPage();
                  },
                ),
              );
            },
            title: const Text('Patient'),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const DoctorPage();
                  },
                ),
              );
            },
            title: const Text('Doctor'),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const PaymentPage();
                  },
                ),
              );
            },
            title: const Text('Payment Details'),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
