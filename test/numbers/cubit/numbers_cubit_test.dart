import 'package:bloc_test/bloc_test.dart';
import 'package:major_system/numbers/cubit/numbers_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:test/test.dart';

class MockNumbersRepository extends Mock implements NumbersRepository {}

void main() {
  const number = Number(
    id: 'id',
    numberOfDigits: 1,
    value: 1,
    mainWord: 'mainWord',
  );

  group('NumbersCubit', () {
    late NumbersRepository numbersRepository;
    NumbersCubit buildBloc() =>
        NumbersCubit(numbersRepository: numbersRepository);

    setUp(() {
      numbersRepository = MockNumbersRepository();
    });

    test('initial state should be NumbersState()', () {
      expect(
        buildBloc().state,
        equals(const NumbersState()),
      );
    });

    group('loadNumbers', () {
      blocTest<NumbersCubit, NumbersState>(
        'should load numbers from the repository',
        setUp: () {
          when(() => numbersRepository.watchNumbers()).thenAnswer(
            (_) => Stream.value([number]),
          );
          when(() => numbersRepository.watchMaxNumberOfDigits()).thenAnswer(
            (_) => Stream.value(2),
          );
          when(
            () => numbersRepository.addMissingNumbers(
              maxNumberOfDigits: any(named: 'maxNumberOfDigits'),
            ),
          ).thenAnswer((_) => Future<void>.value());
        },
        build: buildBloc,
        act: (cubit) => cubit.loadNumbers(),
        expect: () => const <NumbersState>[
          NumbersState(numbers: [number]),
        ],
        verify: (cubit) {
          verify(() => numbersRepository.watchNumbers()).called(1);
        },
      );
    });

    group('addNumber', () {
      blocTest<NumbersCubit, NumbersState>(
        'should add a number to the repository',
        setUp: () {
          when(() => numbersRepository.addNewNumber(number)).thenAnswer(
            (_) => Future<Number>.value(number),
          );
        },
        build: buildBloc,
        act: (cubit) => cubit.addNumber(number),
        expect: () => const <NumbersState>[],
        verify: (cubit) {
          verify(() => numbersRepository.addNewNumber(number)).called(1);
        },
      );
    });

    group('updateNumber', () {
      blocTest<NumbersCubit, NumbersState>(
        'should update a number in the repository',
        setUp: () {
          when(() => numbersRepository.updateNumber(number)).thenAnswer(
            (_) => Future<void>.value(),
          );
        },
        build: buildBloc,
        act: (cubit) => cubit.updateNumber(number),
        expect: () => const <NumbersState>[],
        verify: (cubit) {
          verify(() => numbersRepository.updateNumber(number)).called(1);
        },
      );
    });

    group('deleteNumber', () {
      blocTest<NumbersCubit, NumbersState>(
        'should delete a number from the repository',
        setUp: () {
          when(() => numbersRepository.deleteNumber(number)).thenAnswer(
            (_) => Future<void>.value(),
          );
        },
        build: buildBloc,
        act: (cubit) => cubit.deleteNumber(number),
        expect: () => const <NumbersState>[],
        verify: (bloc) {
          verify(() => numbersRepository.deleteNumber(number)).called(1);
        },
      );
    });

    group('numbersUpdated', () {
      blocTest<NumbersCubit, NumbersState>(
        'should emit NumbersLoaded when numbers are updated',
        build: buildBloc,
        act: (bloc) => bloc.numbersUpdated([number]),
        expect: () => const <NumbersState>[
          NumbersState(numbers: [number]),
        ],
      );
    });
  });
}
