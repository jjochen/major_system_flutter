import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    this.email,
    this.name,
  });

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
  List<Object?> get props => [
        id,
        email,
        name,
      ];

  Map<String, Object?> getDocumentData() {
    return {
      _Key.email: email,
      _Key.name: name,
    };
  }
}

class _Key {
  static const String email = 'email';
  static const String name = 'name';
}
