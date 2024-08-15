import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    this.email,
    this.name,
    this.maxNumberOfDigits = 0,
  });

  factory UserEntity.fromSnapshot({
    required String id,
    required Map<String, dynamic>? data,
  }) {
    return UserEntity(
      id: id,
      email: data?[_Key.email] as String?,
      name: data?[_Key.name] as String?,
      maxNumberOfDigits: data?[_Key.maxNumberOfDigits] as int? ?? 0,
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

  Map<String, Object?> getDocumentData() {
    return {
      _Key.email: email,
      _Key.name: name,
      _Key.maxNumberOfDigits: maxNumberOfDigits,
    };
  }

  static Map<String, Object?> getUpdateData({
    String? Function()? email,
    String? Function()? name,
    int Function()? maxNumberOfDigits,
  }) {
    return {
      if (email != null) _Key.email: email(),
      if (name != null) _Key.name: name(),
      if (maxNumberOfDigits != null)
        _Key.maxNumberOfDigits: maxNumberOfDigits(),
    };
  }
}

class _Key {
  static const String email = 'email';
  static const String name = 'name';
  static const String maxNumberOfDigits = 'max_number_of_digits';
}
