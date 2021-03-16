import 'package:numbers_repository/src/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NumberEntity', () {
    const id = 'mock-id';
    const numberOfDigits = 2;
    const value = 23;

    test('uses value equality', () {
      expect(
        NumberEntity(id, numberOfDigits, value),
        NumberEntity(id, numberOfDigits, value),
      );
    });

    test('uses stringify', () {
      expect(
        NumberEntity(id, numberOfDigits, value).toString(),
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
        NumberEntity(id, numberOfDigits, value),
      );
    });

    test('to json', () {
      final json = {
        'id': id,
        'number_of_digits': numberOfDigits,
        'value': value,
      };
      expect(
        NumberEntity(id, numberOfDigits, value).toJson(),
        json,
      );
    });
  });
}
