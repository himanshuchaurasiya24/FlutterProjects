import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  String getDate(String date) {
    DateTime tempDate = DateFormat('MMMM yyyy dd').parse(date);

    final parsedDate = DateFormat('d/M/y');
    return parsedDate.format(tempDate);
  }

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
                    return GestureDetector(
                      onTap: () async {
                        // ignore: unused_local_variable
                        BuildContext dialogContext;
                        await showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            dialogContext = context;
                            return AlertDialog(
                              title: const Text(
                                'Delete entry',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: const Text(
                                  'Are you sure you want to delete this entry?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No, Go Back'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await db
                                        .deleteDiagnosisEntry(
                                            id: snapshot.data![index].id!)
                                        .then((value) {
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Text(
                                    'Yes, Delete this entry',
                                    style: TextStyle(
                                      color: Colors.red[400],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ).then((value) {
                          setState(() {});
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 10,
                          bottom: 10,
                          top: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${snapshot.data![index].patientName} ${getDate(snapshot.data![index].date)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data![index].doctorName,
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          snapshot.data![index].patientAge,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          snapshot.data![index].patientSex,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      snapshot.data![index].diagnosisRemarks,
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Incentive: ${snapshot.data![index].incentiveAmount}',
                                    ),
                                    Text(
                                      'Percent: ${snapshot.data![index].incentivePercent}',
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total: ${snapshot.data![index].totalAmount}',
                                    ),
                                    Text(
                                      'Paid: ${snapshot.data![index].paidAmount}',
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
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
