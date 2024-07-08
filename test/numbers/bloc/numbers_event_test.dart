// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:major_system/numbers/bloc/numbers_bloc.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:test/test.dart';

void main() {
  group('NumbersEvent', () {
    const number1 = Number(id: 'id', numberOfDigits: 1, value: 1);
    const number2 = Number(id: 'id', numberOfDigits: 1, value: 2);

    group('LoadNumbers', () {
      test('should be a subclass of NumbersEvent', () {
        expect(LoadNumbers(), isA<NumbersEvent>());
      });

      test('should support value equality', () {
        expect(
          LoadNumbers(),
          LoadNumbers(),
        );
      });
    });

    group('AddNumber', () {
      test('should be a subclass of NumbersEvent', () {
        expect(AddNumber(number1), isA<NumbersEvent>());
      });

      test('should support value equality', () {
        expect(
          AddNumber(number1),
          AddNumber(number1),
        );

        expect(
          AddNumber(number1),
          isNot(AddNumber(number2)),
        );
      });
    });

    group('UpdateNumber', () {
      test('should be a subclass of NumbersEvent', () {
        expect(UpdateNumber(number1), isA<NumbersEvent>());
      });

      test('should support value equality', () {
        expect(
          UpdateNumber(number1),
          UpdateNumber(number1),
        );

        expect(
          UpdateNumber(number1),
          isNot(UpdateNumber(number2)),
        );
      });
    });

    group('DeleteNumber', () {
      test('should be a subclass of NumbersEvent', () {
        expect(DeleteNumber(number1), isA<NumbersEvent>());
      });

      test('should support value equality', () {
        expect(
          DeleteNumber(number1),
          DeleteNumber(number1),
        );

        expect(
          DeleteNumber(number1),
          isNot(DeleteNumber(number2)),
        );
      });
    });

    group('NumbersUpdated', () {
      test('should be a subclass of NumbersEvent', () {
        expect(NumbersUpdated([number1]), isA<NumbersEvent>());
      });

      test('should support value equality', () {
        expect(
          NumbersUpdated([number1]),
          NumbersUpdated([number1]),
        );

        expect(
          NumbersUpdated([number1]),
          isNot(NumbersUpdated([number2])),
        );
      });
    });
  });
}
