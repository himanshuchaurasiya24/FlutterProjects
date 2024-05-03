import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/model/doctor_model.dart';
import 'package:vyavasaay_redesigned/screens/pages/doctors/add_doctor.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/container_button.dart';
import 'package:vyavasaay_redesigned/widgets/custom_floating_action_button.dart';
import 'package:vyavasaay_redesigned/widgets/custom_textfield.dart';
import 'package:vyavasaay_redesigned/widgets/patient_details_child.dart';

class DoctorInfo extends StatefulWidget {
  const DoctorInfo({super.key});

  @override
  State<DoctorInfo> createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  final searchController = TextEditingController();
  late Future<List<DoctorModel>> doctorList;
  bool isAdminLogin = false;
  int doctorListLength = 0;
  @override
  void initState() {
    super.initState();
    databaseHelper.initDB().whenComplete(() {
      doctorList = databaseHelper.getDoctorList();
    });
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

  Future<List<DoctorModel>> getDoctorList() {
    if (searchController.text.isNotEmpty) {
      setState(() {
        doctorList = databaseHelper.searchDoctor(data: searchController.text);
      });
    } else {
      setState(() {
        doctorList = databaseHelper.getDoctorList();
      });
    }

    return doctorList;
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
              onChanged: (p0) {
                getDoctorList();
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: getDoctorList(),
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
                          'Empty Doctor List',
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
                          childrenPadding:
                              EdgeInsets.symmetric(horizontal: defaultSize),
                          title: Text(
                            snapshot.data![index].name,
                            style: patientHeader,
                          ),
                          subtitle: Text(
                            snapshot.data![index].address,
                            style: patientHeaderSmall,
                          ),
                          trailing: Text(
                            snapshot.data![index].phone,
                            style: patientHeaderSmall,
                          ),
                          children: [
                            PatientDetailsChild(
                              heading: 'Sex ',
                              value: snapshot.data![index].sex.toString(),
                            ),
                            Gap(defaultSize),
                            PatientDetailsChild(
                              heading: 'Age ',
                              value: snapshot.data![index].age.toString(),
                            ),
                            Gap(defaultSize),
                            PatientDetailsChild(
                              heading: 'Ultrasound % ',
                              value:
                                  snapshot.data![index].ultrasound.toString(),
                            ),
                            Gap(defaultSize),
                            PatientDetailsChild(
                              heading: 'Pathology % ',
                              value: snapshot.data![index].pathology.toString(),
                            ),
                            Gap(defaultSize),
                            PatientDetailsChild(
                              heading: 'ECG % ',
                              value: snapshot.data![index].ecg.toString(),
                            ),
                            Gap(defaultSize),
                            PatientDetailsChild(
                              heading: 'X-Ray % ',
                              value: snapshot.data![index].xray.toString(),
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
                                        return AddDoctor(
                                          isUpdate: true,
                                          model: snapshot.data![index],
                                        );
                                      },
                                    ),
                                  ).then((value) => setState(() {}));
                                },
                                child: const ContainerButton(
                                  btnName: 'Edit Doctor Info',
                                  iconData: Icons.edit_outlined,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: isAdminLogin,
                              child: Gap(defaultSize),
                            ),
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
          right: 10,
          child: CustomFloatingActionButton(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const AddDoctor();
                    },
                  ),
                ).then((value) => setState(() {}));
              },
              title: 'Add Doctor'),
        ),
      ],
    );
  }
}
