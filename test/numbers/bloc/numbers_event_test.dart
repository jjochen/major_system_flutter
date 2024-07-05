import 'package:major_system/numbers/bloc/numbers_bloc.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:test/test.dart';

void main() {
  group('NumbersEvent', () {
    const number1 = Number(id: 'id', numberOfDigits: 1, value: 1);
    const number2 = Number(id: 'id', numberOfDigits: 1, value: 2);

    group('LoadNumbers', () {
      test('should be a subclass of NumbersEvent', () {
        expect(const LoadNumbers(), isA<NumbersEvent>());
      });

      test('should support value equality', () {
        expect(
          const LoadNumbers(),
          equals(
            const LoadNumbers(),
          ),
        );
      });
    });

    group('AddNumber', () {
      test('should be a subclass of NumbersEvent', () {
        expect(const AddNumber(number1), isA<NumbersEvent>());
      });

      test('should support value equality', () {
        expect(
          const AddNumber(number1),
          equals(
            const AddNumber(number1),
          ),
        );

        expect(
          const AddNumber(number1),
          isNot(const AddNumber(number2)),
        );
      });
    });

    group('UpdateNumber', () {
      test('should be a subclass of NumbersEvent', () {
        expect(const UpdateNumber(number1), isA<NumbersEvent>());
      });

      test('should support value equality', () {
        expect(
          const UpdateNumber(number1),
          equals(
            const UpdateNumber(number1),
          ),
        );

        expect(
          const UpdateNumber(number1),
          isNot(const UpdateNumber(number2)),
        );
      });
    });

    group('DeleteNumber', () {
      test('should be a subclass of NumbersEvent', () {
        expect(const DeleteNumber(number1), isA<NumbersEvent>());
      });

      test('should support value equality', () {
        expect(
          const DeleteNumber(number1),
          equals(
            const DeleteNumber(number1),
          ),
        );

        expect(
          const DeleteNumber(number1),
          isNot(const DeleteNumber(number2)),
        );
      });
    });

    group('NumbersUpdated', () {
      test('should be a subclass of NumbersEvent', () {
        expect(const NumbersUpdated([number1]), isA<NumbersEvent>());
      });

      test('should support value equality', () {
        expect(
          const NumbersUpdated([number1]),
          equals(
            const NumbersUpdated([number1]),
          ),
        );

        expect(
          const NumbersUpdated([number1]),
          isNot(const NumbersUpdated([number2])),
        );
      });
    });
  });
}
