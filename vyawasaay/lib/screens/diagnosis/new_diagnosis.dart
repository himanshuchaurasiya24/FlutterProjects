import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vyawasaay/database/database_helper.dart';
import 'package:vyawasaay/models/doctor_model.dart';
import 'package:vyawasaay/widgets/custom_elevated_button.dart';
import 'package:vyawasaay/widgets/custom_text_form_field.dart';

final dateProvider = StateProvider<String>((ref) => 'No date Selected');

enum DiagnosisType { Ultrasound, Pathology, ECG, XRay }

final doctorNameProvider = StateProvider<String>((ref) => 'Select Doctor');

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

  @override
  Widget build(BuildContext context) {
    var providerDate = ref.watch(dateProvider);
    var providerDoctor = ref.watch(doctorNameProvider);
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
                    Expanded(
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
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
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

                                  ref.read(dateProvider.notifier).state =
                                      formatDate;
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
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
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
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Search Doctor',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              color: Colors.red[400]),
                                        ),
                                        Divider(
                                          thickness: 2,
                                          color: Colors.red[400],
                                        ),
                                        Expanded(
                                          child: FutureBuilder(
                                            future: database.getDoctorsList(),
                                            builder: (context, snapshot) {
                                              if (snapshot.data != null) {
                                                if (snapshot.data!.isEmpty) {
                                                  return const Center(
                                                    child: Text(
                                                        'No Doctor Found in Database'),
                                                  );
                                                } else {
                                                  return ListView.builder(
                                                    itemCount:
                                                        snapshot.data!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          ref
                                                                  .read(doctorNameProvider
                                                                      .notifier)
                                                                  .state =
                                                              snapshot
                                                                  .data![index]
                                                                  .doctorName;
                                                          doctorNameController
                                                                  .text =
                                                              ref.watch(
                                                                  doctorNameProvider);
                                                          doctorIdController
                                                                  .text =
                                                              snapshot
                                                                  .data![index]
                                                                  .id!
                                                                  .toString();
                                                          Navigator.pop(
                                                              dialogContext);
                                                        },
                                                        child: Card(
                                                          color:
                                                              Colors.red[100],
                                                          child: Column(
                                                            children: [
                                                              Text(snapshot
                                                                  .data![index]
                                                                  .doctorName),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .address,
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
                                                  child: Text(
                                                      'Null data to display'),
                                                );
                                              }
                                              return const Center(
                                                child:
                                                    Text('Returning from last'),
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
