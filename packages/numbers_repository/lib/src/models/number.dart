import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:numbers_repository/src/entities/entities.dart';

@immutable
class Number extends Equatable {
  const Number({
    required this.id,
    required this.numberOfDigits,
    required this.value,
    this.mainWord,
  }) : assert(numberOfDigits > 0, 'numberOfDigits must be greater than 0');

  const Number.transient({
    required this.numberOfDigits,
    required this.value,
    this.mainWord,
  })  : id = '',
        assert(numberOfDigits > 0, 'numberOfDigits must be greater than 0');

  factory Number.fromEntity(NumberEntity entity) {
    return Number(
      id: entity.id,
      numberOfDigits: entity.numberOfDigits,
      value: entity.value,
      mainWord: entity.mainWord,
    );
  }

  final String id;
  final int numberOfDigits;
  final int value;
  final String? mainWord;

  @override
  List<Object?> get props => [
        id,
        numberOfDigits,
        value,
        mainWord,
      ];

  @override
  String toString() => value.toString().padLeft(numberOfDigits, '0');

  Number copyWith({
    String Function()? id,
    int Function()? numberOfDigits,
    int Function()? value,
    String? Function()? mainWord,
  }) {
    return Number(
      id: id != null ? id() : this.id,
      numberOfDigits:
          numberOfDigits != null ? numberOfDigits() : this.numberOfDigits,
      value: value != null ? value() : this.value,
      mainWord: mainWord != null ? mainWord() : this.mainWord,
    );
  }

  NumberEntity toEntity() {
    return NumberEntity(
      id: id,
      numberOfDigits: numberOfDigits,
      value: value,
      mainWord: mainWord,
    );
  }
}
