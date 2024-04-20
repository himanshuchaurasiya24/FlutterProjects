// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdminModel {
  int? id;
  String name;
  String phoneNumber;
  String password;
  AdminModel({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.password,
  });

  AdminModel copyWith({
    int? id,
    String? name,
    String? phoneNumber,
    String? password,
  }) {
    return AdminModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminModel.fromJson(String source) =>
      AdminModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AdminModel(id: $id, name: $name, phoneNumber: $phoneNumber, password: $password)';
  }

  @override
  bool operator ==(covariant AdminModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode ^
        password.hashCode;
  }
}
