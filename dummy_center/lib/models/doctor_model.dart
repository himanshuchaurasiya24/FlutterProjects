// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DoctorModel {
  int? id;
  String name;
  String address;
  String phoneNumber;
  DoctorModel({
    this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
  });

  DoctorModel copyWith({
    int? id,
    String? name,
    String? address,
    String? phoneNumber,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      address: map['address'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorModel.fromJson(String source) =>
      DoctorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DoctorModel(id: $id, name: $name, address: $address, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(covariant DoctorModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.address == address &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        phoneNumber.hashCode;
  }
}
