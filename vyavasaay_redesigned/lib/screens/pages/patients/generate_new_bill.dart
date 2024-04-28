import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/model/patient_model.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/custom_textfield.dart';

class GenerateNewBill extends StatefulWidget {
  const GenerateNewBill({super.key, this.isUpdate = false, this.model});
  final bool? isUpdate;
  final PatientModel? model;
  @override
  State<GenerateNewBill> createState() => _GenerateNewBillState();
}

class _GenerateNewBillState extends State<GenerateNewBill> {
  final TextEditingController pName = TextEditingController();
  final TextEditingController pAge = TextEditingController();
  final TextEditingController pSex = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController refBy = TextEditingController();
  final TextEditingController diagType = TextEditingController();
  final TextEditingController remark = TextEditingController();
  final TextEditingController technician = TextEditingController();
  final TextEditingController total = TextEditingController();
  final TextEditingController paid = TextEditingController();
  final TextEditingController discDoc = TextEditingController();
  final TextEditingController discCen = TextEditingController();
  final TextEditingController incentiveAmount = TextEditingController();
  final TextEditingController percent = TextEditingController();
  int updateDiagType = 0;
  int updateSexType = 0;
  @override
  void initState() {
    super.initState();

    pSex.text = patientSex.first;
    diagType.text = diagnType.first;
    discCen.text = 0.toString();

    databaseHelper.initDB();
    getTechnicianInfo();
    if (widget.isUpdate!) {
      updateDiagType = diagnType.indexOf(widget.model!.type);
      updateSexType = patientSex.indexOf(widget.model!.sex);
      remark.text = widget.model!.remark;
      total.text = widget.model!.totalAmount.toString();
      discCen.text = widget.model!.discCen.toString();
      percent.text = widget.model!.percent.toString();
      incentiveAmount.text = widget.model!.incentive.toString();
      discDoc.text = widget.model!.discDoc.toString();
      total.text = widget.model!.totalAmount.toString();
      paid.text = widget.model!.paidAmount.toString();
      pName.text = widget.model!.name;
      pName.text = widget.model!.name;
      pAge.text = widget.model!.age.toString();
      pSex.text = widget.model!.sex;
      date.text = widget.model!.date;
      refBy.text = widget.model!.refBy;
      diagType.text = widget.model!.type;
    }
  }

  void getTechnicianInfo() async {
    final pref = await SharedPreferences.getInstance();
    technician.text =
        widget.model?.technician ?? pref.getString('loggedInName') ?? '';
  }

