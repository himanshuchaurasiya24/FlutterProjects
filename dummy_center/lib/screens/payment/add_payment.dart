import 'package:dummy_center/database/database_helper.dart';
import 'package:dummy_center/models/payment_model.dart';
import 'package:flutter/material.dart';

class AddPayment extends StatelessWidget {
  AddPayment({super.key});
  final doctorIdController = TextEditingController();
  final patientIdController = TextEditingController();
  final diagnosisController = TextEditingController();
  final totalAmountController = TextEditingController();
  final paidAmountController = TextEditingController();
  final DatabaseHelper db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Payment'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: doctorIdController,
            decoration: const InputDecoration(
              labelText: 'doctor id',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: patientIdController,
            decoration: const InputDecoration(
              labelText: 'patient id',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: diagnosisController,
            decoration: const InputDecoration(
              labelText: 'diagnosis type',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: totalAmountController,
            decoration: const InputDecoration(
              labelText: 'total amount',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: paidAmountController,
            decoration: const InputDecoration(
              labelText: 'paid amount',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              await db.insertPaymentModel(
                model: PaymentModel(
                  doctorId: int.parse(doctorIdController.text),
                  patientId: int.parse(patientIdController.text),
                  diagnosisType: diagnosisController.text,
                  totalAmount: int.parse(totalAmountController.text),
                  paidAmount: int.parse(
                    paidAmountController.text,
                  ),
                ),
              );
            },
            child: const Text('Add Payment'),
          ),
        ],
      ),
    );
  }
}
