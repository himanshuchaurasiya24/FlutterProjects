// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:vyawasaay/models/doctor_diag.dart';
import 'package:vyawasaay/models/patient_model.dart';

class DiagnosisInfo {
  int? id;
  PatientModel patientDetails;
  DoctorDiagModel doctorDiagModel;
  DiagnosisInfo({
    this.id,
    required this.patientDetails,
    required this.doctorDiagModel,
  });

  DiagnosisInfo copyWith({
    int? id,
    PatientModel? patientDetails,
    DoctorDiagModel? doctorDiagModel,
  }) {
    return DiagnosisInfo(
      id: id ?? this.id,
      patientDetails: patientDetails ?? this.patientDetails,
      doctorDiagModel: doctorDiagModel ?? this.doctorDiagModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'patientDetails': patientDetails.toMap(),
      'doctorDiagModel': doctorDiagModel.toMap(),
    };
  }

  factory DiagnosisInfo.fromMap(Map<String, dynamic> map) {
    return DiagnosisInfo(
      id: map['id'] != null ? map['id'] as int : null,
      patientDetails:
          PatientModel.fromMap(map['patientDetails'] as Map<String, dynamic>),
      doctorDiagModel: DoctorDiagModel.fromMap(
          map['doctorDiagModel'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DiagnosisInfo.fromJson(String source) =>
      DiagnosisInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DiagnosisInfo(id: $id, patientDetails: $patientDetails, doctorDiagModel: $doctorDiagModel)';

  @override
  bool operator ==(covariant DiagnosisInfo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.patientDetails == patientDetails &&
        other.doctorDiagModel == doctorDiagModel;
  }

  @override
  int get hashCode =>
      id.hashCode ^ patientDetails.hashCode ^ doctorDiagModel.hashCode;
}
