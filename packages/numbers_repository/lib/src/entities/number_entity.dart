import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NumberEntity extends Equatable {
  final String id;
  final int numberOfDigits;
  final int value;

  NumberEntity({
    required this.id,
    required this.numberOfDigits,
    required this.value,
  });

  @override
  List<Object?> get props => [id, numberOfDigits, value];

  @override
  bool? get stringify => true;

  factory NumberEntity.fromJson(Map<String, Object> json) {
    return NumberEntity(
      id: json[_Key.ID] as String,
      numberOfDigits: json[_Key.NUMBER_OF_DIGITS] as int,
      value: json[_Key.VALUE] as int,
    );
  }

  Map<String, Object> toJson() {
    return {
      _Key.ID: id,
      _Key.NUMBER_OF_DIGITS: numberOfDigits,
      _Key.VALUE: value,
    };
  }

  factory NumberEntity.fromSnapshot(DocumentSnapshot snap) {
    return NumberEntity(
      id: snap.id,
      numberOfDigits: snap.data()?[_Key.NUMBER_OF_DIGITS] ?? 0,
      value: snap.data()?[_Key.VALUE] ?? 0,
    );
  }

  Map<String, Object> toDocument() {
    return {
      _Key.NUMBER_OF_DIGITS: numberOfDigits,
      _Key.VALUE: value,
    };
  }
}

class _Key {
  static const String ID = 'id';
  static const String NUMBER_OF_DIGITS = 'number_of_digits';
  static const String VALUE = 'value';
}
