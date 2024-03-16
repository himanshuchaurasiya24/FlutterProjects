import 'dart:io';

import 'package:intl/intl.dart';
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
    String getDate(String date) {
      DateTime tempDate = DateFormat('MMMM yyyy dd').parse(date);

      final parsedDate = DateFormat('d/M/y');
      return parsedDate.format(tempDate);
    }

    pdf.addPage(
      MultiPage(
        build: (context) {
          return [
            ...List.generate(model.length, (index) {
              List<IncentivePatientDetails> patientInfo =
                  model[index].patientDetails;
              int incentiveCount = 0;
              return Column(
                children: [
                  Row(children: [
                    Text(
                      'Dr. ${model[index].doctorName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Date',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Name',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Diagnosis',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Total',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Paid',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Discount',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Percent',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Share',
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
                        incentiveCount = incentiveCount +
                            int.tryParse(patient.incentiveAmount)!;
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                getDate(patient.date),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                patient.patientName,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                patient.remarks,
                                textAlign: TextAlign.center,
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
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                patient.discount,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                patient.percent,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                patient.incentiveAmount,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Incentive',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        Text(incentiveCount.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ]),
                  Text(
                    '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------',
                    maxLines: 1,
                  ),
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
