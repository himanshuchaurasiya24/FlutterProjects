import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vyawasaay/database/database_helper.dart';
import 'package:vyawasaay/models/diagnosis_type.dart';
import 'package:vyawasaay/models/doctor_model.dart';
import 'package:vyawasaay/widgets/custom_elevated_button.dart';
import 'package:vyawasaay/widgets/custom_text_form_field.dart';

final dateProvider = StateProvider<String>((ref) => 'No date Selected');
final diagnosisTypeProvider = StateProvider<String>((ref) => 'Diagnosis Type');

final doctorNameProvider = StateProvider<String>((ref) => 'Select Doctor');
final doctorIdProvider = StateProvider<String>((ref) => 'null');

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
  @override
  Widget build(BuildContext context) {
    dateController.text = ref.watch(dateProvider);
    doctorNameController.text = ref.watch(doctorNameProvider);
    diagnosisTypeController.text = ref.watch(diagnosisTypeProvider);
    doctorIdController.text = ref.watch(doctorIdProvider);
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
                CustomTextFormField(
                  controller: patientNameController,
                  labelText: 'Patient Name',
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
                      child: CustomTextFormField(
                        controller: patientSexController,
                        labelText: 'Patient Sex',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DateSelector(
                        providerDate: ref.watch(dateProvider),
                        ref: ref,
                        dateController: dateController)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: DoctorSelectorWidget(
                          providerDoctor: ref.watch(doctorNameProvider),
                          database: database,
                          ref: ref,
                          doctorNameController: doctorNameController,
                          doctorIdController: doctorIdController),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: DiagnosisTypeSelector(
                          selectedDiagnosisType: selectedDiagnosisType,
                          ref: ref),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomElevatedButton(
                  btnName: 'Save Record',
                  function: () {},
                ),
              ],
            ),
          ),
        ),
      ),
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
      child: Container(
        decoration: BoxDecoration(
            color: Colors.red[40],
            borderRadius: BorderRadius.circular(
              4,
            ),
            border: Border.all(
                width: 1.5,
                color: Colors.grey,
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
                  final parsedDate = DateFormat('d MMMM y');
                  final formatDate = parsedDate.format(date);

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
  });

  final String providerDoctor;
  final DatabaseHelper database;
  final WidgetRef ref;
  final TextEditingController doctorNameController;
  final TextEditingController doctorIdController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red[40],
          borderRadius: BorderRadius.circular(
            4,
          ),
          border: Border.all(
              width: 1.5,
              color: Colors.grey,
              strokeAlign: BorderSide.strokeAlignCenter,
              style: BorderStyle.solid)),
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
                                              doctorNameController.text =
                                                  ref.watch(doctorNameProvider);
                                              doctorIdController.text = snapshot
                                                  .data![index].id!
                                                  .toString();
                                              Navigator.pop(dialogContext);
                                            },
                                            child: Card(
                                              color: Colors.red[100],
                                              child: Column(
                                                children: [
                                                  Text(snapshot
                                                      .data![index].doctorName),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    snapshot
                                                        .data![index].address,
                                                  ),
                                                ],
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
