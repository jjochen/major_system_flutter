import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:numbers_repository/src/entities/entities.dart';

@immutable
class User extends Equatable {
  const User({
    required this.id,
    this.email,
    this.name,
    this.maxNumberOfDigits = 0,
  });

  factory User.fromEntity(UserEntity entity) {
    return User(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      maxNumberOfDigits: entity.maxNumberOfDigits,
    );
  }

  final String id;
  final String? email;
  final String? name;
  final int maxNumberOfDigits;

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        maxNumberOfDigits,
      ];

  User copyWith({
    String Function()? id,
    String? Function()? email,
    String? Function()? name,
    int Function()? maxNumberOfDigits,
  }) {
    return User(
      id: id != null ? id() : this.id,
      email: email != null ? email() : this.email,
      name: name != null ? name() : this.name,
      maxNumberOfDigits: maxNumberOfDigits != null
          ? maxNumberOfDigits()
          : this.maxNumberOfDigits,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      maxNumberOfDigits: maxNumberOfDigits,
    );
  }
}
