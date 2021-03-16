import 'package:numbers_repository/src/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NumberEntity', () {
    const id = 'mock-id';
    const numberOfDigits = 2;
    const value = 23;

    test('uses value equality', () {
      expect(
        NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
        NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
      );
    });

    test('uses stringify', () {
      expect(
        NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ).toString(),
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
        NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
      );
    });

    test('to json', () {
      final json = {
        'id': id,
        'number_of_digits': numberOfDigits,
        'value': value,
      };
      expect(
        NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ).toJson(),
        json,
      );
    });

    test('to document', () {
      final document = {
        'number_of_digits': numberOfDigits,
        'value': value,
      };
      expect(
        NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ).toDocument(),
        document,
      );
    });
  });
}
