import 'package:dummy_center/database/database_helper.dart';
import 'package:dummy_center/models/patient_model.dart';
import 'package:flutter/material.dart';

class AddPatient extends StatelessWidget {
  AddPatient({super.key});
  final doctorIdController = TextEditingController();
  final dateController = TextEditingController();
  final patientNameController = TextEditingController();
  final patientAgeController = TextEditingController();
  final patientSexController = TextEditingController();
  final diagnosisTypeController = TextEditingController();
  final patientPhoneNumberController = TextEditingController();
  final patientDiagnosisRemarkController = TextEditingController();
  final DatabaseHelper db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Patient'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: doctorIdController,
            decoration: const InputDecoration(
              labelText: 'Doctor Id',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: dateController,
            decoration: const InputDecoration(
              labelText: 'Date',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: patientNameController,
            decoration: const InputDecoration(
              labelText: 'Patient Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: patientAgeController,
            decoration: const InputDecoration(
              labelText: 'Patient Age',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: patientSexController,
            decoration: const InputDecoration(
              labelText: 'Patient Sex',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: diagnosisTypeController,
            decoration: const InputDecoration(
              labelText: 'Diagnosis Type',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: patientPhoneNumberController,
            decoration: const InputDecoration(
              labelText: 'Patient Phone Number',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: patientDiagnosisRemarkController,
            decoration: const InputDecoration(
              labelText: 'Diagnosis Remark',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              await db.insertPatientModel(
                model: PatientModel(
                  doctorId: int.parse(doctorIdController.text),
                  date: dateController.text,
                  patientName: patientNameController.text,
                  patientAge: int.parse(patientAgeController.text),
                  patientSex: patientSexController.text,
                  diagnosisType: diagnosisTypeController.text,
                  patientPhoneNumber: patientPhoneNumberController.text,
                  patientDiagnosisRemark: patientDiagnosisRemarkController.text,
                ),
              );
            },
            child: const Text('Add Patient'),
          ),
        ],
      ),
    );
  }
}
