// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class IncentiveGenModel {
  final String doctorName;
  final List<IncentivePatientDetails> patientDetails;
  IncentiveGenModel({
    required this.doctorName,
    required this.patientDetails,
  });

  IncentiveGenModel copyWith({
    String? doctorName,
    List<IncentivePatientDetails>? patientDetails,
  }) {
    return IncentiveGenModel(
      doctorName: doctorName ?? this.doctorName,
      patientDetails: patientDetails ?? this.patientDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'doctorName': doctorName,
      'patientDetails': patientDetails.map((x) => x.toMap()).toList(),
    };
  }

  factory IncentiveGenModel.fromMap(Map<String, dynamic> map) {
    return IncentiveGenModel(
      doctorName: map['doctorName'] as String,
      patientDetails: List<IncentivePatientDetails>.from(
        (map['patientDetails'] as List<int>).map<IncentivePatientDetails>(
          (x) => IncentivePatientDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory IncentiveGenModel.fromJson(String source) =>
      IncentiveGenModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'IncentiveGenModel(doctorName: $doctorName, patientDetails: $patientDetails)';

  @override
  bool operator ==(covariant IncentiveGenModel other) {
    if (identical(this, other)) return true;

    return other.doctorName == doctorName &&
        listEquals(other.patientDetails, patientDetails);
  }

  @override
  int get hashCode => doctorName.hashCode ^ patientDetails.hashCode;
}

class IncentivePatientDetails {
  final String patientName;
  final String patientSex;
  final String date;
  final String totalAmount;
  final String paidAmount;
  final String discount;
  IncentivePatientDetails({
    required this.patientName,
    required this.patientSex,
    required this.date,
    required this.totalAmount,
    required this.paidAmount,
    required this.discount,
  });

  IncentivePatientDetails copyWith({
    String? patientName,
    String? patientSex,
    String? date,
    String? totalAmount,
    String? paidAmount,
    String? discount,
  }) {
    return IncentivePatientDetails(
      patientName: patientName ?? this.patientName,
      patientSex: patientSex ?? this.patientSex,
      date: date ?? this.date,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      discount: discount ?? this.discount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'patientName': patientName,
      'patientSex': patientSex,
      'date': date,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'discount': discount,
    };
  }

  factory IncentivePatientDetails.fromMap(Map<String, dynamic> map) {
    return IncentivePatientDetails(
      patientName: map['patientName'] as String,
      patientSex: map['patientSex'] as String,
      date: map['date'] as String,
      totalAmount: map['totalAmount'] as String,
      paidAmount: map['paidAmount'] as String,
      discount: map['discount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory IncentivePatientDetails.fromJson(String source) =>
      IncentivePatientDetails.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IncentivePatientDetails(patientName: $patientName, patientSex: $patientSex, date: $date, totalAmount: $totalAmount, paidAmount: $paidAmount, discount: $discount)';
  }

  @override
  bool operator ==(covariant IncentivePatientDetails other) {
    if (identical(this, other)) return true;

    return other.patientName == patientName &&
        other.patientSex == patientSex &&
        other.date == date &&
        other.totalAmount == totalAmount &&
        other.paidAmount == paidAmount &&
        other.discount == discount;
  }

  @override
  int get hashCode {
    return patientName.hashCode ^
        patientSex.hashCode ^
        date.hashCode ^
        totalAmount.hashCode ^
        paidAmount.hashCode ^
        discount.hashCode;
  }
}
