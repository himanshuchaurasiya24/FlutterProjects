// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DoctorModel {
  final int? id;
  final String name;
  final int age;
  final String sex;
  final int phone;
  final String address;
  final int percent;

  DoctorModel({
    this.id,
    required this.name,
    required this.age,
    required this.sex,
    required this.phone,
    required this.address,
    required this.percent,
  });

  DoctorModel copyWith({
    int? id,
    String? name,
    int? age,
    String? sex,
    int? phone,
    String? address,
    int? percent,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      sex: sex ?? this.sex,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      percent: percent ?? this.percent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'sex': sex,
      'phone': phone,
      'address': address,
      'percent': percent,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      age: map['age'] as int,
      sex: map['sex'] as String,
      phone: map['phone'] as int,
      address: map['address'] as String,
      percent: map['percent'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorModel.fromJson(String source) =>
      DoctorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DoctorModel(id: $id, name: $name, age: $age, sex: $sex, phone: $phone, address: $address, percent: $percent)';
  }

  @override
  bool operator ==(covariant DoctorModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.age == age &&
        other.sex == sex &&
        other.phone == phone &&
        other.address == address &&
        other.percent == percent;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        age.hashCode ^
        sex.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        percent.hashCode;
  }
}
