import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:numbers_repository/src/entities/entities.dart';

void main() {
  group('Number', () {
    const id = 'mock-id';
    const numberOfDigits = 3;
    const value = 42;
    const mainWord = 'main-word';

    test('instantiates without crashing', () {
      expect(
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
          mainWord: mainWord,
        ),
        isNotNull,
      );
    });

    test('transient constructor', () {
      const number = Number.transient(
        numberOfDigits: numberOfDigits,
        value: value,
        mainWord: mainWord,
      );
      expect(
        number,
        isNotNull,
      );
      expect(
        number.id,
        '',
      );
    });

    test('uses value equality', () {
      expect(
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
          mainWord: mainWord,
        ),
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
          mainWord: mainWord,
        ),
      );

      expect(
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
          mainWord: mainWord,
        ),
        isNot(
          const Number(
            id: 'other-id',
            numberOfDigits: numberOfDigits,
            value: value,
            mainWord: mainWord,
          ),
        ),
      );

      expect(
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
          mainWord: mainWord,
        ),
        isNot(
          const Number(
            id: id,
            numberOfDigits: 2,
            value: value,
            mainWord: mainWord,
          ),
        ),
      );

      expect(
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
          mainWord: mainWord,
        ),
        isNot(
          const Number(
            id: id,
            numberOfDigits: numberOfDigits,
            value: 99,
            mainWord: mainWord,
          ),
        ),
      );

      expect(
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
          mainWord: mainWord,
        ),
        isNot(
          const Number(
            id: id,
            numberOfDigits: numberOfDigits,
            value: value,
            mainWord: 'other-main-word',
          ),
        ),
      );
    });

    test('toString() uses numberOfDigets', () {
      expect(
        const Number(
          id: id,
          numberOfDigits: 2,
          value: 42,
          mainWord: mainWord,
        ).toString(),
        '42',
      );

      expect(
        const Number(
          id: id,
          numberOfDigits: 5,
          value: 42,
        ).toString(),
        '00042',
      );
    });

    test('copies with new id', () {
      const newId = 'new-id';
      expect(
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
          mainWord: mainWord,
        ).copyWith(id: () => newId),
        const Number(
          id: newId,
          numberOfDigits: numberOfDigits,
          value: value,
          mainWord: mainWord,
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
          mainWord: mainWord,
        ).copyWith(numberOfDigits: () => newNumberOfDigits),
        const Number(
          id: id,
          numberOfDigits: newNumberOfDigits,
          value: value,
          mainWord: mainWord,
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
          mainWord: mainWord,
        ).copyWith(value: () => newValue),
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: newValue,
          mainWord: mainWord,
        ),
      );
    });

    test('copies with new main word', () {
      const newMainWord = 'new-main-word';
      expect(
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
          mainWord: mainWord,
        ).copyWith(mainWord: () => newMainWord),
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
          mainWord: newMainWord,
        ),
      );
    });
    test('copies with main word set to null', () {
      expect(
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
          mainWord: mainWord,
        ).copyWith(mainWord: () => null),
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
      );
    });

    test('model to entity', () {
      expect(
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
          mainWord: mainWord,
        ).toEntity(),
        const NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
          mainWord: mainWord,
        ),
      );
    });

    test('model from entity', () {
      expect(
        Number.fromEntity(
          const NumberEntity(
            id: id,
            numberOfDigits: numberOfDigits,
            value: value,
            mainWord: mainWord,
          ),
        ),
        const Number(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
          mainWord: mainWord,
        ),
      );
    });
  });
}
