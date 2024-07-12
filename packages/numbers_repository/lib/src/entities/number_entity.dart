import 'package:equatable/equatable.dart';

class NumberEntity extends Equatable {
  const NumberEntity({
    required this.id,
    required this.numberOfDigits,
    required this.value,
    this.mainWord,
  });

  factory NumberEntity.fromSnapshot({
    required String id,
    required Map<String, dynamic>? data,
  }) {
    return NumberEntity(
      id: id,
      numberOfDigits: data?[_Key.numberOfDigits] as int? ?? 0,
      value: data?[_Key.value] as int? ?? 0,
      mainWord: data?[_Key.mainWord] as String?,
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

  Map<String, Object?> getDocumentData() {
    return {
      _Key.numberOfDigits: numberOfDigits,
      _Key.value: value,
      _Key.mainWord: mainWord,
    };
  }

  static Map<String, Object?> getUpdateData({
    int Function()? numberOfDigits,
    int Function()? value,
    String Function()? mainWord,
  }) {
    return {
      if (numberOfDigits != null) _Key.numberOfDigits: numberOfDigits(),
      if (value != null) _Key.value: value(),
      if (mainWord != null) _Key.mainWord: mainWord(),
    };
  }
}

class _Key {
  static const String numberOfDigits = 'number_of_digits';
  static const String value = 'value';
  static const String mainWord = 'main_word';
}
