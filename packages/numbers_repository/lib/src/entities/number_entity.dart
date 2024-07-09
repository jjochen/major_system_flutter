import 'package:equatable/equatable.dart';

class NumberEntity extends Equatable {
  const NumberEntity({
    required this.id,
    required this.numberOfDigits,
    required this.value,
  });

  factory NumberEntity.fromJson(Map<String, Object> json) {
    return NumberEntity(
      id: json[_Key.id]! as String,
      numberOfDigits: json[_Key.numberOfDigits]! as int,
      value: json[_Key.value]! as int,
    );
  }

  factory NumberEntity.fromSnapshot({
    required String id,
    required Map<String, dynamic>? data,
  }) {
    return NumberEntity(
      id: id,
      numberOfDigits: data?[_Key.numberOfDigits] as int? ?? 0,
      value: data?[_Key.value] as int? ?? 0,
    );
  }

  final String id;
  final int numberOfDigits;
  final int value;

  @override
  List<Object?> get props => [id, numberOfDigits, value];

  Map<String, Object> toJson() {
    return {
      _Key.id: id,
      _Key.numberOfDigits: numberOfDigits,
      _Key.value: value,
    };
  }

  Map<String, Object> toDocument() {
    return {
      _Key.numberOfDigits: numberOfDigits,
      _Key.value: value,
    };
  }
}

class _Key {
  static const String id = 'id';
  static const String numberOfDigits = 'number_of_digits';
  static const String value = 'value';
}
