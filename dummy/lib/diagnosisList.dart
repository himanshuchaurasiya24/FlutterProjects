import 'package:dummy/addDiagnosis.dart';
import 'package:dummy/database_helper.dart';
import 'package:flutter/material.dart';

class DiagnosisList extends StatefulWidget {
  const DiagnosisList({super.key});

  @override
  State<DiagnosisList> createState() => _DiagnosisListState();
}

class _DiagnosisListState extends State<DiagnosisList> {
  final database = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis History'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddDiagnosis();
              },
            ),
          ).then((value) {
            setState(() {});
          });
        },
        label: const Text('Add Diagnosis'),
      ),
      body: FutureBuilder(
        future: database.getDiagnosisModel(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('Loading'),
            );
          } else {
            if (snapshot.data != null) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No Data to display'),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      child: ListTile(
                        title: Text(
                          snapshot.data![index].patientName,
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data![index].id.toString(),
                            ),
                            Text(
                              snapshot.data![index].patientAge,
                            ),
                            Text(
                              snapshot.data![index].patientSex,
                            ),
                            Text(
                              snapshot.data![index].refBy,
                            ),
                            Text(
                              snapshot.data![index].diagnosisRemark,
                            ),
                            Text(
                              snapshot.data![index].diagnosisType,
                            ),
                            Text(
                              snapshot.data![index].totalAmount.toString(),
                            ),
                            Text(
                              snapshot.data![index].paid.toString(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
          }
          return const Center(
            child: Text('Returning from last'),
          );
        },
      ),
    );
  }
}
