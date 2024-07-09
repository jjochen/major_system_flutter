// ignore: lines_longer_than_80_chars
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_redundant_argument_values

import 'package:major_system/numbers/bloc/numbers_bloc.dart';
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
          loading: true,
          selectedNumber: number1,
        ),
        NumbersState(
          numbers: [number1, number2],
          loading: true,
          selectedNumber: number1,
        ),
      );
    });

    test('should not be equal when numbers are different', () {
      expect(
        NumbersState(
          numbers: [number1],
          loading: true,
          selectedNumber: number1,
        ),
        isNot(
          NumbersState(
            numbers: [number2],
            loading: true,
            selectedNumber: number1,
          ),
        ),
      );
    });

    test('should not be equal when loading is different', () {
      expect(
        NumbersState(
          numbers: [number1, number2],
          loading: true,
          selectedNumber: number1,
        ),
        isNot(
          NumbersState(
            numbers: [number1, number2],
            loading: false,
            selectedNumber: number1,
          ),
        ),
      );
    });

    test('should not be equal when selectedNumber is different', () {
      expect(
        NumbersState(
          numbers: [number1, number2],
          loading: true,
          selectedNumber: number1,
        ),
        isNot(
          NumbersState(
            numbers: [number1, number2],
            loading: true,
            selectedNumber: number2,
          ),
        ),
      );
    });
  });
}
