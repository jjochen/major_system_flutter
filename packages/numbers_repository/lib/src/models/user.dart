import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

@immutable
class User extends Equatable {
  const User({
    required this.id,
    this.email,
    this.name,
  });

  factory User.fromEntity(UserEntity entity) {
    return User(
      id: entity.id,
      email: entity.email,
      name: entity.name,
    );
  }

  final String id;
  final String? email;
  final String? name;

  @override
  List<Object?> get props => [id, email, name];

  @override
  bool? get stringify => true;

  static const _doNotUse = '###_DO_NOT_USE_###';
  User copyWith({
    String? id,
    String? email = _doNotUse,
    String? name = _doNotUse,
  }) {
    return User(
      id: id ?? this.id,
      email: email == _doNotUse ? this.email : email,
      name: name == _doNotUse ? this.name : name,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
    );
  }
}
