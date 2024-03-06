import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vyawasaay/database/database_helper.dart';
import 'package:vyawasaay/models/doctor_model.dart';
import 'package:vyawasaay/models/patient_sex.dart';
import 'package:vyawasaay/screens/diagnosis/new_diagnosis.dart';
import 'package:vyawasaay/widgets/custom_elevated_button.dart';
import 'package:vyawasaay/widgets/custom_text_form_field.dart';

class AddDoctor extends ConsumerStatefulWidget {
  const AddDoctor({super.key});

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
  Widget build(BuildContext context) {
    doctorSexController.text = ref.watch(patientSexProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Enter Doctor Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  btnName: 'Add Doctor',
                  function: () async {
                    if (_formKey.currentState!.validate()) {
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
