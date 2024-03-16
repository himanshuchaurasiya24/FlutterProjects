import 'package:flutter/material.dart';
import 'package:vyawasaay/models/incentive_gen_model.dart';

class DummyHomePage extends StatefulWidget {
  const DummyHomePage({super.key, required this.list});
  final List<IncentiveGenModel> list;
  @override
  State<DummyHomePage> createState() => _DummyHomePageState();
}

class _DummyHomePageState extends State<DummyHomePage> {
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
          ...List.generate(widget.list.length, (index) {
            List<IncentivePatientDetails> patientInfo =
                widget.list[index].patientDetails;
            String doctorName = widget.list[index].doctorName;
            return Column(
              children: [
                Text(
                  widget.list[index].doctorName,
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
