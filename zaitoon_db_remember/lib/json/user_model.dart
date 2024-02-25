// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final int? id;
  final String? fullName;
  final String? email;
  final String userName;
  final String usrPassword;
  UserModel({
    this.id,
    this.fullName,
    this.email,
    required this.userName,
    required this.usrPassword,
  });

  UserModel copyWith({
    int? id,
    String? fullName,
    String? email,
    String? userName,
    String? usrPassword,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      usrPassword: usrPassword ?? this.usrPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'userName': userName,
      'usrPassword': usrPassword,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      userName: map['userName'] as String,
      usrPassword: map['usrPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, fullName: $fullName, email: $email, userName: $userName, usrPassword: $usrPassword)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullName == fullName &&
        other.email == email &&
        other.userName == userName &&
        other.usrPassword == usrPassword;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        email.hashCode ^
        userName.hashCode ^
        usrPassword.hashCode;
  }
}
