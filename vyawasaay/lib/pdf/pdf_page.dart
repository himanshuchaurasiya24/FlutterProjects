// import 'package:flutter/material.dart';

// class PdfPage extends StatefulWidget {
//   const PdfPage({super.key});

//   @override
//   State<PdfPage> createState() => _PdfPageState();
// }

// class _PdfPageState extends State<PdfPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(MyApp.title),
//         centerTitle: true,
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(32),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ButtonWidget(
//                 text: 'Simple Pdf',
//                 onClicked: () async {
//                   // 1
//                   // final pdfFile = await PdfApi.generateCenteredText(
//                   //     'Fisrt Pdf Sample Text.');
//                   // PdfApi.openFile(file: pdfFile);
//                   // 2
//                   // final pdfFile = await PdfParagraphApi.calculator(
//                   //   model: DiagnosisModel(
//                   //     patientName: 'Himanshu',
//                   //     patientAge: 24.toString(),
//                   //     patientSex: 'Male',
//                   //     date: '13 March 2024',
//                   //     dignosisType: 'Ultrasound',
//                   //     diagnosisRemarks: 'Abnormal Ultrasound',
//                   //     totalAmount: '500',
//                   //     paidAmount: '300',
//                   //     incentiveAmount: '50',
//                   //     doctorId: 1,
//                   //     doctorName: 'Sanjay Chaurasiya',
//                   //   ),
//                   // );
//                   // PdfApi.openFile(file: pdfFile);
//                   final pdfFile = await PdfParagraphApi.calculatorList(model: [
//                     DiagnosisModel(
//                       patientName: 'Himanshu',
//                       patientAge: 24.toString(),
//                       patientSex: 'Male',
//                       date: '13 March 2024',
//                       dignosisType: 'Ultrasound',
//                       diagnosisRemarks: 'Abnormal Ultrasound',
//                       totalAmount: '500',
//                       paidAmount: '300',
//                       incentiveAmount: '50',
//                       doctorId: 1,
//                       doctorName: 'Sanjay Chaurasiya',
//                     ),
//                     DiagnosisModel(
//                       patientName: 'Anuj',
//                       patientAge: 24.toString(),
//                       patientSex: 'Male',
//                       date: '13 March 2024',
//                       dignosisType: 'Path',
//                       diagnosisRemarks: 'Abnormal Path',
//                       totalAmount: '600',
//                       paidAmount: '400',
//                       incentiveAmount: '30',
//                       doctorId: 2,
//                       doctorName: 'Mithilesh Chaurasiya',
//                     ),
//                   ]);
//                   PdfApi.openFile(file: pdfFile);
//                 },
//               ),
//               const SizedBox(
//                 height: 24,
//               ),
//               ButtonWidget(
//                 text: 'Paragraphs Pdf',
//                 onClicked: () async {
//                   final pdfFile = await PdfParagraphApi.generate();
//                   PdfApi.openFile(file: pdfFile);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
