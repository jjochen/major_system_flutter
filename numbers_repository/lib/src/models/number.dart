import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

@immutable
class Number extends Equatable {
  final String id;
  final int numberOfDigits;
  final int value;

  Number(this.id, this.numberOfDigits, this.value);

  @override
  List<Object?> get props => [numberOfDigits, value];

  @override
  bool? get stringify => true;

  Number copyWith({String? id, int? numberOfDigits, int? value}) {
    return Number(
      id ?? this.id,
      numberOfDigits ?? this.numberOfDigits,
      value ?? this.value,
    );
  }

  factory Number.fromEntity(NumberEntity entity) {
    return Number(entity.id, entity.numberOfDigits, entity.value);
  }

  NumberEntity toEntity() {
    return NumberEntity(id, numberOfDigits, value);
  }
}
