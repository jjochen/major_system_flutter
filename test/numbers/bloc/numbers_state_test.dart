// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:major_system/numbers/bloc/numbers_bloc.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:test/test.dart';

void main() {
  group('NumbersState', () {
    const number = Number(id: 'id', numberOfDigits: 1, value: 1);

    group('NumbersLoading', () {
      test('should be a subclass of NumbersState', () {
        expect(NumbersLoading(), isA<NumbersState>());
      });

      test('should support value equality', () {
        expect(
          NumbersLoading(),
          equals(
            NumbersLoading(),
          ),
        );
      });
    });

    group('NumbersLoaded', () {
      test('should be a subclass of NumbersState', () {
        expect(NumbersLoaded([number]), isA<NumbersState>());
      });

      test('should support value equality', () {
        expect(
          NumbersLoaded([number]),
          equals(NumbersLoaded([number])),
        );

        expect(
          NumbersLoaded([]),
          isNot(NumbersLoaded([number])),
        );
      });
    });

    group('NumbersNotLoaded', () {
      test('should be a subclass of NumbersState', () {
        expect(NumbersNotLoaded(), isA<NumbersState>());
      });

      test('should support value equality', () {
        expect(
          NumbersNotLoaded(),
          equals(
            NumbersNotLoaded(),
          ),
        );
      });
    });
  });
}
