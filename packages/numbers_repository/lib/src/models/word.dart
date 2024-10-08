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

  const Word.transient({
    required this.value,
    this.isMain = false,
  }) : id = '';

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
    String Function()? id,
    String Function()? value,
    bool Function()? isMain,
  }) {
    return Word(
      id: id != null ? id() : this.id,
      value: value != null ? value() : this.value,
      isMain: isMain != null ? isMain() : this.isMain,
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
