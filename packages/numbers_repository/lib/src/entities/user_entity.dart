import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    this.email,
    this.name,
  });

  factory UserEntity.fromJson(Map<String, Object> json) {
    return UserEntity(
      id: json[_Key.id]! as String,
      email: json[_Key.email] as String?,
      name: json[_Key.name] as String?,
    );
  }

  factory UserEntity.fromSnapshot({
    required String id,
    required Map<String, dynamic>? data,
  }) {
    return UserEntity(
      id: id,
      email: data?[_Key.email] as String?,
      name: data?[_Key.name] as String?,
    );
  }

  final String id;
  final String? email;
  final String? name;

  @override
  List<Object?> get props => [id, email, name];

  Map<String, Object?> toJson() {
    return {
      _Key.id: id,
      _Key.email: email,
      _Key.name: name,
    };
  }

  Map<String, Object?> toDocument() {
    return {
      _Key.email: email,
      _Key.name: name,
    };
  }
}

class _Key {
  static const String id = 'id';
  static const String email = 'email';
  static const String name = 'name';
}
