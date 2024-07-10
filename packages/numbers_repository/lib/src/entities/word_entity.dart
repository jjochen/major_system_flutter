import 'package:equatable/equatable.dart';

class WordEntity extends Equatable {
  const WordEntity({
    required this.id,
    required this.value,
  });

  factory WordEntity.fromJson(Map<String, Object> json) {
    return WordEntity(
      id: json[_Key.id] as String? ?? '',
      value: json[_Key.value] as String? ?? '',
    );
  }

  factory WordEntity.fromSnapshot({
    required String id,
    required Map<String, dynamic>? data,
  }) {
    return WordEntity(
      id: id,
      value: data?[_Key.value] as String? ?? '',
    );
  }

  final String id;
  final String value;

  @override
  List<Object?> get props => [
        id,
        value,
      ];

  Map<String, Object?> toJson() {
    return {
      _Key.id: id,
      _Key.value: value,
    };
  }

  Map<String, Object?> toDocument() {
    return {
      _Key.value: value,
    };
  }
}

class _Key {
  static const String id = 'id';
  static const String value = 'value';
}
