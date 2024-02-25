// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentModel {
  int? id;
  int doctorId;
  int patientId;
  String diagnosisType;
  int totalAmount;
  int paidAmount;
  PaymentModel({
    this.id,
    required this.doctorId,
    required this.patientId,
    required this.diagnosisType,
    required this.totalAmount,
    required this.paidAmount,
  });

  PaymentModel copyWith({
    int? id,
    int? doctorId,
    int? patientId,
    String? diagnosisType,
    int? totalAmount,
    int? paidAmount,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      patientId: patientId ?? this.patientId,
      diagnosisType: diagnosisType ?? this.diagnosisType,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'doctorId': doctorId,
      'patientId': patientId,
      'diagnosisType': diagnosisType,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'] != null ? map['id'] as int : null,
      doctorId: map['doctorId'] as int,
      patientId: map['patientId'] as int,
      diagnosisType: map['diagnosisType'] as String,
      totalAmount: map['totalAmount'] as int,
      paidAmount: map['paidAmount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentModel.fromJson(String source) =>
      PaymentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentModel(id: $id, doctorId: $doctorId, patientId: $patientId, diagnosisType: $diagnosisType, totalAmount: $totalAmount, paidAmount: $paidAmount)';
  }

  @override
  bool operator ==(covariant PaymentModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.doctorId == doctorId &&
        other.patientId == patientId &&
        other.diagnosisType == diagnosisType &&
        other.totalAmount == totalAmount &&
        other.paidAmount == paidAmount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        doctorId.hashCode ^
        patientId.hashCode ^
        diagnosisType.hashCode ^
        totalAmount.hashCode ^
        paidAmount.hashCode;
  }
}
