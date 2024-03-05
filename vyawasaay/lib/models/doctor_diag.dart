// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DoctorDiagModel {
  int doctorId;
  String doctorName;
  String incentive;
  DoctorDiagModel({
    required this.doctorId,
    required this.doctorName,
    required this.incentive,
  });

  DoctorDiagModel copyWith({
    int? doctorId,
    String? doctorName,
    String? incentive,
  }) {
    return DoctorDiagModel(
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      incentive: incentive ?? this.incentive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'doctorId': doctorId,
      'doctorName': doctorName,
      'incentive': incentive,
    };
  }

  factory DoctorDiagModel.fromMap(Map<String, dynamic> map) {
    return DoctorDiagModel(
      doctorId: map['doctorId'] as int,
      doctorName: map['doctorName'] as String,
      incentive: map['incentive'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorDiagModel.fromJson(String source) =>
      DoctorDiagModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DoctorDiagModel(doctorId: $doctorId, doctorName: $doctorName, incentive: $incentive)';

  @override
  bool operator ==(covariant DoctorDiagModel other) {
    if (identical(this, other)) return true;

    return other.doctorId == doctorId &&
        other.doctorName == doctorName &&
        other.incentive == incentive;
  }

  @override
  int get hashCode =>
      doctorId.hashCode ^ doctorName.hashCode ^ incentive.hashCode;
}
