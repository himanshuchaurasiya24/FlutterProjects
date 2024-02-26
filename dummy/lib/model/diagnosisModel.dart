// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DiagnosisModel {
  int? id;
  String patientName;
  String patientAge;
  String patientSex;
  String refBy;
  String diagnosisRemark;
  int totalAmount;
  int paid;
  String diagnosisType;
  DiagnosisModel({
    this.id,
    required this.patientName,
    required this.patientAge,
    required this.patientSex,
    required this.refBy,
    required this.diagnosisRemark,
    required this.totalAmount,
    required this.paid,
    required this.diagnosisType,
  });

  DiagnosisModel copyWith({
    int? id,
    String? patientName,
    String? patientAge,
    String? patientSex,
    String? refBy,
    String? diagnosisRemark,
    int? totalAmount,
    int? paid,
    String? diagnosisType,
  }) {
    return DiagnosisModel(
      id: id ?? this.id,
      patientName: patientName ?? this.patientName,
      patientAge: patientAge ?? this.patientAge,
      patientSex: patientSex ?? this.patientSex,
      refBy: refBy ?? this.refBy,
      diagnosisRemark: diagnosisRemark ?? this.diagnosisRemark,
      totalAmount: totalAmount ?? this.totalAmount,
      paid: paid ?? this.paid,
      diagnosisType: diagnosisType ?? this.diagnosisType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'patientName': patientName,
      'patientAge': patientAge,
      'patientSex': patientSex,
      'refBy': refBy,
      'diagnosisRemark': diagnosisRemark,
      'totalAmount': totalAmount,
      'paid': paid,
      'diagnosisType': diagnosisType,
    };
  }

  factory DiagnosisModel.fromMap(Map<String, dynamic> map) {
    return DiagnosisModel(
      id: map['id'] != null ? map['id'] as int : null,
      patientName: map['patientName'] as String,
      patientAge: map['patientAge'] as String,
      patientSex: map['patientSex'] as String,
      refBy: map['refBy'] as String,
      diagnosisRemark: map['diagnosisRemark'] as String,
      totalAmount: map['totalAmount'] as int,
      paid: map['paid'] as int,
      diagnosisType: map['diagnosisType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DiagnosisModel.fromJson(String source) =>
      DiagnosisModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DiagnosisModel(id: $id, patientName: $patientName, patientAge: $patientAge, patientSex: $patientSex, refBy: $refBy, diagnosisRemark: $diagnosisRemark, totalAmount: $totalAmount, paid: $paid, diagnosisType: $diagnosisType)';
  }

  @override
  bool operator ==(covariant DiagnosisModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.patientName == patientName &&
        other.patientAge == patientAge &&
        other.patientSex == patientSex &&
        other.refBy == refBy &&
        other.diagnosisRemark == diagnosisRemark &&
        other.totalAmount == totalAmount &&
        other.paid == paid &&
        other.diagnosisType == diagnosisType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        patientName.hashCode ^
        patientAge.hashCode ^
        patientSex.hashCode ^
        refBy.hashCode ^
        diagnosisRemark.hashCode ^
        totalAmount.hashCode ^
        paid.hashCode ^
        diagnosisType.hashCode;
  }
}
