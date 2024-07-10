import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:numbers_repository/src/entities/entities.dart';

@immutable
class Word extends Equatable {
  const Word({
    required this.id,
    required this.value,
  });

  factory Word.fromEntity(WordEntity entity) {
    return Word(
      id: entity.id,
      value: entity.value,
    );
  }

  final String id;
  final String value;

  @override
  List<Object?> get props => [id, value];

  @override
  String toString() => value;

  Word copyWith({String? id, String? value}) {
    return Word(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  WordEntity toEntity() {
    return WordEntity(
      id: id,
      value: value,
    );
  }
}
