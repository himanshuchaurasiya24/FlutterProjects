import 'package:flutter/material.dart';
import 'package:vyawasaay/database/database_helper.dart';
import 'package:vyawasaay/models/diagnosis_info.dart';
import 'package:vyawasaay/screens/diagnosis/new_diagnosis.dart';
import 'package:vyawasaay/widgets/custom_elevated_button.dart';

class DiagnosisInformation extends StatefulWidget {
  const DiagnosisInformation({super.key});

  @override
  State<DiagnosisInformation> createState() => _DiagnosisInformationState();
}

class _DiagnosisInformationState extends State<DiagnosisInformation> {
  DatabaseHelper db = DatabaseHelper();
  late Future<List<DiagnosisInfo>> diagnosisList;
  @override
  void initState() {
    diagnosisList = db.getDiagnosisHistory();
    db.initDB().whenComplete(() {
      diagnosisList = db.getDiagnosisHistory();
    });
    super.initState();
  }

  final DatabaseHelper database = DatabaseHelper();

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
          function: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const NewDiagnosis();
                },
              ),
            ).then((value) {
              setState(() {});
            });
          }),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: database.getDiagnosisHistory(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No Diagnosis Found in Database'),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.blue[40],
                      child: Column(
                        children: [
                          Text(snapshot.data![index].patientName),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data![index].patientAge,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot.data![index].patientSex,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot.data![index].date,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot.data![index].dignosisType,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot.data![index].diagnosisRemarks,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot.data![index].totalAmount,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot.data![index].paidAmount,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot.data![index].incentiveAmount,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot.data![index].doctorId.toString(),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot.data![index].doctorName,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text('Null data to display'),
              );
            }
            return const Center(
              child: Text('Returning from last'),
            );
          },
        ),
      ),
    );
  }
}
