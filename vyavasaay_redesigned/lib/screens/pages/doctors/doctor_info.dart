import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/model/doctor_model.dart';
import 'package:vyavasaay_redesigned/screens/pages/doctors/add_doctor.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/custom_textfield.dart';
import 'package:vyavasaay_redesigned/widgets/default_container.dart';
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
  @override
  void initState() {
    super.initState();
    databaseHelper.initDB().whenComplete(() {
      doctorList = databaseHelper.getDoctorList();
    });
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
                            Gap(defaultSize),
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
                    return const AddDoctor();
                  },
                ),
              ).then(
                (value) {
                  if (value != 0) {
                    setState(() {});
                  }
                },
              );
            },
            child: DefaultContainer(
              height: MediaQuery.of(context).size.height * 0.1,
              width: 260,
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
                  'Add a doctor',
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
