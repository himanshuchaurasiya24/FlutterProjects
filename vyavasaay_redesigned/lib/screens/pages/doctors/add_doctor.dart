import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/model/doctor_model.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/custom_textfield.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({super.key, this.isUpdate = false, this.model});
  final bool isUpdate;
  final DoctorModel? model;
  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      docNameController.text = widget.model!.name;
      docSexController.text = widget.model!.sex;
      docPhoneController.text = widget.model!.phone;
      docAddressController.text = widget.model!.address;
      docUltraPercentageController.text = widget.model!.ultrasound.toString();
      docPathPercentageController.text = widget.model!.pathology.toString();
      docEcgPercentageController.text = widget.model!.ecg.toString();
      docxrayPercentageController.text = widget.model!.xray.toString();
      docAgeController.text = widget.model!.age.toString();
    } else {
      docSexController.text = 'Male';
    }
    databaseHelper.initDB();
  }

  @override
  void dispose() {
    super.dispose();
    docxrayPercentageController.dispose();
    docEcgPercentageController.dispose();
    docPathPercentageController.dispose();
    docUltraPercentageController.dispose();
    docPhoneController.dispose();
    docSexController.dispose();
    docNameController.dispose();
    docAgeController.dispose();
    docAddressController.dispose();
  }

  void addOrUpdateDoctor() async {
    if (widget.isUpdate) {
      await databaseHelper
          .updateDoctor(
        model: DoctorModel(
            id: widget.model!.id!,
            name: docNameController.text,
            age: int.tryParse(docAgeController.text)!.toInt(),
            sex: docSexController.text,
            phone: docPhoneController.text,
            address: docAddressController.text,
            ultrasound:
                int.tryParse(docUltraPercentageController.text)!.toInt(),
            pathology: int.tryParse(docPathPercentageController.text)!.toInt(),
            ecg: int.tryParse(docEcgPercentageController.text)!.toInt(),
            xray: int.tryParse(docxrayPercentageController.text)!.toInt()),
      )
          .then((value) {
        Navigator.pop(context, value);
      });
    } else {
      await databaseHelper
          .addDoctor(
        model: DoctorModel(
            name: docNameController.text,
            age: int.tryParse(docAgeController.text)!.toInt(),
            sex: docSexController.text,
            phone: docPhoneController.text,
            address: docAddressController.text,
            ultrasound:
                int.tryParse(docUltraPercentageController.text)!.toInt(),
            pathology: int.tryParse(docPathPercentageController.text)!.toInt(),
            ecg: int.tryParse(docEcgPercentageController.text)!.toInt(),
            xray: int.tryParse(docxrayPercentageController.text)!.toInt()),
      )
          .then((value) {
        Navigator.pop(context, value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
            widget.isUpdate ? 'Update doctor details' : 'Enter doctor details'),
      ),
      body: Container(
        margin: EdgeInsets.all(defaultSize * 3),
        height: getDeviceHeight(context: context),
        width: getDeviceWidth(context: context),
        padding: EdgeInsets.all(defaultSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            defaultSize,
          ),
          color: primaryColorDark,
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
                    value: widget.isUpdate ? widget.model!.sex : sexType.first,
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
                    addOrUpdateDoctor();
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
                      widget.isUpdate ? 'Update Doctor' : 'Add Doctor',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ),
              Gap(defaultSize),
              Visibility(
                visible: widget.isUpdate,
                child: GestureDetector(
                  onTap: () async {
                    await databaseHelper
                        .deleteDoctor(id: widget.model!.id!)
                        .then((value) {
                      Navigator.pop(context, value);
                    });
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
                        'Delete Doctor',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
