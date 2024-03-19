import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vyawasaay/database/database_helper.dart';
import 'package:vyawasaay/models/doctor_model.dart';
import 'package:vyawasaay/models/patient_sex.dart';
import 'package:vyawasaay/screens/diagnosis/new_diagnosis.dart';
import 'package:vyawasaay/widgets/custom_elevated_button.dart';
import 'package:vyawasaay/widgets/custom_text_form_field.dart';

class AddDoctor extends ConsumerStatefulWidget {
  const AddDoctor(
      {this.isUpdate = false,
      this.id,
      this.doctorName,
      this.doctorAddress,
      this.doctorAge,
      this.doctorPhoneNumber,
      this.doctorSex,
      this.doctorIncentivePercentage,
      super.key});
  final String? doctorName;
  final String? doctorAddress;
  final String? doctorAge;
  final int? id;
  final String? doctorPhoneNumber;
  final String? doctorSex;
  final String? doctorIncentivePercentage;
  final bool isUpdate;

  @override
  ConsumerState<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends ConsumerState<AddDoctor> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController doctorNameController = TextEditingController();

  final TextEditingController doctorAgeController = TextEditingController();

  final TextEditingController doctorSexController = TextEditingController();

  final TextEditingController doctorPhoneNumberController =
      TextEditingController();

  final TextEditingController doctorAddressController = TextEditingController();

  final TextEditingController incentivePercentageController =
      TextEditingController();
  final db = DatabaseHelper();
  @override
  void initState() {
    doctorNameController.text = widget.doctorName ?? '';
    doctorAgeController.text = widget.doctorAge ?? '';
    doctorSexController.text = widget.doctorSex ?? '';
    doctorPhoneNumberController.text = widget.doctorPhoneNumber ?? '';
    doctorAddressController.text = widget.doctorAddress ?? '';
    incentivePercentageController.text = widget.doctorIncentivePercentage ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    doctorSexController.text = ref.watch(patientSexProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isUpdate ? 'Update Doctor Details' : 'Add Doctor Details',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          widget.isUpdate
              ? IconButton(
                  onPressed: () async {
                    await db.deleteDoctorInfo(id: widget.id).then(
                      (value) {
                        Navigator.pop(context);
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: doctorNameController,
                  labelText: 'Doctor Name',
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomTextFormField(
                        controller: doctorAgeController,
                        labelText: 'Doctor Age',
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: PatientSexSelector(
                          selectedPatientSex: sex[PatientSex.male]!, ref: ref),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 2,
                      child: CustomTextFormField(
                        controller: doctorPhoneNumberController,
                        labelText: 'Phone Number',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomTextFormField(
                          controller: doctorAddressController,
                          labelText: 'Doctor address'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: CustomTextFormField(
                        controller: incentivePercentageController,
                        labelText: 'Incentive in percentage',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomElevatedButton(
                  btnName: widget.isUpdate ? 'Update Doctor' : 'Add Doctor',
                  function: () async {
                    int? doctorAge = int.tryParse(doctorAgeController.text);
                    int? incentivePercetage =
                        int.tryParse(incentivePercentageController.text);
                    if (_formKey.currentState!.validate()) {
                      if (doctorAgeController.text.isNotEmpty &&
                          incentivePercentageController.text.isNotEmpty) {
                        if (doctorAge != null && incentivePercetage != null) {
                          if (doctorAge.isEven ||
                              doctorAge.isOdd ||
                              incentivePercetage.isEven ||
                              incentivePercetage.isOdd) {
                            if (widget.isUpdate) {
                              await db
                                  .updateDoctorInfo(
                                model: DoctorModel(
                                  id: widget.id,
                                  doctorName: doctorNameController.text,
                                  doctorAge: doctorAgeController.text,
                                  doctorSex: doctorSexController.text,
                                  doctorPhoneNumber:
                                      doctorPhoneNumberController.text,
                                  address: doctorAddressController.text,
                                  incentivePercentage:
                                      incentivePercentageController.text,
                                ),
                              )
                                  .then((value) {
                                Navigator.pop(context);
                              });
                            } else {
                              await db
                                  .insertDoctor(
                                    doctorModel: DoctorModel(
                                      doctorName: doctorNameController.text,
                                      doctorAge: doctorAgeController.text,
                                      doctorSex: doctorSexController.text,
                                      doctorPhoneNumber:
                                          doctorPhoneNumberController.text,
                                      address: doctorAddressController.text,
                                      incentivePercentage:
                                          incentivePercentageController.text,
                                    ),
                                  )
                                  .then(
                                    (value) => Navigator.pop(context),
                                  );
                            }
                          } else {
                            await showAdaptiveDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text(
                                      'Some of the values are incorrect, Fill it again'),
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
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
