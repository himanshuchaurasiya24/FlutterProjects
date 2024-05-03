// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginHistoryModel {
  int? id;
  int personId;
  String name;
  String time;
  String type;
  LoginHistoryModel({
    this.id,
    required this.personId,
    required this.name,
    required this.time,
    required this.type,
  });

  LoginHistoryModel copyWith({
    int? id,
    int? personId,
    String? name,
    String? time,
    String? type,
  }) {
    return LoginHistoryModel(
      id: id ?? this.id,
      personId: personId ?? this.personId,
      name: name ?? this.name,
      time: time ?? this.time,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'personId': personId,
      'name': name,
      'time': time,
      'type': type,
    };
  }

  factory LoginHistoryModel.fromMap(Map<String, dynamic> map) {
    return LoginHistoryModel(
      id: map['id'] != null ? map['id'] as int : null,
      personId: map['personId'] as int,
      name: map['name'] as String,
      time: map['time'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginHistoryModel.fromJson(String source) =>
      LoginHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginHistoryModel(id: $id, personId: $personId, name: $name, time: $time, type: $type)';
  }

  @override
  bool operator ==(covariant LoginHistoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.personId == personId &&
        other.name == name &&
        other.time == time &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        personId.hashCode ^
        name.hashCode ^
        time.hashCode ^
        type.hashCode;
  }
}
