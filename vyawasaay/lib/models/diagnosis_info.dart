// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DiagnosisInfo {
  String patientName;
  String patientAge;
  String patientSex;
  String date;

  String dignosisType;
  String diagnosisRemarks;
  String totalAmount;
  String paidAmount;
  String incentiveAmount;

  int doctorId;
  String doctorName;
  DiagnosisInfo({
    required this.patientName,
    required this.patientAge,
    required this.patientSex,
    required this.date,
    required this.dignosisType,
    required this.diagnosisRemarks,
    required this.totalAmount,
    required this.paidAmount,
    required this.incentiveAmount,
    required this.doctorId,
    required this.doctorName,
  });

  DiagnosisInfo copyWith({
    String? patientName,
    String? patientAge,
    String? patientSex,
    String? date,
    String? dignosisType,
    String? diagnosisRemarks,
    String? totalAmount,
    String? paidAmount,
    String? incentiveAmount,
    int? doctorId,
    String? doctorName,
  }) {
    return DiagnosisInfo(
      patientName: patientName ?? this.patientName,
      patientAge: patientAge ?? this.patientAge,
      patientSex: patientSex ?? this.patientSex,
      date: date ?? this.date,
      dignosisType: dignosisType ?? this.dignosisType,
      diagnosisRemarks: diagnosisRemarks ?? this.diagnosisRemarks,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      incentiveAmount: incentiveAmount ?? this.incentiveAmount,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'patientName': patientName,
      'patientAge': patientAge,
      'patientSex': patientSex,
      'date': date,
      'dignosisType': dignosisType,
      'diagnosisRemarks': diagnosisRemarks,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'incentiveAmount': incentiveAmount,
      'doctorId': doctorId,
      'doctorName': doctorName,
    };
  }

  factory DiagnosisInfo.fromMap(Map<String, dynamic> map) {
    return DiagnosisInfo(
      patientName: map['patientName'] as String,
      patientAge: map['patientAge'] as String,
      patientSex: map['patientSex'] as String,
      date: map['date'] as String,
      dignosisType: map['dignosisType'] as String,
      diagnosisRemarks: map['diagnosisRemarks'] as String,
      totalAmount: map['totalAmount'] as String,
      paidAmount: map['paidAmount'] as String,
      incentiveAmount: map['incentiveAmount'] as String,
      doctorId: map['doctorId'] as int,
      doctorName: map['doctorName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DiagnosisInfo.fromJson(String source) =>
      DiagnosisInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DiagnosisInfo(patientName: $patientName, patientAge: $patientAge, patientSex: $patientSex, date: $date, dignosisType: $dignosisType, diagnosisRemarks: $diagnosisRemarks, totalAmount: $totalAmount, paidAmount: $paidAmount, incentiveAmount: $incentiveAmount, doctorId: $doctorId, doctorName: $doctorName)';
  }

  @override
  bool operator ==(covariant DiagnosisInfo other) {
    if (identical(this, other)) return true;

    return other.patientName == patientName &&
        other.patientAge == patientAge &&
        other.patientSex == patientSex &&
        other.date == date &&
        other.dignosisType == dignosisType &&
        other.diagnosisRemarks == diagnosisRemarks &&
        other.totalAmount == totalAmount &&
        other.paidAmount == paidAmount &&
        other.incentiveAmount == incentiveAmount &&
        other.doctorId == doctorId &&
        other.doctorName == doctorName;
  }

  @override
  int get hashCode {
    return patientName.hashCode ^
        patientAge.hashCode ^
        patientSex.hashCode ^
        date.hashCode ^
        dignosisType.hashCode ^
        diagnosisRemarks.hashCode ^
        totalAmount.hashCode ^
        paidAmount.hashCode ^
        incentiveAmount.hashCode ^
        doctorId.hashCode ^
        doctorName.hashCode;
  }
}
