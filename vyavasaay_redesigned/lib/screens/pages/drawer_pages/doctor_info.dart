import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/screens/model/doctor_model.dart';
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

  final docPercentController = TextEditingController();

  final docAddressController = TextEditingController();

  final List<String> sexType = ['Male', 'Female', 'Others'];

  String selectedSex = 'Male';
  DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  void initState() {
    super.initState();
    databaseHelper.initDB();
  }

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
          bottom: -10,
          left: 225,
          child: GestureDetector(
            onTap: () async {
              addDoctorDialog(
                context: context,
              );
            },
            child: DefaultContainer(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Center(
                child: Text(
                  'Add a doctor',
                  style: Theme.of(context).textTheme.titleLarge,
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
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Gap(defaultSize),
                      Expanded(
                        flex: 1,
                        child: DropdownMenu<String>(
                          inputDecorationTheme: InputDecorationTheme(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                defaultSize,
                              ),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: primaryColor,
                          ),
                          initialSelection: sexType.first,
                          onSelected: (String? value) {
                            setState(() {
                              selectedSex = value!;
                            });
                          },
                          dropdownMenuEntries: sexType
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                              value: value,
                              label: value,
                            );
                          }).toList(),
                        ),
                      ),
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
                          controller: docPercentController,
                          hintText: 'Incentive in Percentage',
                          keyboardType: TextInputType.number,
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
                  GestureDetector(
                    onTap: () async {
                      await databaseHelper
                          .addDoctor(
                        model: DoctorModel(
                          name: docNameController.text,
                          age: int.tryParse(docAgeController.text)!.toInt(),
                          sex: docSexController.text,
                          phone: int.tryParse(docPhoneController.text)!.toInt(),
                          address: docAddressController.text,
                          percent:
                              int.tryParse(docPercentController.text)!.toInt(),
                        ),
                      )
                          .then((value) {
                        Navigator.pop(context);
                      });

                      // Navigator.pop(context);
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
        );
      },
    );
  }
}
