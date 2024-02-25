import 'dart:convert';

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class PersonModel {
//   int? id;
//   String name;
//   int phoneNumber;
//   PersonModel({
//     this.id,
//     required this.name,
//     required this.phoneNumber,
//   });

//   PersonModel copyWith({
//     int? id,
//     String? name,
//     int? phoneNumber,
//   }) {
//     return PersonModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       'phoneNumber': phoneNumber,
//     };
//   }

//   factory PersonModel.fromMap(Map<String, dynamic> map) {
//     return PersonModel(
//       id: map['id'] != null ? map['id'] as int : null,
//       name: map['name'] as String,
//       phoneNumber: map['phoneNumber'] as int,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory PersonModel.fromJson(String source) =>
//       PersonModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() =>
//       'PersonModel(id: $id, name: $name, phoneNumber: $phoneNumber)';

//   @override
//   bool operator ==(covariant PersonModel other) {
//     if (identical(this, other)) return true;

//     return other.id == id &&
//         other.name == name &&
//         other.phoneNumber == phoneNumber;
//   }

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode ^ phoneNumber.hashCode;
// }

class DoctorModel {
  int? id;
  String name;
  String address;
  String phoneNumber;
  int incentive;
  DoctorModel(
      {this.id,
      required this.name,
      required this.address,
      required this.phoneNumber,
      required this.incentive});

  DoctorModel copyWith({
    int? id,
    String? name,
    String? address,
    String? phoneNumber,
    int? incentive,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      incentive: incentive ?? this.incentive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'incentive': incentive,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      address: map['address'] as String,
      phoneNumber: map['phoneNumber'] as String,
      incentive: map['incentive'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorModel.fromJson(String source) =>
      DoctorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DoctorModel(id: $id, name: $name, address: $address, phoneNumber: $phoneNumber, incentive: $incentive)';
  }

  @override
  bool operator ==(covariant DoctorModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.address == address &&
        other.phoneNumber == phoneNumber &&
        other.incentive == incentive;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        phoneNumber.hashCode ^
        incentive.hashCode;
  }
}
