import 'package:flutter/material.dart';
import 'package:vyawasaay/database/database_helper.dart';
import 'package:vyawasaay/models/diagnosis_info.dart';
import 'package:vyawasaay/models/doctor_model.dart';
import 'package:vyawasaay/models/incentive_gen_model.dart';
import 'package:vyawasaay/pdf/pdf_api.dart';
import 'package:vyawasaay/pdf/pdf_paragraph_api.dart';
import 'package:vyawasaay/screens/doctors/add_doctor_screen.dart';
import 'package:vyawasaay/widgets/custom_elevated_button.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  late DatabaseHelper handler;
  final DatabaseHelper database = DatabaseHelper();
  late Future<List<DoctorModel>> doctorList;
  late Future<List<DiagnosisInfo>> diagnosisInfo;
  final db = DatabaseHelper();
  final searchController = TextEditingController();
  Future<List<DiagnosisInfo>> filter({required String month}) async {
    return await handler.getDiagnosisHistorySearch(date: month);
  }

  List<IncentiveGenModel> incentiveList = [];

  @override
  void initState() {
    // doctorList = db.getDoctorsList();
    handler = db;
    diagnosisInfo = handler.getDiagnosisHistory();
    handler.initDB().whenComplete(() {
      doctorList = db.getDoctorsList();
      diagnosisInfo = db.getDiagnosisHistorySearch(date: searchController.text);
    });

    super.initState();
  }

  bool expansionChanged = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Doctors List',
        ),
        centerTitle: true,
      ),
      floatingActionButton: CustomElevatedButton(
        btnName: 'Add a doctor',
        function: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddDoctor();
              },
            ),
          ).then((value) {
            setState(() {});
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    if (searchController.text.isEmpty) {
                      diagnosisInfo = handler.getDiagnosisHistory();
                    } else {
                      diagnosisInfo = filter(month: value);
                    }
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Search by month here',
                  prefixIcon: Icon(Icons.search_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: FutureBuilder(
                future: database.getDoctorsList(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No Doctor Found in Database'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String doctorName = snapshot.data![index].doctorName;
                          int doctorId = snapshot.data![index].id!;
                          return Column(
                            children: [
                              GestureDetector(
                                onDoubleTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return AddDoctor(
                                          isUpdate: true,
                                          id: snapshot.data![index].id,
                                          doctorName:
                                              snapshot.data![index].doctorName,
                                          doctorAddress:
                                              snapshot.data![index].address,
                                          doctorAge:
                                              snapshot.data![index].doctorAge,
                                          doctorIncentivePercentage: snapshot
                                              .data![index].incentivePercentage,
                                          doctorPhoneNumber: snapshot
                                              .data![index].doctorPhoneNumber,
                                          doctorSex:
                                              snapshot.data![index].doctorSex,
                                        );
                                      },
                                    ),
                                  ).then((value) {
                                    setState(() {});
                                  });
                                },
                                child: ExpansionTile(
                                  title: Text(doctorName),
                                  subtitle: Text(
                                    snapshot.data![index].address,
                                  ),
                                  children: [
                                    Container(
                                      height: 500,
                                      width: 600,
                                      color: Colors.red,
                                      child: FutureBuilder(
                                        future: searchController.text.isEmpty
                                            ? db.getDiagnosticHistoryByDoctorId(
                                                id: snapshot.data![index].id!)
                                            : db.getDiagnosticHistoryByDoctorIdAndMonth(
                                                id: snapshot.data![index].id!,
                                                date: searchController.text),
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
                                                  child: Text('Empty'),
                                                );
                                              } else {
                                                return ListView.builder(
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                      title: Text(
                                                        snapshot.data![index]
                                                            .patientName,
                                                      ),
                                                      subtitle: Text(snapshot
                                                          .data![index]
                                                          .patientAge),
                                                      trailing: Text(snapshot
                                                          .data![index].date),
                                                    );
                                                  },
                                                  itemCount:
                                                      snapshot.data!.length,
                                                );
                                              }
                                            }
                                          }
                                          return const Center(
                                            child: Text('Returning from last'),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.785,
                                      decoration: BoxDecoration(
                                        color: Colors.red[400],
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: TextButton(
                                        onPressed: () async {
                                          if (searchController.text.isEmpty) {
                                            await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                    'Enter month in the field provided!',
                                                  ),
                                                  actions: [
                                                    IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Text(
                                                        'Okay',
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          } else {
                                            final List<DiagnosisInfo>
                                                diagnosisList = await db
                                                    .getDiagnosticHistoryByDoctorIdAndMonth(
                                                        id: doctorId,
                                                        date: searchController
                                                            .text);
                                            for (int i = 0;
                                                i < diagnosisList.length;
                                                i++) {
                                              var diagnosisDetails =
                                                  diagnosisList[i];
                                              incentiveList.add(
                                                IncentiveGenModel(
                                                  doctorName: diagnosisDetails
                                                      .doctorName,
                                                  patientDetails: [
                                                    IncentivePatientDetails(
                                                      patientName:
                                                          diagnosisDetails
                                                              .patientName,
                                                      patientSex:
                                                          diagnosisDetails
                                                              .patientSex,
                                                      date:
                                                          diagnosisDetails.date,
                                                      totalAmount:
                                                          diagnosisDetails
                                                              .totalAmount,
                                                      paidAmount:
                                                          diagnosisDetails
                                                              .paidAmount,
                                                      discount: diagnosisDetails
                                                          .incentiveAmount,
                                                    )
                                                  ],
                                                ),
                                              );
                                            }
                                            final pdfFile =
                                                await PdfParagraphApi
                                                    .calculatorList(
                                                        model: incentiveList);
                                            PdfApi.openFile(file: pdfFile);
                                          }

//

                                          // for (int i = 0;
                                          //     i < incentiveList.length;
                                          //     i++) {
                                          //   List<IncentivePatientDetails>
                                          //       patientDetails =
                                          //       incentiveList[i].patientDetails;
                                          //   for (int j = 0;
                                          //       j < patientDetails.length;
                                          //       j++) {
                                          //     debugPrint(patientDetails[j]
                                          //         .patientName);
                                          //   }
                                          // }
                                        },
                                        child: const Text(
                                          'Add To Incentive List',
                                        ),
                                      ),
                                    )
                                  ],
                                  onExpansionChanged: (value) {
                                    expansionChanged = value;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
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
          ],
        ),
      ),
    );
  }
}
