import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vyawasaay/database/database_helper.dart';
import 'package:vyawasaay/models/diagnosis_info.dart';
import 'package:vyawasaay/models/diagnosis_type.dart';
import 'package:vyawasaay/models/doctor_model.dart';
import 'package:vyawasaay/models/patient_sex.dart';
import 'package:vyawasaay/widgets/custom_elevated_button.dart';
import 'package:vyawasaay/widgets/custom_text_form_field.dart';

final dateProvider = StateProvider<String>((ref) => 'No date Selected');
final diagnosisTypeProvider = StateProvider<String>((ref) => 'Diagnosis Type');
final patientSexProvider = StateProvider<String>((ref) => 'Male');
final doctorNameProvider = StateProvider<String>((ref) => 'Select Doctor');
final doctorIdProvider = StateProvider<String>((ref) => 'null');
final doctorPerIncentiveProvider = StateProvider<String>((ref) => '50');
final incentiveAmountProvider = StateProvider<String>((ref) => '0');

class NewDiagnosis extends ConsumerStatefulWidget {
  const NewDiagnosis({super.key});
  @override
  ConsumerState<NewDiagnosis> createState() => _NewDiagnosisState();
}

class _NewDiagnosisState extends ConsumerState<NewDiagnosis> {
  DatabaseHelper db = DatabaseHelper();
  late Future<List<DoctorModel>> doctorList;
  @override
  void initState() {
    doctorList = db.getDoctorsList();
    db.initDB().whenComplete(() {
      doctorList = db.getDoctorsList();
    });
    super.initState();
  }

  final DatabaseHelper database = DatabaseHelper();
  final TextEditingController patientNameController = TextEditingController();

  final TextEditingController patientAgeController = TextEditingController();

  final TextEditingController patientSexController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  final TextEditingController refByController = TextEditingController();

  final TextEditingController diagnosisTypeController = TextEditingController();

  final TextEditingController diagnosisRemarksController =
      TextEditingController();

  final TextEditingController totalAmountController = TextEditingController();

  final TextEditingController paidAmountController = TextEditingController();

  final TextEditingController doctorIdController = TextEditingController();

  final TextEditingController doctorNameController = TextEditingController();

  final TextEditingController incentiveController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();
  var selectedDiagnosisType = type[DiagnosisType.ultrasound]!;
  var selectedPatientSex = sex[PatientSex.male]!;
  bool viewIncentive = false;

  String calculateIncentive({
    required String paidAmount,
    required String totalAmount,
    required String doctorIncentivePercentage,
  }) {
    int incentiveOut = 0;
    try {
      int? paidAmountInt = int.tryParse(paidAmount);

      int? totalAmountInt = int.tryParse(totalAmount);

      int? doctorPercentageInt = int.tryParse(doctorIncentivePercentage);

      if (paidAmountInt != null &&
          totalAmountInt != null &&
          doctorPercentageInt != null) {
        if (totalAmountInt >= paidAmountInt) {
          int discount = totalAmountInt - paidAmountInt;

          int incentive =
              (((totalAmountInt / 100) * doctorPercentageInt) - discount)
                  .toInt();
          incentiveOut = incentive;
          return incentiveOut.toString();
        } else {
          return 'Paid Amount > Total Amount';
        }
      }
    } catch (e) {
      return e.toString();
    }
    return incentiveOut.toString();
  }

