import 'package:dummy/add_doctor.dart';
import 'package:dummy/database/database_helper.dart';
import 'package:dummy/model/diagnosisModel.dart';
import 'package:flutter/material.dart';

class AddDiagnosis extends StatelessWidget {
  AddDiagnosis({super.key});
  final patientNameController = TextEditingController();
  final patientAgeController = TextEditingController();
  final patientSexController = TextEditingController();
  final refByController = TextEditingController();
  final diagnosisRemarkController = TextEditingController();
  final totalAmountController = TextEditingController();
  final paidController = TextEditingController();
  final diagnosisTypeController = TextEditingController();
  final db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Diagnosis'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextForm(
              nameController: patientNameController,
              hintText: 'Patient Name',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextForm(
              nameController: patientAgeController,
              hintText: 'Patient Age',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextForm(
              nameController: patientSexController,
              hintText: 'Sex',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextForm(
              nameController: refByController,
              hintText: 'Ref By Doctor',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextForm(
              nameController: diagnosisTypeController,
              hintText: 'Diagnosis Type',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextForm(
              nameController: diagnosisRemarkController,
              hintText: 'Diagnosis Remark',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextForm(
              nameController: totalAmountController,
              hintText: 'Total Amount',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextForm(
              nameController: paidController,
              hintText: 'Paid',
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await db
                    .insertDiagnosisModel(
                  model: DiagnosisModel(
                    patientName: patientNameController.text,
                    patientAge: patientAgeController.text,
                    patientSex: patientSexController.text,
                    refBy: refByController.text,
                    diagnosisRemark: diagnosisRemarkController.text,
                    totalAmount: int.parse(totalAmountController.text),
                    paid: int.parse(paidController.text),
                    diagnosisType: diagnosisTypeController.text,
                  ),
                )
                    .then((value) {
                  Navigator.pop(context);
                });
              },
              child: const Text(
                'Add Diagnosis',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
