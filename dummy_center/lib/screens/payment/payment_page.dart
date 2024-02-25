import 'package:dummy_center/database/database_helper.dart';
import 'package:dummy_center/models/payment_model.dart';
import 'package:dummy_center/screens/payment/add_payment.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final DatabaseHelper db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Page'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddPayment();
              },
            ),
          );
        },
        label: const Text('Add Payment'),
      ),
      body: FutureBuilder<List<PaymentModel>>(
        future: db.getPaymentModel(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const Center(
                child: Text('Null data for display'),
              );
            }
            if (snapshot.data != null) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No data to display'),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            snapshot.data![index].id.toString(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data![index].doctorId.toString(),
                          ),
                          Text(
                            snapshot.data![index].patientId.toString(),
                          ),
                          Text(snapshot.data![index].diagnosisType),
                          Text(
                            snapshot.data![index].totalAmount.toString(),
                          ),
                          Text(
                            snapshot.data![index].paidAmount.toString(),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }
          }
          return const Text('Returning from last');
        },
      ),
    );
  }
}
