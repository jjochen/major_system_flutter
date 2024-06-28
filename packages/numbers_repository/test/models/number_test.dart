import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:numbers_repository/src/entities/entities.dart';

void main() {
  group('Number', () {
    const id = 'mock-id';
    const numberOfDigits = 3;
    const value = 42;

    test('uses value equality', () {
      expect(
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
      );
    });

    test('uses stringify', () {
      expect(
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ).toString(),
        'Number(mock-id, 3, 42)',
      );
    });

    test('copies with new id', () {
      const newId = 'new-id';
      expect(
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ).copyWith(id: newId),
        const Number(
          id: newId,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
      );
    });

    test('copies with new number of digits', () {
      const newNumberOfDigits = 2;
      expect(
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ).copyWith(numberOfDigits: newNumberOfDigits),
        const Number(
          id: id,
          numberOfDigits: newNumberOfDigits,
          value: value,
        ),
      );
    });

    test('copies with new value', () {
      const newValue = 99;
      expect(
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ).copyWith(value: newValue),
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: newValue,
        ),
      );
    });

    test('model to entity', () {
      expect(
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ).toEntity(),
        const NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
      );
    });

    test('model from entity', () {
      expect(
        Number.fromEntity(const NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ),),
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
      );
    });
  });
}
