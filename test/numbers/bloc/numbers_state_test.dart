import 'package:major_system/numbers/bloc/numbers_bloc.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:test/test.dart';

void main() {
  group('NumbersState', () {
    const number = Number(id: 'id', numberOfDigits: 1, value: 1);

    group('NumbersLoading', () {
      test('should be a subclass of NumbersState', () {
        expect(const NumbersLoading(), isA<NumbersState>());
      });

      test('should support value equality', () {
        expect(
          const NumbersLoading(),
          equals(
            const NumbersLoading(),
          ),
        );
      });
    });

    group('NumbersLoaded', () {
      test('should be a subclass of NumbersState', () {
        expect(const NumbersLoaded([number]), isA<NumbersState>());
      });

      test('should support value equality', () {
        expect(
          const NumbersLoaded([number]),
          equals(const NumbersLoaded([number])),
        );

        expect(
          const NumbersLoaded([]),
          isNot(const NumbersLoaded([number])),
        );
      });
    });

    group('NumbersNotLoaded', () {
      test('should be a subclass of NumbersState', () {
        expect(const NumbersNotLoaded(), isA<NumbersState>());
      });

      test('should support value equality', () {
        expect(
          const NumbersNotLoaded(),
          equals(
            const NumbersNotLoaded(),
          ),
        );
      });
    });
  });
}