  @override
  Widget build(BuildContext context) {
    var doctorPer = ref.watch(doctorPerIncentiveProvider);
    incentiveController.text = ref.watch(incentiveAmountProvider);
    dateController.text = ref.watch(dateProvider);
    doctorNameController.text = ref.watch(doctorNameProvider);
    diagnosisTypeController.text = ref.watch(diagnosisTypeProvider);
    doctorIdController.text = ref.watch(doctorIdProvider);
    patientSexController.text = ref.watch(patientSexProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Patient Information'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomTextFormField(
                        controller: patientNameController,
                        labelText: 'Patient Name',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: DoctorSelectorWidget(
                        providerDoctor: ref.watch(doctorNameProvider),
                        database: database,
                        ref: ref,
                        doctorNameController: doctorNameController,
                        doctorIdController: doctorIdController,
                        totalAmountController: totalAmountController,
                        paidController: paidAmountController,
                        incentiveController: incentiveController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomTextFormField(
                        controller: patientAgeController,
                        labelText: 'Patient Age',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: PatientSexSelector(
                          selectedPatientSex: selectedPatientSex, ref: ref),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DateSelector(
                        providerDate: ref.watch(dateProvider),
                        ref: ref,
                        dateController: dateController),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 54,
                        child: DiagnosisTypeSelector(
                            selectedDiagnosisType: selectedDiagnosisType,
                            ref: ref),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: diagnosisRemarksController,
                  labelText: 'Diagnosis Remarks',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomTextFormField(
                          controller: totalAmountController,
                          labelText: 'Total Amount'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: CustomTextFormField(
                          controller: paidAmountController,
                          onChanged: (p0) {
                            debugPrint(p0);
                            ref.read(incentiveAmountProvider.notifier).state =
                                calculateIncentive(
                                    paidAmount: p0,
                                    totalAmount: totalAmountController.text,
                                    doctorIncentivePercentage: doctorPer);
                          },
                          labelText: 'Paid Amount'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: CustomTextFormField(
                        controller: incentiveController,
                        labelText: 'Calculated Incentive',
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '$doctorPer%',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.green[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomElevatedButton(
                  btnName: 'Save Record',
                  function: () async {
                    int? patientAge = int.tryParse(patientAgeController.text);
                    int? totalAmount = int.tryParse(totalAmountController.text);
                    int? paidAmount = int.tryParse(paidAmountController.text);
                    int? doctorId = int.tryParse(doctorIdController.text);
                    int? calculatedIncentive =
                        int.tryParse(incentiveController.text);

                    if (_formKey.currentState!.validate()) {
                      if (patientAge != null &&
                          totalAmount != null &&
                          paidAmount != null &&
                          doctorId != null &&
                          calculatedIncentive != null) {
                        if (doctorId.isEven ||
                            doctorId.isOdd ||
                            patientAge.isEven ||
                            patientAge.isOdd ||
                            totalAmount.isEven ||
                            totalAmount.isOdd ||
                            paidAmount.isEven ||
                            paidAmount.isOdd ||
                            calculatedIncentive.isEven ||
                            calculatedIncentive.isOdd ||
                            !calculatedIncentive.isNegative) {
                          await db
                              .insertDiagnosisInfo(
                            diagnosisInfo: DiagnosisInfo(
                                patientName: patientNameController.text,
                                patientAge: patientAge.toString(),
                                patientSex: patientSexController.text,
                                date: dateController.text,
                                dignosisType: diagnosisTypeController.text,
                                diagnosisRemarks:
                                    diagnosisRemarksController.text,
                                totalAmount: totalAmount.toString(),
                                paidAmount: paidAmount.toString(),
                                incentiveAmount: calculatedIncentive.toString(),
                                doctorId: doctorId,
                                doctorName: doctorNameController.text,
                                incentivePercent: ref
                                    .read(doctorPerIncentiveProvider.notifier)
                                    .state),
                          )
                              .then((value) {
                            Navigator.pop(context);
                          });
                        }
                      } else {
                        showAdaptiveDialog(
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

class PatientSexSelector extends StatelessWidget {
  const PatientSexSelector({
    super.key,
    required this.selectedPatientSex,
    required this.ref,
  });

  final CategorySex selectedPatientSex;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(border: OutlineInputBorder()),
      value: selectedPatientSex,
      items: [
        for (final typ in sex.entries)
          DropdownMenuItem(
            value: typ.value,
            child: Text(
              typ.value.sex,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          )
      ],
      onChanged: (value) {
        ref.read(patientSexProvider.notifier).state = value!.sex;
      },
    );
  }
}

class DiagnosisTypeSelector extends StatelessWidget {
  const DiagnosisTypeSelector({
    super.key,
    required this.selectedDiagnosisType,
    required this.ref,
  });

  final Category selectedDiagnosisType;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(border: OutlineInputBorder()),
      value: selectedDiagnosisType,
      items: [
        for (final typ in type.entries)
          DropdownMenuItem(
            value: typ.value,
            child: Text(
              typ.value.title,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          )
      ],
      onChanged: (value) {
        ref.read(diagnosisTypeProvider.notifier).state = value!.title;
      },
    );
  }
}

class DateSelector extends StatelessWidget {
  const DateSelector({
    super.key,
    required this.providerDate,
    required this.ref,
    required this.dateController,
  });

  final String providerDate;
  final WidgetRef ref;
  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        height: 54,
        decoration: BoxDecoration(
            color: Colors.red[40],
            borderRadius: BorderRadius.circular(
              4,
            ),
            border: Border.all(
                color: Colors.black.withOpacity(0.5),
                strokeAlign: BorderSide.strokeAlignCenter,
                style: BorderStyle.solid)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              providerDate,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            IconButton(
              iconSize: 40,
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2100),
                );

                if (date != null) {
                  // final parsedDate = DateFormat('d MMMM y');
                  final parsedDate = DateFormat('MMMM y d');
                  final formatDate = parsedDate.format(date);
                  debugPrint(formatDate);

                  ref.read(dateProvider.notifier).state = formatDate;
                  dateController.text = ref.read(dateProvider);
                  debugPrint(dateController.text);
                }
              },
              icon: const Icon(
                Icons.calendar_month,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorSelectorWidget extends StatelessWidget {
  const DoctorSelectorWidget({
    super.key,
    required this.providerDoctor,
    required this.database,
    required this.ref,
    required this.doctorNameController,
    required this.doctorIdController,
    required this.totalAmountController,
    required this.paidController,
    required this.incentiveController,
  });

  final String providerDoctor;
  final DatabaseHelper database;
  final WidgetRef ref;
  final TextEditingController doctorNameController;
  final TextEditingController doctorIdController;
  final TextEditingController totalAmountController;
  final TextEditingController paidController;
  final TextEditingController incentiveController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: Colors.red[40],
        borderRadius: BorderRadius.circular(
          4,
        ),
        border: Border.all(
          color: Colors.black.withOpacity(0.5),
          strokeAlign: BorderSide.strokeAlignCenter,
          style: BorderStyle.solid,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            providerDoctor,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          IconButton(
            iconSize: 40,
            onPressed: () async {
              BuildContext dialogContext;
              await showDialog(
                barrierDismissible: true,
                context: context,
                // barrierColor: Colors.amber,
                builder: (context) {
                  dialogContext = context;
                  return Dialog(
                    backgroundColor: Colors.red[50],
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: FutureBuilder(
                                future: database.getDoctorsList(),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    if (snapshot.data!.isEmpty) {
                                      return const Center(
                                        child:
                                            Text('No Doctor Found in Database'),
                                      );
                                    } else {
                                      return ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              ref
                                                      .read(
                                                          doctorPerIncentiveProvider
                                                              .notifier)
                                                      .state =
                                                  snapshot.data![index]
                                                      .incentivePercentage;
                                              ref
                                                      .read(doctorIdProvider
                                                          .notifier)
                                                      .state =
                                                  snapshot.data![index].id
                                                      .toString();
                                              ref
                                                      .read(doctorNameProvider
                                                          .notifier)
                                                      .state =
                                                  snapshot
                                                      .data![index].doctorName;
                                              totalAmountController.text = '0';
                                              paidController.text = '0';
                                              incentiveController.text = '0';
                                              Navigator.pop(dialogContext);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.red[200],
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: ListTile(
                                                title: Text(
                                                  snapshot
                                                      .data![index].doctorName,
                                                  style: const TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  snapshot.data![index].address,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }
                                  if (snapshot.data == null) {
                                    return const Center(
                                      child: Text('Null data to display'),
                                    );
                                  }
                                  return const Center(
                                    child: Text('Returning from last'),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.medical_services,
            ),
          ),
        ],
      ),
    );
  }
}
