import 'package:dummy/data_list.dart';
import 'package:dummy/diagnosisList.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home,'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const DoctorList();
                    },
                  ),
                );
              },
              child: const Text('Doctor List'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const DiagnosisList();
                    },
                  ),
                );
              },
              child: const Text('Diagnosis History'),
            ),
          ],
        ),
      ),
    );
  }
}
