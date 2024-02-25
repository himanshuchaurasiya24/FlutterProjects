import 'package:dummy_center/database/database_helper.dart';
import 'package:dummy_center/models/doctor_model.dart';
import 'package:flutter/material.dart';

class AddDoctor extends StatelessWidget {
  AddDoctor({super.key});
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final DatabaseHelper db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Doctor'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await db.insertDoctorModel(
                  model: DoctorModel(
                    name: nameController.text,
                    address: addressController.text,
                    phoneNumber: phoneNumberController.text.toString(),
                  ),
                );
              },
              child: const Text('Add Doctor'),
            ),
          ],
        ),
      ),
    );
  }
}
