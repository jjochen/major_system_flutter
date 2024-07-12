import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:numbers_repository/src/entities/entities.dart';

@immutable
class Word extends Equatable {
  const Word({
    required this.id,
    required this.value,
    this.isMain = false,
  });

  factory Word.fromEntity(WordEntity entity) {
    return Word(
      id: entity.id,
      value: entity.value,
      isMain: entity.isMain,
    );
  }

  final String id;
  final String value;
  final bool isMain;

  @override
  List<Object?> get props => [
        id,
        value,
        isMain,
      ];

  @override
  String toString() => value;

  Word copyWith({
    String? id,
    String? value,
    bool? isMain,
  }) {
    return Word(
      id: id ?? this.id,
      value: value ?? this.value,
      isMain: isMain ?? this.isMain,
    );
  }

  WordEntity toEntity() {
    return WordEntity(
      id: id,
      value: value,
      isMain: isMain,
    );
  }
}
