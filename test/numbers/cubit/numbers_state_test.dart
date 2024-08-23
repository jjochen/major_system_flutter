// ignore: lines_longer_than_80_chars
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_redundant_argument_values

import 'package:major_system/numbers/cubit/numbers_cubit.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:test/test.dart';

void main() {
  group('NumbersState', () {
    const number1 = Number(id: 'id', numberOfDigits: 1, value: 1);
    const number2 = Number(id: 'id', numberOfDigits: 1, value: 2);

    test('should support value equality', () {
      expect(
        NumbersState(
          numbers: [number1, number2],
          maxNumberOfDigits: 2,
          loading: true,
        ),
        NumbersState(
          numbers: [number1, number2],
          maxNumberOfDigits: 2,
          loading: true,
        ),
      );
    });

    test('should not be equal when numbers are different', () {
      expect(
        NumbersState(
          numbers: [number1],
          maxNumberOfDigits: 2,
          loading: true,
        ),
        isNot(
          NumbersState(
            numbers: [number2],
            maxNumberOfDigits: 2,
            loading: true,
          ),
        ),
      );
    });

    test('should not be equal when loading is different', () {
      expect(
        NumbersState(
          numbers: [number1, number2],
          maxNumberOfDigits: 2,
          loading: true,
        ),
        isNot(
          NumbersState(
            numbers: [number1, number2],
            maxNumberOfDigits: 2,
            loading: false,
          ),
        ),
      );
    });

    test('should not be equal when maxNumberOfDigits is different', () {
      expect(
        NumbersState(
          numbers: [number1, number2],
          maxNumberOfDigits: 2,
          loading: true,
        ),
        isNot(
          NumbersState(
            numbers: [number1, number2],
            maxNumberOfDigits: 3,
            loading: true,
          ),
        ),
      );
    });

    group('copyWith', () {
      test('should copy with new values', () {
        expect(
          NumbersState(
            numbers: [number1],
            maxNumberOfDigits: 2,
            loading: true,
          ).copyWith(
            numbers: () => [number2],
            maxNumberOfDigits: () => 3,
            loading: () => false,
          ),
          NumbersState(
            numbers: [number2],
            maxNumberOfDigits: 3,
            loading: false,
          ),
        );
      });

      test('should copy with same values', () {
        expect(
          NumbersState(
            numbers: [number1],
            maxNumberOfDigits: 2,
            loading: true,
          ).copyWith(),
          NumbersState(
            numbers: [number1],
            maxNumberOfDigits: 2,
            loading: true,
          ),
        );
      });
    });
  });
}
