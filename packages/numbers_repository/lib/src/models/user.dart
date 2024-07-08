import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:numbers_repository/src/entities/entities.dart';

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

  User copyWith({
    String Function()? id,
    String? Function()? email,
    String? Function()? name,
  }) {
    return User(
      id: id != null ? id() : this.id,
      email: email != null ? email() : this.email,
      name: name != null ? name() : this.name,
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
