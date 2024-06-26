import 'package:dummy_patient/constants.dart';
import 'package:flutter/material.dart';

class AddPatient extends StatefulWidget {
  const AddPatient({super.key});

  @override
  State<AddPatient> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final List<String> sexType = ['Male', 'Female', 'Others'];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedSex = 'Male';
  void getReportGeneratedByData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    reportGeneratedByController.text = pref.getString('loggedInName')!;
  }

  final List<String> diagnosisType = [
    'Ultrasound',
    'Pathology',
    'ECG',
    'X-Ray'
  ];
  String selectedType = 'Ultrasound';

  @override
  void initState() {
    super.initState();
    patientSexContoller.text = 'Male';
    diagnosisTypeContoller.text = 'Ultrasound';
    databaseHelper.initDB();
    getReportGeneratedByData();
  }

  @override
  void dispose() {
    super.dispose();
    TextEditingController().dispose();
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
  TextEditingController doctorIdController = TextEditingController();
  TextEditingController patientAddressController = TextEditingController();
  TextEditingController patientPhoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController incentivePerController = TextEditingController();
  TextEditingController reportGeneratedByController = TextEditingController();
  TextEditingController discountByDocController = TextEditingController();
  TextEditingController discountByCenController = TextEditingController();

  late DoctorModel doctorModel;

  int calculateIncentive() {
    int totalAmount = int.tryParse(totalAmountContoller.text)!;
    int paidAmount = int.tryParse(paidAmountContoller.text)!;
    int incentivePercent = int.tryParse(incentivePerController.text)!;

    if (totalAmount == paidAmount) {
      discountByDocController.text = (totalAmount - paidAmount).toString();

      double calculated = (totalAmount * incentivePercent) / 100;
      return calculated.toInt();
    }

    discountByDocController.text = (totalAmount - paidAmount).toString();
    int discountByDoctor = int.tryParse(discountByDocController.text)!;
    double calculated = (totalAmount * incentivePercent) / 100;
    return calculated.toInt() - discountByDoctor;
  }

  void showDatePick() async {
    final date = await showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );

    final parsedDate = DateFormat('MMMM y d');
    final formatDate = parsedDate.format(date!);
    setState(() {
      dateController.text = formatDate.toString();
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
  TextEditingController doctorIdController = TextEditingController();
  TextEditingController patientAddressController = TextEditingController();
  TextEditingController patientPhoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController incentivePerController = TextEditingController();
  TextEditingController reportGeneratedByController = TextEditingController();
  TextEditingController discountByDocController = TextEditingController();
  TextEditingController discountByCenController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
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
          child: Form(
            key: formKey,
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
                            selectedType = value;
                            if (selectedType == 'Ultrasound') {
                              incentivePerController.text =
                                  doctorModel.ultrasound.toString();
                            } else if (selectedType == 'Pathology') {
                              incentivePerController.text =
                                  doctorModel.pathology.toString();
                            } else if (selectedType == 'ECG') {
                              incentivePerController.text =
                                  doctorModel.ecg.toString();
                            } else {
                              incentivePerController.text =
                                  doctorModel.xray.toString();
                            }
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
                        onTap: () async {
                          showDatePick();
                        },
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
                    const Expanded(
                      flex: 1,
                      child: CustomSelectorCircle(
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
                      flex: 4,
                      child: CustomTextField(
                        controller: totalAmountContoller,
                        hintText: 'Total Amount',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Gap(defaultSize),
                    Expanded(
                      flex: 4,
                      child: CustomTextField(
                        controller: paidAmountContoller,
                        hintText: 'Paid Amount',
                        onChanged: (p0) {
                          setState(() {
                            incentiveContoller.text =
                                calculateIncentive().toString();
                          });
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Gap(defaultSize),
                    Expanded(
                      flex: 4,
                      child: CustomTextField(
                        controller: discountByDocController,
                        hintText: 'Discount by doctor',
                        onChanged: (p0) {
                          setState(() {
                            int total =
                                int.tryParse(totalAmountContoller.text)!;
                            int paid = int.tryParse(paidAmountContoller.text)!;
                            int incentivePer =
                                int.tryParse(incentivePerController.text)!;
                            int discountByDoc =
                                int.tryParse(discountByDocController.text)!;
                            double incentive =
                                ((total * incentivePer) / 100) - discountByDoc;
                            incentiveContoller.text =
                                incentive.toInt().toString();
                            discountByCenController.text =
                                (total - paid - discountByDoc).toString();
                          });
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Gap(defaultSize),
                    Expanded(
                      flex: 4,
                      child: CustomTextField(
                        readOnly: true,
                        controller: incentiveContoller,
                        hintText: 'Incentive',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Gap(defaultSize),
                    Expanded(
                      flex: 1,
                      child: CustomTextField(
                        readOnly: true,
                        controller: incentivePerController,
                        hintText: '%',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                Gap(defaultSize),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      debugPrint(PatientModel(
                        name: patientNameContoller.text,
                        age: int.tryParse(patientAgeContoller.text)!,
                        sex: patientSexContoller.text,
                        date: dateController.text,
                        type: diagnosisType.toString(),
                        remark: diagnosisRemarkContoller.text,
                        technician: reportGeneratedByController.text,
                        refBy: int.tryParse(doctorIdController.text)!,
                        totalAmount: int.tryParse(totalAmountContoller.text)!,
                        paidAmount: int.tryParse(paidAmountContoller.text)!,
                        discDoc: int.tryParse(discountByDocController.text)!,
                        discCen: int.tryParse(discountByCenController.text)!,
                        incentive: int.tryParse(incentiveContoller.text)!,
                        percent: int.tryParse(incentivePerController.text)!,
                      ).toString());
                      await databaseHelper
                          .addPatient(
                        model: PatientModel(
                          name: patientNameContoller.text,
                          age: int.tryParse(patientAgeContoller.text)!,
                          sex: patientSexContoller.text,
                          date: dateController.text,
                          type: diagnosisType.toString(),
                          remark: diagnosisRemarkContoller.text,
                          technician: reportGeneratedByController.text,
                          refBy: int.tryParse(doctorIdController.text)!,
                          totalAmount: int.tryParse(totalAmountContoller.text)!,
                          paidAmount: int.tryParse(paidAmountContoller.text)!,
                          discDoc: int.tryParse(discountByDocController.text)!,
                          discCen: int.tryParse(discountByCenController.text)!,
                          incentive: int.tryParse(incentiveContoller.text)!,
                          percent: int.tryParse(incentivePerController.text)!,
                        ),
                      )
                          .then((value) {
                        debugPrint(value.toString());
                        Navigator.pop(context, value);
                      }).onError((error, stackTrace) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(error.toString()),
                            );
                          },
                        );
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
                        'Add patient',
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
  }
}
