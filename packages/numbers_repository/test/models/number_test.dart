import 'package:numbers_repository/numbers_repository.dart';
import 'package:numbers_repository/src/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Number', () {
    const id = 'mock-id';
    const numberOfDigits = 3;
    const value = 42;

    test('uses value equality', () {
      expect(
        Number(id, numberOfDigits, value),
        Number(id, numberOfDigits, value),
      );
    });

    test('copies with new id', () {
      final newId = 'new-id';
      expect(
        Number(id, numberOfDigits, value).copyWith(id: newId),
        Number(newId, numberOfDigits, value),
      );
    });

    test('copies with new number of digits', () {
      final newNumberOfDigits = 2;
      expect(
        Number(id, numberOfDigits, value).copyWith(numberOfDigits: newNumberOfDigits),
        Number(id, newNumberOfDigits, value),
      );
    });

    test('copies with new value', () {
      final newValue = 99;
      expect(
        Number(id, numberOfDigits, value).copyWith(value: newValue),
        Number(id, numberOfDigits, newValue),
      );
    });

    test('model to entity', () {
      expect(
        Number(id, numberOfDigits, value).toEntity(),
        NumberEntity(id, numberOfDigits, value),
      );
    });

    test('model from entity', () {
      expect(
        Number.fromEntity(NumberEntity(id, numberOfDigits, value)),
        Number(id, numberOfDigits, value),
      );
    });
  });
}
