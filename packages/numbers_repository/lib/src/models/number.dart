import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

@immutable
class Number extends Equatable {
  final String id;
  final int numberOfDigits;
  final int value;

  Number({
    required this.id,
    required this.numberOfDigits,
    required this.value,
  });

  @override
  List<Object?> get props => [id, numberOfDigits, value];

  @override
  bool? get stringify => true;

  Number copyWith({String? id, int? numberOfDigits, int? value}) {
    return Number(
      id: id ?? this.id,
      numberOfDigits: numberOfDigits ?? this.numberOfDigits,
      value: value ?? this.value,
    );
  }

  factory Number.fromEntity(NumberEntity entity) {
    return Number(
      id: entity.id,
      numberOfDigits: entity.numberOfDigits,
      value: entity.value,
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
