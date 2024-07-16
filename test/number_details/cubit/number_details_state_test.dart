// ignore: lines_longer_than_80_chars
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_redundant_argument_values

import 'package:major_system/number_details/cubit/cubit.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:test/test.dart';

void main() {
  group('NumberDetailsState', () {
    const number1 = Number(
      id: 'id1',
      numberOfDigits: 1,
      value: 1,
      mainWord: 'one',
    );
    const number2 = Number(
      id: 'id2',
      numberOfDigits: 2,
      value: 2,
      mainWord: 'two',
    );

    const word1 = Word(
      id: 'id1',
      value: 'one',
      isMain: true,
    );

    const word2 = Word(
      id: 'id2',
      value: 'two',
      isMain: false,
    );

    group('value equality', () {
      test('should be supported', () {
        expect(
          NumberDetailsState(
            number: number1,
            words: [word1, word2],
          ),
          NumberDetailsState(
            number: number1,
            words: [word1, word2],
          ),
        );
      });

      test('should not be equal when number is different', () {
        expect(
          NumberDetailsState(
            number: number1,
            words: [word1, word2],
          ),
          isNot(
            NumberDetailsState(
              number: number2,
              words: [word1, word2],
            ),
          ),
        );
      });

      test('should not be equal when words are different', () {
        expect(
          NumberDetailsState(
            number: number1,
            words: [word1],
          ),
          isNot(
            NumberDetailsState(
              number: number1,
              words: [word2],
            ),
          ),
        );
      });
    });

    group('copyWith', () {
      test('should copy with new values', () {
        expect(
          NumberDetailsState(
            number: number1,
            words: [word1],
          ).copyWith(
            number: () => number2,
            words: () => [word2],
          ),
          NumberDetailsState(
            number: number2,
            words: [word2],
          ),
        );
      });

      test('should copy with existing values', () {
        expect(
          NumberDetailsState(
            number: number1,
            words: [word1],
          ).copyWith(),
          NumberDetailsState(
            number: number1,
            words: [word1],
          ),
        );
      });

      test('should copy with null values', () {
        expect(
          NumberDetailsState(
            number: number1,
            words: [word1],
          ).copyWith(
            number: () => null,
            words: () => [],
          ),
          NumberDetailsState(
            number: null,
            words: [],
          ),
        );
      });
    });
  });
}
