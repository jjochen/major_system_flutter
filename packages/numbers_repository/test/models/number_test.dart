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
        Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
        Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
      );
    });

    test('uses stringify', () {
      expect(
        Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ).toString(),
        'Number(mock-id, 3, 42)',
      );
    });

    test('copies with new id', () {
      final newId = 'new-id';
      expect(
        Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ).copyWith(id: newId),
        Number(
          id: newId,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
      );
    });

    test('copies with new number of digits', () {
      final newNumberOfDigits = 2;
      expect(
        Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ).copyWith(numberOfDigits: newNumberOfDigits),
        Number(
          id: id,
          numberOfDigits: newNumberOfDigits,
          value: value,
        ),
      );
    });

    test('copies with new value', () {
      final newValue = 99;
      expect(
        Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ).copyWith(value: newValue),
        Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: newValue,
        ),
      );
    });

    test('model to entity', () {
      expect(
        Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ).toEntity(),
        NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
      );
    });

    test('model from entity', () {
      expect(
        Number.fromEntity(NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        )),
        Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
      );
    });
  });
}
