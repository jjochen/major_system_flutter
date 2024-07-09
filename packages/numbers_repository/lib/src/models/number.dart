import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:numbers_repository/src/entities/entities.dart';

@immutable
class Number extends Equatable {
  const Number({
    required this.id,
    required this.numberOfDigits,
    required this.value,
  });

  factory Number.fromEntity(NumberEntity entity) {
    return Number(
      id: entity.id,
      numberOfDigits: entity.numberOfDigits,
      value: entity.value,
    );
  }

  final String id;
  final int numberOfDigits;
  final int value;

  @override
  List<Object?> get props => [id, numberOfDigits, value];

  @override
  String toString() => value.toString().padLeft(numberOfDigits, '0');

  Number copyWith({String? id, int? numberOfDigits, int? value}) {
    return Number(
      id: id ?? this.id,
      numberOfDigits: numberOfDigits ?? this.numberOfDigits,
      value: value ?? this.value,
    );
  }

  NumberEntity toEntity() {
    return NumberEntity(
      id: id,
      numberOfDigits: numberOfDigits,
      value: value,
    );
  }
}
