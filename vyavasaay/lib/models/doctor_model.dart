// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DoctorModel {
  int? id;
  String doctorName;
  String doctorAge;
  String doctorSex;
  String doctorPhoneNumber;
  String address;
  String incentivePercentage;
  DoctorModel({
    this.id,
    required this.doctorName,
    required this.doctorAge,
    required this.doctorSex,
    required this.doctorPhoneNumber,
    required this.address,
    required this.incentivePercentage,
  });

  DoctorModel copyWith({
    int? id,
    String? doctorName,
    String? doctorAge,
    String? doctorSex,
    String? doctorPhoneNumber,
    String? address,
    String? incentivePercentage,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      doctorName: doctorName ?? this.doctorName,
      doctorAge: doctorAge ?? this.doctorAge,
      doctorSex: doctorSex ?? this.doctorSex,
      doctorPhoneNumber: doctorPhoneNumber ?? this.doctorPhoneNumber,
      address: address ?? this.address,
      incentivePercentage: incentivePercentage ?? this.incentivePercentage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'doctorName': doctorName,
      'doctorAge': doctorAge,
      'doctorSex': doctorSex,
      'doctorPhoneNumber': doctorPhoneNumber,
      'address': address,
      'incentivePercentage': incentivePercentage,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'] != null ? map['id'] as int : null,
      doctorName: map['doctorName'] as String,
      doctorAge: map['doctorAge'] as String,
      doctorSex: map['doctorSex'] as String,
      doctorPhoneNumber: map['doctorPhoneNumber'] as String,
      address: map['address'] as String,
      incentivePercentage: map['incentivePercentage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorModel.fromJson(String source) =>
      DoctorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DoctorModel(id: $id, doctorName: $doctorName, doctorAge: $doctorAge, doctorSex: $doctorSex, doctorPhoneNumber: $doctorPhoneNumber, address: $address, incentivePercentage: $incentivePercentage)';
  }

  @override
  bool operator ==(covariant DoctorModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.doctorName == doctorName &&
        other.doctorAge == doctorAge &&
        other.doctorSex == doctorSex &&
        other.doctorPhoneNumber == doctorPhoneNumber &&
        other.address == address &&
        other.incentivePercentage == incentivePercentage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        doctorName.hashCode ^
        doctorAge.hashCode ^
        doctorSex.hashCode ^
        doctorPhoneNumber.hashCode ^
        address.hashCode ^
        incentivePercentage.hashCode;
  }
}
