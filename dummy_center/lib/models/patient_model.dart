// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PatientModel {
  int? id;
  int doctorId;
  String date;
  String patientName;
  int patientAge;
  String patientSex;
  String diagnosisType;
  String patientPhoneNumber;
  String patientDiagnosisRemark;
  PatientModel({
    this.id,
    required this.doctorId,
    required this.date,
    required this.patientName,
    required this.patientAge,
    required this.patientSex,
    required this.diagnosisType,
    required this.patientPhoneNumber,
    required this.patientDiagnosisRemark,
  });

  PatientModel copyWith({
    int? id,
    int? doctorId,
    String? date,
    String? patientName,
    int? patientAge,
    String? patientSex,
    String? diagnosisType,
    String? patientPhoneNumber,
    String? patientDiagnosisRemark,
  }) {
    return PatientModel(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      date: date ?? this.date,
      patientName: patientName ?? this.patientName,
      patientAge: patientAge ?? this.patientAge,
      patientSex: patientSex ?? this.patientSex,
      diagnosisType: diagnosisType ?? this.diagnosisType,
      patientPhoneNumber: patientPhoneNumber ?? this.patientPhoneNumber,
      patientDiagnosisRemark:
          patientDiagnosisRemark ?? this.patientDiagnosisRemark,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'doctorId': doctorId,
      'date': date,
      'patientName': patientName,
      'patientAge': patientAge,
      'patientSex': patientSex,
      'diagnosisType': diagnosisType,
      'patientPhoneNumber': patientPhoneNumber,
      'patientDiagnosisRemark': patientDiagnosisRemark,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      id: map['id'] != null ? map['id'] as int : null,
      doctorId: map['doctorId'] as int,
      date: map['date'] as String,
      patientName: map['patientName'] as String,
      patientAge: map['patientAge'] as int,
      patientSex: map['patientSex'] as String,
      diagnosisType: map['diagnosisType'] as String,
      patientPhoneNumber: map['patientPhoneNumber'] as String,
      patientDiagnosisRemark: map['patientDiagnosisRemark'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientModel.fromJson(String source) =>
      PatientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PatientModel(id: $id, doctorId: $doctorId, date: $date, patientName: $patientName, patientAge: $patientAge, patientSex: $patientSex, diagnosisType: $diagnosisType, patientPhoneNumber: $patientPhoneNumber, patientDiagnosisRemark: $patientDiagnosisRemark)';
  }

  @override
  bool operator ==(covariant PatientModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.doctorId == doctorId &&
        other.date == date &&
        other.patientName == patientName &&
        other.patientAge == patientAge &&
        other.patientSex == patientSex &&
        other.diagnosisType == diagnosisType &&
        other.patientPhoneNumber == patientPhoneNumber &&
        other.patientDiagnosisRemark == patientDiagnosisRemark;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        doctorId.hashCode ^
        date.hashCode ^
        patientName.hashCode ^
        patientAge.hashCode ^
        patientSex.hashCode ^
        diagnosisType.hashCode ^
        patientPhoneNumber.hashCode ^
        patientDiagnosisRemark.hashCode;
  }
}
