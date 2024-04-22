import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/model/doctor_model.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/custom_selector_circle.dart';
import 'package:vyavasaay_redesigned/widgets/custom_textfield.dart';
import 'package:vyavasaay_redesigned/widgets/default_container.dart';

class BillHistory extends StatefulWidget {
  const BillHistory({super.key});

  @override
  State<BillHistory> createState() => _BillHistoryState();
}

class _BillHistoryState extends State<BillHistory> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final List<String> sexType = ['Male', 'Female', 'Others'];

  String selectedSex = 'Male';
  void getReportGeneratedByData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    reportGeneratedByController.text = pref.getString('loggedInName')!;
  }

  @override
  void initState() {
    super.initState();

    databaseHelper.initDB();
    getReportGeneratedByData();
  }

  Future<List<DoctorModel>> searchDoctor(String name) {
    if (name.trim().isEmpty) {
      return databaseHelper.getDoctorList();
    } else {
      return databaseHelper.searchDoctor(name: name);
    }
  }

  TextEditingController patientNameContoller = TextEditingController();
  TextEditingController patientAgeContoller = TextEditingController();
  TextEditingController patientSexContoller = TextEditingController();
  TextEditingController diagnosisRemarkContoller = TextEditingController();
  TextEditingController diagnosisTypeContoller = TextEditingController();
  TextEditingController totalAmountContoller = TextEditingController();
  TextEditingController paidAmountContoller = TextEditingController();
  TextEditingController incentiveContoller = TextEditingController();
  TextEditingController doctorNameController = TextEditingController();
  TextEditingController patientAddressController = TextEditingController();
  TextEditingController patientPhoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController reportGeneratedByController = TextEditingController();
  final List<String> diagnosisType = [
    'Ultrasound',
    'Pathology',
    'ECG',
    'X-Ray'
  ];

  void showDoctorSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: getDeviceHeight(context: context) * 0.8,
            width: getDeviceWidth(context: context) * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                defaultSize,
              ),
              color: primaryColorDark,
            ),
            child: ListView(
              children: [
                Gap(defaultSize),
                SizedBox(
                  height: getDeviceHeight(context: context) * 0.74,
                  width: getDeviceWidth(context: context) * 0.8,
                  child: FutureBuilder(
                    future: databaseHelper.getDoctorList(),
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
                          return GestureDetector(
                            onTap: () {
                              doctorNameController.text =
                                  snapshot.data![index].name;
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 6),
                              child: Card(
                                color: primaryColor,
                                elevation: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(defaultSize),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      Text(
                                        snapshot.data![index].address,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showGenerateNewBill(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: getDeviceHeight(context: context) * 0.8,
            width: getDeviceWidth(context: context) * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                defaultSize,
              ),
              color: primaryColorDark,
            ),
            child: Padding(
              padding: EdgeInsets.all(
                defaultSize,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: CustomTextField(
                            controller: patientNameContoller,
                            hintText: 'Patient Name',
                          ),
                        ),
                        Gap(defaultSize),
                        Expanded(
                            child: DropdownButtonFormField(
                          dropdownColor: primaryColor,
                          borderRadius: BorderRadius.circular(defaultSize),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                defaultSize,
                              ),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: primaryColor,
                            filled: true,
                          ),
                          value: sexType.first,
                          items: sexType.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              patientSexContoller.text = value!;
                            });
                          },
                        )),
                        Gap(defaultSize),
                        Expanded(
                          flex: 1,
                          child: CustomTextField(
                            controller: patientAgeContoller,
                            hintText: 'Patient Age',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    Gap(defaultSize),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                              controller: patientPhoneController,
                              hintText: 'Patient Phone'),
                        ),
                        Gap(defaultSize),
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            controller: patientAddressController,
                            hintText: 'Patient Address',
                          ),
                        ),
                        Gap(defaultSize),
                        Expanded(
                          flex: 1,
                          child: DropdownButtonFormField(
                            dropdownColor: primaryColor,
                            borderRadius: BorderRadius.circular(defaultSize),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  defaultSize,
                                ),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: primaryColor,
                              filled: true,
                            ),
                            value: diagnosisType.first,
                            items: diagnosisType.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                diagnosisTypeContoller.text = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Gap(defaultSize),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: CustomTextField(
                            controller: doctorNameController,
                            hintText: 'Select doctor',
                            readOnly: true,
                          ),
                        ),
                        Gap(defaultSize),
                        Expanded(
                          flex: 1,
                          child: CustomSelectorCircle(
                            onTap: () {
                              showDoctorSelector(context);
                            },
                            icon: Icons.person_2_outlined,
                          ),
                        ),
                        Gap(defaultSize),
                        SizedBox(
                          height: 50,
                          child: VerticalDivider(
                            color: primaryColor,
                            thickness: 4,
                          ),
                        ),
                        Gap(defaultSize),
                        Expanded(
                          flex: 1,
                          child: CustomSelectorCircle(
                            onTap: () {},
                            icon: Icons.calendar_month_outlined,
                          ),
                        ),
                        Gap(defaultSize),
                        Expanded(
                          flex: 3,
                          child: CustomTextField(
                            controller: dateController,
                            hintText: 'Select date',
                            readOnly: true,
                          ),
                        ),
                        Gap(defaultSize),
                        SizedBox(
                          height: 50,
                          child: VerticalDivider(
                            color: primaryColor,
                            thickness: 4,
                          ),
                        ),
                        Gap(defaultSize),
                        Expanded(
                          flex: 1,
                          child: CustomSelectorCircle(
                            onTap: () {},
                            icon: Icons.person_outlined,
                          ),
                        ),
                        Gap(defaultSize),
                        Expanded(
                          flex: 3,
                          child: CustomTextField(
                            controller: reportGeneratedByController,
                            hintText: 'Report generated by',
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                    Gap(defaultSize),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            maxLines: 3,
                            controller: diagnosisRemarkContoller,
                            hintText: 'Diagnosis Remark',
                          ),
                        ),
                      ],
                    ),
                    Gap(defaultSize),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: totalAmountContoller,
                            hintText: 'Total Amount',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Gap(defaultSize),
                        Expanded(
                          child: CustomTextField(
                            controller: paidAmountContoller,
                            hintText: 'Paid Amount',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Gap(defaultSize),
                        Expanded(
                          child: CustomTextField(
                            readOnly: true,
                            controller: incentiveContoller,
                            hintText: 'Incentive',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    Gap(defaultSize),
                    GestureDetector(
                      onTap: () async {},
                      child: Container(
                        height: getDeviceHeight(context: context) * 0.1,
                        width: getDeviceWidth(context: context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(defaultSize),
                          color: primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            'Add Doctor',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 10,
          right: 0,
          child: GestureDetector(
            onTap: () {
              showGenerateNewBill(context);
            },
            child: DefaultContainer(
              height: MediaQuery.of(context).size.height * 0.1,
              width: 300,
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
