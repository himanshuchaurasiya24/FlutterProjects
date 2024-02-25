import 'package:dummy_center/database/database_helper.dart';
import 'package:dummy_center/models/patient_model.dart';
import 'package:dummy_center/screens/patient/add_patient.dart';
import 'package:flutter/material.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  final DatabaseHelper db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Information'),
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
                return AddPatient();
              },
            ),
          );
        },
        label: const Text('Add Patient'),
      ),
      body: FutureBuilder<List<PatientModel>>(
        future: db.getPatientModel(),
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
                          Text(snapshot.data![index].date),
                          Text(snapshot.data![index].patientName),
                          Text(
                            snapshot.data![index].patientAge.toString(),
                          ),
                          Text(snapshot.data![index].patientSex),
                          Text(snapshot.data![index].diagnosisType),
                          Text(snapshot.data![index].patientPhoneNumber),
                          Text(snapshot.data![index].patientDiagnosisRemark),
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
