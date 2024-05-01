import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/model/patient_model.dart';
import 'package:vyavasaay_redesigned/screens/pages/patients/generate_new_bill.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/container_button.dart';
import 'package:vyavasaay_redesigned/widgets/custom_textfield.dart';
import 'package:vyavasaay_redesigned/widgets/default_container.dart';
import 'package:vyavasaay_redesigned/widgets/patient_details_child.dart';

class BillHistory extends StatefulWidget {
  const BillHistory({super.key});

  @override
  State<BillHistory> createState() => _BillHistoryState();
}

class _BillHistoryState extends State<BillHistory> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  bool isAdminLogin = false;
  late Future<List<PatientModel>> patientList;
  @override
  void initState() {
    super.initState();
    databaseHelper.initDB();
    patientList = databaseHelper.getPatientList();
    getTechnicianInfo();
  }

  void getTechnicianInfo() async {
    final pref = await SharedPreferences.getInstance();
    String loggedInAs = pref.getString('logInType') ?? 'user';
    if (loggedInAs == 'admin') {
      isAdminLogin = true;
    } else {
      isAdminLogin = false;
    }
  }

  final searchController = TextEditingController();
  Future<List<PatientModel>> getPatientList() {
    setState(() {
      if (searchController.text.isNotEmpty) {
        patientList = databaseHelper.searchPatient(data: searchController.text);
      } else if (searchController.text.isEmpty) {
        patientList = databaseHelper.getPatientList();
      }
    });
    return patientList;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CustomTextField(
              controller: searchController,
              hintText: 'Search here...',
              onChanged: (p0) async {
                {
                  getPatientList();
                }
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: getPatientList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Some error occurred!',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'Empty List',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      );
                    }
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 0,
                        color: primaryCardColor,
                        child: ExpansionTile(
                          title: Text(snapshot.data![index].name,
                              style: patientHeader),
                          trailing: Text(
                            snapshot.data![index].date,
                            style: patientHeaderSmall,
                          ),
                          subtitle: FutureBuilder(
                            future: databaseHelper.searchDoctorById(
                                id: snapshot.data![index].id!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text('Loading',
                                    style: patientHeaderSmall);
                              }
                              return Text(
                                snapshot.data!.name,
                                style: patientHeaderSmall,
                              );
                            },
                          ),
                          childrenPadding: EdgeInsets.only(
                            left: defaultSize,
                            right: defaultSize,
                            bottom: defaultSize,
                          ),
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        PatientDetailsChild(
                                          heading: 'Age ',
                                          value: snapshot.data![index].age
                                              .toString(),
                                        ),
                                        Gap(defaultSize),
                                        PatientDetailsChild(
                                          heading: 'Sex ',
                                          value: snapshot.data![index].sex,
                                        ),
                                        Gap(defaultSize),
                                        PatientDetailsChild(
                                          heading: 'Diagnosis type ',
                                          value: snapshot.data![index].type,
                                        ),
                                        Gap(defaultSize),
                                        PatientDetailsChild(
                                          heading: 'Bill generated by ',
                                          value:
                                              snapshot.data![index].technician,
                                        ),
                                        Gap(defaultSize),
                                        PatientDetailsChild(
                                          heading: 'Remark ',
                                          value: snapshot.data![index].remark,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        PatientDetailsChild(
                                          heading: 'Total ',
                                          value: snapshot
                                              .data![index].totalAmount
                                              .toString(),
                                        ),
                                        Gap(defaultSize),
                                        PatientDetailsChild(
                                          heading: 'Paid ',
                                          value: snapshot
                                              .data![index].paidAmount
                                              .toString(),
                                        ),
                                        Gap(defaultSize),
                                        PatientDetailsChild(
                                          heading: 'Discount given by center ',
                                          value: snapshot.data![index].discCen
                                              .toString(),
                                        ),
                                        Gap(defaultSize),
                                        PatientDetailsChild(
                                          heading: 'Discount given by doctor ',
                                          value: snapshot.data![index].discDoc
                                              .toString(),
                                        ),
                                        Gap(defaultSize),
                                        PatientDetailsChild(
                                          heading: 'Incentive % ',
                                          value: snapshot.data![index].percent
                                              .toString(),
                                        ),
                                        Gap(defaultSize),
                                        PatientDetailsChild(
                                          heading: 'Incentive amount ',
                                          value: snapshot.data![index].incentive
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: isAdminLogin,
                                  child: Gap(defaultSize),
                                ),
                                Visibility(
                                  visible: isAdminLogin,
                                  child: GestureDetector(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return GenerateNewBill(
                                                isUpdate: true,
                                                model: snapshot.data![index],
                                              );
                                            },
                                          ),
                                        ).then((value) => setState(() {}));
                                      },
                                      child: const ContainerButton(
                                          iconData: Icons.edit_outlined,
                                          btnName: 'Edit bill')),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 10,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const GenerateNewBill();
                  },
                ),
              ).then(
                (value) {
                  setState(() {});
                },
              );
            },
            child: DefaultContainer(
              height: getDeviceHeight(context: context) * 0.1,
              width: getDeviceWidth(context: context) * 0.25,
              boxShadow: [
                BoxShadow(
                  color: primaryColorDark,
                  blurStyle: BlurStyle.outer,
                  blurRadius: 50,
                  spreadRadius: 0.5,
                ),
              ],
              child: Center(
                child: Text(
                  'Generate new bill',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 28,
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
