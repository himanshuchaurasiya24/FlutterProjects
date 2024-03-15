import 'package:flutter/material.dart';
import 'package:vyawasaay/models/incentive_gen_model.dart';

class DummyHomePage extends StatefulWidget {
  const DummyHomePage({super.key});

  @override
  State<DummyHomePage> createState() => _DummyHomePageState();
}

class _DummyHomePageState extends State<DummyHomePage> {
  List<IncentiveGenModel> list = [
    IncentiveGenModel(
      doctorName: 'Sanjay Chaurasiya',
      patientDetails: [
        IncentivePatientDetails(
          patientName: 'Anuj Chaurasiya',
          patientSex: 'Male',
          date: 'March 2024 14',
          totalAmount: 500.toString(),
          paidAmount: 400.toString(),
          discount: 150.toString(),
        ),
        IncentivePatientDetails(
          patientName: 'Himanshu Chaurasiya',
          patientSex: 'Male',
          date: 'March 2024 14',
          totalAmount: 600.toString(),
          paidAmount: 500.toString(),
          discount: 200.toString(),
        ),
        IncentivePatientDetails(
          patientName: 'Shishir Chaurasiya',
          patientSex: 'Male',
          date: 'March 2024 14',
          totalAmount: 600.toString(),
          paidAmount: 500.toString(),
          discount: 200.toString(),
        ),
      ],
    ),
    IncentiveGenModel(
      doctorName: 'Mithilesh Chaurasiya',
      patientDetails: [
        IncentivePatientDetails(
          patientName: 'Anuj Chaurasiya',
          patientSex: 'Male',
          date: 'March 2024 14',
          totalAmount: 500.toString(),
          paidAmount: 400.toString(),
          discount: 150.toString(),
        ),
        IncentivePatientDetails(
          patientName: 'Himanshu Chaurasiya',
          patientSex: 'Male',
          date: 'March 2024 14',
          totalAmount: 600.toString(),
          paidAmount: 500.toString(),
          discount: 200.toString(),
        ),
        IncentivePatientDetails(
          patientName: 'Shishir Chaurasiya',
          patientSex: 'Male',
          date: 'March 2024 14',
          totalAmount: 600.toString(),
          paidAmount: 500.toString(),
          discount: 200.toString(),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dummy Home',
        ),
      ),
      body: Column(
        children: [
          const Text('Center'),
          ...List.generate(list.length, (index) {
            List<IncentivePatientDetails> patientInfo =
                list[index].patientDetails;
            String doctorName = list[index].doctorName;
            return Column(
              children: [
                Text(
                  list[index].doctorName,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Patient Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Diagnosis',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Total Amt',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Incentive',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ...List.generate(patientInfo.length, (i) {
                      IncentivePatientDetails patient = patientInfo[i];
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              patient.date,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              patient.patientName,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              doctorName,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              patient.totalAmount,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              patient.paidAmount,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      );
                    })
                  ],
                )
              ],
            );
          }),
        ],
      ),
    );
  }
}
