import 'package:dummy/add_doctor.dart';
import 'package:dummy/database_helper.dart';
import 'package:dummy/diagnosisModel.dart';
import 'package:dummy/incentiveWidget.dart';
import 'package:flutter/material.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({super.key});

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  DatabaseHelper db = DatabaseHelper();
  late Future<List<DiagnosisModel>> diagnosisList;
  @override
  void initState() {
    diagnosisList = db.getDiagnosisModel();
    db.initDB().whenComplete(() {
      diagnosisList = db.getDiagnosisModel();
    });
    super.initState();
  }

  final DatabaseHelper database = DatabaseHelper();
  bool isReportClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor List'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddDoctor();
              },
            ),
          ).then((value) {
            setState(() {});
          });
        },
        label: const Text('Add Doctor'),
      ),
      body: FutureBuilder(
        future: database.getDoctorModel(),
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
                    int incentive = 0;
                    String doctorName = snapshot.data![index].name;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 2,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                snapshot.data![index].name,
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isReportClicked = !isReportClicked;
                                  });
                                },
                                icon: const Icon(Icons.report),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![index].address,
                                  ),
                                  Text(
                                    snapshot.data![index].phoneNumber,
                                  ),
                                  Text(
                                    snapshot.data![index].incentive.toString(),
                                  ),
                                ],
                              ),
                            ),
                            isReportClicked
                                ? Column(
                                    children: [
                                      Container(
                                        height: 400,
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: FutureBuilder(
                                          future: database.searchDiagnosisModel(
                                              refBy:
                                                  snapshot.data![index].name),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child: Text('Loading'),
                                              );
                                            } else {
                                              if (snapshot.data != null) {
                                                if (snapshot.data!.isEmpty) {
                                                  return const Center(
                                                    child: Text(
                                                        'No Data to display'),
                                                  );
                                                } else {
                                                  return ListView.builder(
                                                    itemCount:
                                                        snapshot.data!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      incentive += snapshot
                                                          .data![index]
                                                          .totalAmount;

                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Card(
                                                          elevation: 2,
                                                          child: ListTile(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                                    return IncentiveWidget(
                                                                        doctorName:
                                                                            doctorName,
                                                                        incentiveAmount:
                                                                            incentive);
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                            title: Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .patientName,
                                                            ),
                                                            subtitle: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  incentive
                                                                      .toString(),
                                                                ),
                                                                Text(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .diagnosisType,
                                                                ),
                                                                Text(
                                                                  'Total: ${snapshot.data![index].totalAmount.toString()}',
                                                                ),
                                                                Text(
                                                                  "Paid: ${snapshot.data![index].paid.toString()}",
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }
                                              }
                                            }
                                            return const Center(
                                              child:
                                                  Text('Returning from last'),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
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
