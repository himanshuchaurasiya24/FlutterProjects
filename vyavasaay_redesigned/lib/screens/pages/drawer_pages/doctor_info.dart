import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/model/doctor_model.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/custom_textfield.dart';
import 'package:vyavasaay_redesigned/widgets/default_container.dart';

class DoctorInfo extends StatefulWidget {
  const DoctorInfo({super.key});

  @override
  State<DoctorInfo> createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  final docNameController = TextEditingController();

  final docAgeController = TextEditingController();

  final docSexController = TextEditingController();

  final docPhoneController = TextEditingController();

  final docUltraPercentageController = TextEditingController();
  final docPathPercentageController = TextEditingController();
  final docEcgPercentageController = TextEditingController();
  final docxrayPercentageController = TextEditingController();

  final docAddressController = TextEditingController();

  final List<String> sexType = ['Male', 'Female', 'Others'];

  DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  void initState() {
    super.initState();
    databaseHelper.initDB();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: databaseHelper.getAllDoctorList(),
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
                return ListTile(
                  title: Text(
                    snapshot.data![index].name,
                  ),
                  subtitle: Text(snapshot.data![index].address),
                );
              },
            );
          },
        ),
        Positioned(
          bottom: 10,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              addDoctorDialog(
                context: context,
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

  void addDoctorDialog({required BuildContext context}) {
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
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: CustomTextField(
                            controller: docNameController,
                            hintText: 'Doctor Name',
                          ),
                        ),
                        Gap(defaultSize),
                        Expanded(
                          flex: 1,
                          child: CustomTextField(
                            controller: docAgeController,
                            hintText: 'Doctor Age',
                            valueLimit: 130,
                            keyboardType: TextInputType.number,
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
                              docSexController.text = value!;
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
                            controller: docAddressController,
                            hintText: 'Address',
                          ),
                        ),
                        Gap(defaultSize),
                        Expanded(
                          child: CustomTextField(
                            controller: docPhoneController,
                            hintText: 'Phone',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    Gap(defaultSize),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: docUltraPercentageController,
                            valueLimit: 100,
                            hintText: 'Ultrasound Incentive in %',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Gap(defaultSize),
                        Expanded(
                          child: CustomTextField(
                            controller: docPathPercentageController,
                            valueLimit: 100,
                            hintText: 'Pathology Incentive in %',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Gap(defaultSize),
                        Expanded(
                          child: CustomTextField(
                            controller: docEcgPercentageController,
                            valueLimit: 100,
                            hintText: 'ECG Incentive in %',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Gap(defaultSize),
                        Expanded(
                          child: CustomTextField(
                            controller: docxrayPercentageController,
                            valueLimit: 100,
                            hintText: 'X-Ray Incentive in %',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    Gap(defaultSize),
                    GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await databaseHelper
                              .addDoctor(
                            model: DoctorModel(
                                name: docNameController.text,
                                age: int.tryParse(docAgeController.text)!
                                    .toInt(),
                                sex: docSexController.text,
                                phone: docPhoneController.text,
                                address: docAddressController.text,
                                ultrasound: int.tryParse(
                                        docUltraPercentageController.text)!
                                    .toInt(),
                                pathology: int.tryParse(
                                        docPathPercentageController.text)!
                                    .toInt(),
                                ecg: int.tryParse(
                                        docEcgPercentageController.text)!
                                    .toInt(),
                                xray: int.tryParse(
                                        docxrayPercentageController.text)!
                                    .toInt()),
                          )
                              .then((value) {
                            Navigator.pop(context);
                          });
                        }
                      },
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
}
