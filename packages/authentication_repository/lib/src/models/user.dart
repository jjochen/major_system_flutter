import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
  });

  final String id;
  final String? email;
  final String? name;
  final String? photo;

  static const empty = User(id: '');

  @override
  List<Object?> get props => [email, id, name, photo];
}
