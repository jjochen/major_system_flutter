import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_repository/src/entities/entities.dart';

void main() {
  group('NumberEntity', () {
    const id = 'mock-id';
    const numberOfDigits = 2;
    const value = 23;
    const data = {
      'number_of_digits': numberOfDigits,
      'value': value,
    };
    const numberEntity = NumberEntity(
      id: id,
      numberOfDigits: numberOfDigits,
      value: value,
    );

    test('uses value equality', () {
      expect(
        numberEntity,
        const NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
      );
    });

    test('uses stringify', () {
      expect(
        numberEntity.toString(),
        'NumberEntity(mock-id, 2, 23)',
      );
    });

    test('from json', () {
      final json = {
        'id': id,
        'number_of_digits': numberOfDigits,
        'value': value,
      };
      expect(
        NumberEntity.fromJson(json),
        const NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
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

    test('to json', () {
      final json = {
        'id': id,
        'number_of_digits': numberOfDigits,
        'value': value,
      };
      expect(
        numberEntity.toJson(),
        json,
      );
    });

    test('to document', () {
      final document = {
        'number_of_digits': numberOfDigits,
        'value': value,
      };
      expect(
        const NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ).toDocument(),
        document,
      );
    });
  });
}
