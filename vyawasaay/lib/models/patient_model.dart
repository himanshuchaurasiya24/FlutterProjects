// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PatientModel {
  String patientName;
  String patientAge;
  String patientSex;
  String date;
  String refBy;

  String dignosisType;
  String diagnosisRemarks;
  String totalAmount;
  String paidAmount;
  PatientModel({
    required this.patientName,
    required this.patientAge,
    required this.patientSex,
    required this.date,
    required this.refBy,
    required this.dignosisType,
    required this.diagnosisRemarks,
    required this.totalAmount,
    required this.paidAmount,
  });

  PatientModel copyWith({
    String? patientName,
    String? patientAge,
    String? patientSex,
    String? date,
    String? refBy,
    String? dignosisType,
    String? diagnosisRemarks,
    String? totalAmount,
    String? paidAmount,
  }) {
    return PatientModel(
      patientName: patientName ?? this.patientName,
      patientAge: patientAge ?? this.patientAge,
      patientSex: patientSex ?? this.patientSex,
      date: date ?? this.date,
      refBy: refBy ?? this.refBy,
      dignosisType: dignosisType ?? this.dignosisType,
      diagnosisRemarks: diagnosisRemarks ?? this.diagnosisRemarks,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'patientName': patientName,
      'patientAge': patientAge,
      'patientSex': patientSex,
      'date': date,
      'refBy': refBy,
      'dignosisType': dignosisType,
      'diagnosisRemarks': diagnosisRemarks,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      patientName: map['patientName'] as String,
      patientAge: map['patientAge'] as String,
      patientSex: map['patientSex'] as String,
      date: map['date'] as String,
      refBy: map['refBy'] as String,
      dignosisType: map['dignosisType'] as String,
      diagnosisRemarks: map['diagnosisRemarks'] as String,
      totalAmount: map['totalAmount'] as String,
      paidAmount: map['paidAmount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientModel.fromJson(String source) =>
      PatientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PatientModel(patientName: $patientName, patientAge: $patientAge, patientSex: $patientSex, date: $date, refBy: $refBy, dignosisType: $dignosisType, diagnosisRemarks: $diagnosisRemarks, totalAmount: $totalAmount, paidAmount: $paidAmount)';
  }

  @override
  bool operator ==(covariant PatientModel other) {
    if (identical(this, other)) return true;

    return other.patientName == patientName &&
        other.patientAge == patientAge &&
        other.patientSex == patientSex &&
        other.date == date &&
        other.refBy == refBy &&
        other.dignosisType == dignosisType &&
        other.diagnosisRemarks == diagnosisRemarks &&
        other.totalAmount == totalAmount &&
        other.paidAmount == paidAmount;
  }

  @override
  int get hashCode {
    return patientName.hashCode ^
        patientAge.hashCode ^
        patientSex.hashCode ^
        date.hashCode ^
        refBy.hashCode ^
        dignosisType.hashCode ^
        diagnosisRemarks.hashCode ^
        totalAmount.hashCode ^
        paidAmount.hashCode;
  }
}
