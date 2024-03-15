import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:vyawasaay/models/incentive_gen_model.dart';
import 'package:vyawasaay/pdf/pdf_api.dart';

class PdfParagraphApi {
  static Future<File> generate() async {
    final pdf = Document();
    pdf.addPage(
      MultiPage(
        build: (context) {
          return <Widget>[
            buildCustomHeader(),
            Header(
              child: Text('My Headline'),
            ),
            buildCustomHeadline(),
            buildLink(),
            ...buildBulletPoints(),
            Paragraph(
              text: LoremText().paragraph(60),
            ),
            Paragraph(
              text: LoremText().paragraph(60),
            ),
            Paragraph(
              text: LoremText().paragraph(60),
            ),
            Paragraph(
              text: LoremText().paragraph(60),
            ),
            Paragraph(
              text: LoremText().paragraph(60),
            ),
            Paragraph(
              text: LoremText().paragraph(60),
            ),
          ];
        },
        footer: (context) {
          final text = 'Page ${context.pageNumber} of ${context.pagesCount}';
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                text,
                textAlign: TextAlign.end,
              ),
            ],
          );
        },
      ),
    );
    return PdfApi.saveDocument(name: 'first_pdf_paragraph.pdf', pdf: pdf);
  }

  static Future<File> calculatorList(
      {required List<IncentiveGenModel> model}) async {
    final pdf = Document();
    pdf.addPage(
      MultiPage(
        build: (context) {
          return [
            ...List.generate(model.length, (index) {
              List<IncentivePatientDetails> patientInfo =
                  model[index].patientDetails;

              int incentive = 0;
              return Column(
                children: [
                  Header(
                    child: Text(
                      model[index].doctorName,
                    ),
                  ),
                  Row(
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
                        incentive = incentive + int.tryParse(patient.discount)!;
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
                                patient.patientSex,
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
                      }),
                      Text(
                        incentive.toString(),
                      ),
                    ],
                  )
                ],
              );
            }),
          ];
        },
      ),
    );
    return PdfApi.saveDocument(name: 'list_incentive.pdf', pdf: pdf);
  }

  // static Future<File> calculator({required IncentiveGenModel model}) async {
  //   final pdf = Document();
  //   pdf.addPage(
  //     MultiPage(
  //       build: (context) {
  //         return <Widget>[
  //           // buildCustomHeader(),
  //           Header(
  //             child: Expanded(
  //               child: Text(
  //                 model.doctorName,
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Row(children: [
  //             Expanded(
  //               child: Text(
  //                 'Date',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Text(
  //                 'Patient Name',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Text(
  //                 'Diagnosis',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Text(
  //                 'Total Amt',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Text(
  //                 'Incentive',
  //                 textAlign: TextAlign.end,
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ]),
  //           Row(children: [
  //             Expanded(
  //               child: Text(
  //                 model.date,
  //               ),
  //             ),
  //             Expanded(
  //               child: Text(
  //                 model.patientName,
  //               ),
  //             ),
  //             Expanded(
  //               child: Text(
  //                 model.doctorName,
  //               ),
  //             ),
  //             Expanded(
  //               child: Text(
  //                 model.totalAmount,
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //             Expanded(
  //               child: Text(
  //                 model.incentiveAmount,
  //                 textAlign: TextAlign.end,
  //               ),
  //             ),
  //           ])
  //         ];
  //       },
  //     ),
  //   );
  //   return PdfApi.saveDocument(name: 'incentive_calculator.pdf', pdf: pdf);
  // }

  static List<Widget> buildBulletPoints() {
    return [
      Bullet(
        text: 'Fisrt Bullet',
      ),
      Bullet(
        text: 'Second Bullet',
      ),
      Bullet(
        text: 'Third Bullet',
      ),
    ];
  }

  static Widget buildLink() {
    return UrlLink(
      child: Text(
        'Go to',
        style: TextStyle(
          color: PdfColor.fromRYB(
            0,
            0,
            1.0,
          ),
          decoration: TextDecoration.underline,
        ),
      ),
      destination: 'https://instagram.com/_hc24',
    );
  }

  static Widget buildCustomHeadline() {
    return Header(
        child: Text(
          'My Second Headline',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PdfColors.white,
          ),
        ),
        decoration: const BoxDecoration(
          color: PdfColors.red,
        ));
  }

  static Widget buildCustomHeader() {
    return Container(
      padding: const EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: PdfColors.blue,
          ),
        ),
      ),
      child: Row(
        children: [
          PdfLogo(),
          SizedBox(
            width: 0.5 * PdfPageFormat.cm,
          ),
          Text('Create your Pdf'),
        ],
      ),
    );
  }
}
