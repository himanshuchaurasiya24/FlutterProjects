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
  final String date;
  final String totalAmount;
  final String paidAmount;
  final String remarks;
  final String percent;
  final String discount;
  final String incentiveAmount;
  IncentivePatientDetails({
    required this.patientName,
    required this.date,
    required this.totalAmount,
    required this.paidAmount,
    required this.remarks,
    required this.percent,
    required this.discount,
    required this.incentiveAmount,
  });

  IncentivePatientDetails copyWith({
    String? patientName,
    String? date,
    String? totalAmount,
    String? paidAmount,
    String? remarks,
    String? percent,
    String? discount,
    String? incentiveAmount,
  }) {
    return IncentivePatientDetails(
      patientName: patientName ?? this.patientName,
      date: date ?? this.date,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      remarks: remarks ?? this.remarks,
      percent: percent ?? this.percent,
      discount: discount ?? this.discount,
      incentiveAmount: incentiveAmount ?? this.incentiveAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'patientName': patientName,
      'date': date,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'remarks': remarks,
      'percent': percent,
      'discount': discount,
      'incentiveAmount': incentiveAmount,
    };
  }

  factory IncentivePatientDetails.fromMap(Map<String, dynamic> map) {
    return IncentivePatientDetails(
      patientName: map['patientName'] as String,
      date: map['date'] as String,
      totalAmount: map['totalAmount'] as String,
      paidAmount: map['paidAmount'] as String,
      remarks: map['remarks'] as String,
      percent: map['percent'] as String,
      discount: map['discount'] as String,
      incentiveAmount: map['incentiveAmount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory IncentivePatientDetails.fromJson(String source) =>
      IncentivePatientDetails.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IncentivePatientDetails(patientName: $patientName, date: $date, totalAmount: $totalAmount, paidAmount: $paidAmount, remarks: $remarks, percent: $percent, discount: $discount, incentiveAmount: $incentiveAmount)';
  }

  @override
  bool operator ==(covariant IncentivePatientDetails other) {
    if (identical(this, other)) return true;

    return other.patientName == patientName &&
        other.date == date &&
        other.totalAmount == totalAmount &&
        other.paidAmount == paidAmount &&
        other.remarks == remarks &&
        other.percent == percent &&
        other.discount == discount &&
        other.incentiveAmount == incentiveAmount;
  }

  @override
  int get hashCode {
    return patientName.hashCode ^
        date.hashCode ^
        totalAmount.hashCode ^
        paidAmount.hashCode ^
        remarks.hashCode ^
        percent.hashCode ^
        discount.hashCode ^
        incentiveAmount.hashCode;
  }
}
