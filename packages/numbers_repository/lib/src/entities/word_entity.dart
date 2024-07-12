import 'package:equatable/equatable.dart';

class WordEntity extends Equatable {
  const WordEntity({
    required this.id,
    required this.value,
    required this.isMain,
  });

  factory WordEntity.fromSnapshot({
    required String id,
    required Map<String, dynamic>? data,
  }) {
    return WordEntity(
      id: id,
      value: data?[_Key.value] as String? ?? '',
      isMain: data?[_Key.isMain] as bool? ?? false,
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

  Map<String, Object?> getDocumentData() {
    return {
      _Key.value: value,
      _Key.isMain: isMain,
    };
  }

  static Map<String, Object?> getUpdateData({
    String Function()? value,
    bool Function()? isMain,
  }) {
    return {
      if (value != null) _Key.value: value(),
      if (isMain != null) _Key.isMain: isMain(),
    };
  }
}

class _Key {
  static const String value = 'value';
  static const String isMain = 'is_main';
}