  final DatabaseHelper databaseHelper = DatabaseHelper();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List diagnType = [
    'Ultrasound',
    'Pathology',
    'ECG',
    'X-Ray',
  ];
  final List patientSex = [
    'Male',
    'Female',
    'Others',
  ];
  int maxDisount = 600;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(),
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
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomTextField(
                      controller: pName,
                      hintText: 'Patient name',
                    ),
                  ),
                  Gap(defaultSize),
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                      controller: pAge,
                      hintText: 'Patient age',
                      keyboardType: TextInputType.number,
                      valueLimit: 120,
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
                      value: widget.isUpdate == true
                          ? patientSex[updateSexType]
                          : patientSex.first,
                      items: patientSex
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          pSex.text = value.toString();
                        });
                      },
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
                      value: widget.isUpdate == true
                          ? diagnType[updateDiagType]
                          : diagnType.first,
                      items: diagnType
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          diagType.text = value.toString();
                          widget.isUpdate! ? () {} : refBy.clear();
                          widget.isUpdate! ? () {} : doctorSelector();
                          debugPrint(diagType.text);
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
                    child: CustomTextField(
                      controller: refBy,
                      hintText: 'Select doctor',
                    ),
                  ),
                  Gap(defaultSize),
                  GestureDetector(
                    onTap: () {
                      doctorSelector();
                    },
                    child: CircleAvatar(
                      backgroundColor: primaryColor,
                      maxRadius: 28,
                      minRadius: 20,
                      child: const Icon(
                        Icons.search_outlined,
                      ),
                    ),
                  ),
                  Gap(defaultSize),
                  Expanded(
                    child: CustomTextField(
                      controller: date,
                      hintText: 'Select date',
                    ),
                  ),
                  Gap(defaultSize),
                  GestureDetector(
                    onTap: () async {
                      datePicker();
                    },
                    child: CircleAvatar(
                      backgroundColor: primaryColor,
                      maxRadius: 28,
                      minRadius: 20,
                      child: const Icon(
                        Icons.search_outlined,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(defaultSize),
              CustomTextField(
                controller: remark,
                maxLines: 2,
                hintText: 'Diagnosis remark',
              ),
              Gap(defaultSize),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: total,
                      keyboardType: TextInputType.number,
                      hintText: 'Total amount',
                      onChanged: (p0) {
                        calculateIncentive();
                      },
                    ),
                  ),
                  Gap(defaultSize),
                  Expanded(
                    child: CustomTextField(
                      controller: paid,
                      keyboardType: TextInputType.number,
                      hintText: 'Paid amount',
                      onChanged: (p0) {
                        calculateIncentive();
                      },
                    ),
                  ),
                  Gap(defaultSize),
                  Expanded(
                    child: CustomTextField(
                      controller: discCen,
                      keyboardType: TextInputType.number,
                      hintText: 'Discount by center',
                      valueLimit: maxDisount,
                      onChanged: (p0) {
                        calculateIncentive();
                      },
                    ),
                  ),
                  Gap(defaultSize),
                  Expanded(
                    child: CustomTextField(
                      controller: incentiveAmount,
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      hintText: 'Generated incentive',
                    ),
                  ),
                  Gap(defaultSize),
                  Expanded(
                    child: CustomTextField(
                      controller: percent,
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      hintText: 'Percent',
                    ),
                  ),
                ],
              ),
              Gap(defaultSize),
              GestureDetector(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    widget.isUpdate == false
                        ? await databaseHelper
                            .addPatient(
                            model: PatientModel(
                              name: pName.text,
                              age: int.parse(pAge.text),
                              sex: pSex.text,
                              date: date.text,
                              type: diagType.text,
                              remark: remark.text,
                              technician: technician.text,
                              refBy: refBy.text,
                              totalAmount: int.parse(total.text),
                              paidAmount: int.parse(paid.text),
                              discDoc: int.parse(discDoc.text),
                              discCen: int.parse(discCen.text),
                              incentive: int.parse(incentiveAmount.text),
                              percent: int.parse(percent.text),
                            ),
                          )
                            .then((value) {
                            Navigator.pop(context, value);
                          })
                        : await databaseHelper
                            .updatePatient(
                            model: PatientModel(
                              id: widget.model!.id,
                              name: pName.text,
                              age: int.parse(pAge.text),
                              sex: pSex.text,
                              date: date.text,
                              type: diagType.text,
                              remark: remark.text,
                              technician: technician.text,
                              refBy: refBy.text,
                              totalAmount: int.parse(total.text),
                              paidAmount: int.parse(paid.text),
                              discDoc: int.parse(discDoc.text),
                              discCen: int.parse(discCen.text),
                              incentive: int.parse(incentiveAmount.text),
                              percent: int.parse(percent.text),
                            ),
                          )
                            .then((value) {
                            Navigator.pop(context, value);
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
                      widget.isUpdate == true ? 'Update Bill' : 'Generate Bill',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ),
              Gap(defaultSize),
              Visibility(
                visible: widget.isUpdate!,
                child: GestureDetector(
                  onTap: () async {
                    await databaseHelper
                        .deletePatient(id: widget.model!.id!)
                        .then(
                          (value) => Navigator.pop(context, value),
                        );
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
                        'Delete Bill',
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

  void calculateIncentive() {
    int totalAmount = int.tryParse(total.text) ?? 0;
    int paidAmount = int.tryParse(paid.text) ?? 0;
    int incentivePer = int.tryParse(percent.text) ?? 0;
    int discByCen = int.tryParse(discCen.text) ?? 0;
    int paymentDiff = totalAmount - paidAmount;
    discDoc.text = (paymentDiff - discByCen).toString();
    double rawIncentive =
        (totalAmount * incentivePer) / 100 - (paymentDiff - discByCen);
    incentiveAmount.text = rawIncentive.toInt().toString();

    setState(() {
      maxDisount = paymentDiff;
    });
  }

  void datePicker() async {
    final rawDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    final parsedDate = DateFormat('MMMM y d');
    final formatDate = parsedDate.format(rawDate!);
    setState(() {
      date.text = formatDate.toString();
    });
  }

  void doctorSelector() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(
                defaultSize,
              ),
            ),
            child: Column(children: [
              Text(
                'Select Doctor',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Expanded(
                child: FutureBuilder(
                  future: databaseHelper.getDoctorList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          'Some error occurred!',
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
                            refBy.text = snapshot.data![index].name;
                            if (diagType.text == diagnType[0]) {
                              percent.text =
                                  snapshot.data![index].ultrasound.toString();
                            } else if (diagType.text == diagnType[1]) {
                              percent.text =
                                  snapshot.data![index].pathology.toString();
                            } else if (diagType.text == diagnType[2]) {
                              percent.text =
                                  snapshot.data![index].ecg.toString();
                            } else {
                              percent.text =
                                  snapshot.data![index].xray.toString();
                            }
                            total.clear();
                            paid.clear();
                            discDoc.clear();
                            discCen.clear();
                            incentiveAmount.clear();

                            Navigator.pop(context);
                          },
                          child: Card(
                            elevation: 0,
                            color: primaryCardColor,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].name,
                                          style: patientHeader,
                                        ),
                                        Text(
                                          snapshot.data![index].address,
                                          style: patientHeaderSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    snapshot.data![index].phone,
                                    style: patientHeaderSmall,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
