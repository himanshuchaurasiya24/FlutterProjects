import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  String getDate(String date) {
    DateTime tempDate = DateFormat('MMMM yyyy dd').parse(date);

    final parsedDate = DateFormat('d/M/y');
    return parsedDate.format(tempDate);
  }

  @override
  void initState() {
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
        actions: [
          TextButton(
            onPressed: () async {
              if (searchController.text.isNotEmpty) {
                if (incentiveList.isNotEmpty) {
                  final pdfFile = await PdfParagraphApi.calculatorList(
                      model: incentiveList);
                  PdfApi.openFile(file: pdfFile);
                } else {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Please add data from the list below.',
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
                }
              } else {
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
              }
            },
            child: const Text(
              'Generate Incentive Pdf',
            ),
          ),
        ],
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
                                  title: Text(
                                    doctorName,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index].address,
                                  ),
                                  trailing: IconButton(
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
                                          if (diagnosisList.isNotEmpty) {
                                            String doctorName =
                                                diagnosisList[0].doctorName;
                                            List<IncentivePatientDetails>
                                                details = [];
                                            for (int i = 0;
                                                i < diagnosisList.length;
                                                i++) {
                                              DiagnosisInfo info =
                                                  diagnosisList[i];
                                              details.add(
                                                IncentivePatientDetails(
                                                  patientName: info.patientName,
                                                  date: info.date,
                                                  totalAmount: info.totalAmount,
                                                  paidAmount: info.paidAmount,
                                                  remarks:
                                                      info.diagnosisRemarks,
                                                  percent:
                                                      info.incentivePercent,
                                                  incentiveAmount:
                                                      info.incentiveAmount,
                                                  discount: (int.tryParse(info
                                                              .totalAmount)! -
                                                          int.tryParse(
                                                              info.paidAmount)!)
                                                      .toString(),
                                                ),
                                              );
                                            }
                                            incentiveList.add(
                                              IncentiveGenModel(
                                                doctorName: doctorName,
                                                patientDetails: details,
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'No data for $doctorName for this month!',
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.picture_as_pdf_outlined,
                                        color: Colors.black,
                                      )),
                                  children: [
                                    Container(
                                      height: 400,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          // color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(6)),
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
                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 30,
                                                        right: 10,
                                                        bottom: 10,
                                                        top: 10,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.red[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${snapshot.data![index].patientName} ${getDate(snapshot.data![index].date)} ',
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        snapshot
                                                                            .data![index]
                                                                            .patientAge,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        snapshot
                                                                            .data![index]
                                                                            .patientSex,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .diagnosisRemarks,
                                                                  )
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
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
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
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
