import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_repository/src/entities/entities.dart';
import 'package:numbers_repository/src/entities/number_entity.dart';

void main() {
  group('NumberEntity', () {
    const id = 'mock-id';
    const numberOfDigits = 2;
    const value = 23;
    const mainWord = 'main-word';
    const data = {
      'number_of_digits': numberOfDigits,
      'value': value,
      'main_word': mainWord,
    };
    const numberEntity = NumberEntity(
      id: id,
      numberOfDigits: numberOfDigits,
      value: value,
      mainWord: mainWord,
    );

    test('uses value equality', () {
      expect(
        numberEntity,
        const NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
          mainWord: mainWord,
        ),
      );

      expect(
        numberEntity,
        isNot(
          const NumberEntity(
            id: 'other-id',
            numberOfDigits: numberOfDigits,
            value: value,
            mainWord: mainWord,
          ),
        ),
      );

      expect(
        numberEntity,
        isNot(
          const NumberEntity(
            id: id,
            numberOfDigits: 3,
            value: value,
            mainWord: mainWord,
          ),
        ),
      );

      expect(
        numberEntity,
        isNot(
          const NumberEntity(
            id: id,
            numberOfDigits: numberOfDigits,
            value: 42,
            mainWord: mainWord,
          ),
        ),
      );

      expect(
        numberEntity,
        isNot(
          const NumberEntity(
            id: id,
            numberOfDigits: numberOfDigits,
            value: value,
            mainWord: 'other-main-word',
          ),
        ),
      );
    });

    test('from snapshot', () {
      expect(
        NumberEntity.fromSnapshot(
          id: id,
          data: data,
        ),
        numberEntity,
      );
    });

    test('get document data', () {
      expect(
        numberEntity.getDocumentData(),
        data,
      );
    });

    test('get update data', () {
      expect(
        NumberEntity.getUpdateData(
          numberOfDigits: () => 3,
          value: () => 42,
          mainWord: () => 'new-main-word',
        ),
        {
          'number_of_digits': 3,
          'value': 42,
          'main_word': 'new-main-word',
        },
      );
    });

    test('get partial update data', () {
      expect(
        NumberEntity.getUpdateData(
          numberOfDigits: () => numberOfDigits,
        ),
        {'number_of_digits': numberOfDigits},
      );

      expect(
        NumberEntity.getUpdateData(
          value: () => value,
        ),
        {'value': value},
      );

      expect(
        NumberEntity.getUpdateData(
          mainWord: () => mainWord,
        ),
        {'main_word': mainWord},
      );
    });
  });
}
