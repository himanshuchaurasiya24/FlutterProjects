import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/screens/model/doctor_model.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
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
  @override
  void initState() {
    super.initState();

    databaseHelper.initDB().whenComplete(() {
      doctorList = databaseHelper.getAllDoctorList();
    });
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
  final List<String> diagnosisType = [
    'Ultrasound',
    'Pathology',
    'ECG',
    'X-Ray'
  ];
  late Future<List<DoctorModel>> doctorList;
  void showGenerateNewBill(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: getDeviceHeight(context: context) * 0.6,
            width: getDeviceWidth(context: context) * 0.6,
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
                          )),
                    ],
                  ),
                  Gap(defaultSize),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: diagnosisRemarkContoller,
                          hintText: 'Diagnosis Remark',
                        ),
                      ),
                      Gap(defaultSize),
                      Expanded(
                        child: CustomTextField(
                          controller: doctorNameController,
                          hintText: 'Doctor Name',
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
