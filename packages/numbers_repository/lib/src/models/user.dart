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
  List<Object?> get props => [email, id, name];

  @override
  bool? get stringify => true;

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
    );
  }
}
