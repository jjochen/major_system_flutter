import 'package:equatable/equatable.dart';

class WordEntity extends Equatable {
  const WordEntity({
    required this.id,
    required this.value,
  });

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

  Map<String, Object?> getDocumentData() {
    return {
      _Key.value: value,
    };
  }
}

class _Key {
  static const String value = 'value';
}
