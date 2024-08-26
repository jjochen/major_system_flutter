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
      when(
        () => numbersRepository.addMissingNumbers(
          maxNumberOfDigits: any(named: 'maxNumberOfDigits'),
        ),
      ).thenAnswer((_) => Future<void>.value());
      when(() => numbersRepository.watchMaxNumberOfDigits()).thenAnswer(
        (_) => const Stream.empty(),
      );
      when(
        () => numbersRepository.watchNumbers(
          maxNumberOfDigits: any(named: 'maxNumberOfDigits'),
        ),
      ).thenAnswer(
        (_) => const Stream.empty(),
      );
    });

    test('initial state should be NumbersState()', () {
      expect(
        buildBloc().state,
        equals(const NumbersState()),
      );
    });

    group('initialize', () {
      blocTest<NumbersCubit, NumbersState>(
        'should initialize the cubit',
        build: buildBloc,
        act: (cubit) => cubit.initialize(),
        expect: () => const <NumbersState>[],
        verify: (cubit) {
          verify(() => numbersRepository.watchMaxNumberOfDigits()).called(1);
        },
      );
    });

    group('reloadNumbers', () {
      blocTest<NumbersCubit, NumbersState>(
        'should load numbers from the repository',
        setUp: () {
          when(
            () => numbersRepository.watchNumbers(
              maxNumberOfDigits: any(named: 'maxNumberOfDigits'),
            ),
          ).thenAnswer(
            (_) => Stream.value([number]),
          );
        },
        seed: () => const NumbersState(maxNumberOfDigits: 2),
        build: buildBloc,
        act: (cubit) => cubit.reloadNumbers(),
        expect: () => const <NumbersState>[
          NumbersState(numbers: [number], maxNumberOfDigits: 2),
        ],
        verify: (cubit) {
          verify(() => numbersRepository.watchNumbers(maxNumberOfDigits: 2))
              .called(1);
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

    group('maxNumberOfDigitsUpdated', () {
      blocTest<NumbersCubit, NumbersState>(
        'should emit NumbersLoaded when maxNumberOfDigits is updated',
        build: buildBloc,
        seed: () => const NumbersState(maxNumberOfDigits: 3),
        act: (bloc) => bloc.maxNumberOfDigitsUpdated(2),
        expect: () => const <NumbersState>[
          NumbersState(maxNumberOfDigits: 2),
        ],
      );

      blocTest<NumbersCubit, NumbersState>(
        'should reload numbers when maxNumberOfDigits is updated',
        setUp: () {
          when(
            () => numbersRepository.watchNumbers(
              maxNumberOfDigits: any(named: 'maxNumberOfDigits'),
            ),
          ).thenAnswer(
            (_) => Stream.value([number]),
          );
        },
        build: buildBloc,
        seed: () => const NumbersState(maxNumberOfDigits: 3),
        act: (bloc) => bloc.maxNumberOfDigitsUpdated(2),
        expect: () => const <NumbersState>[
          NumbersState(maxNumberOfDigits: 2),
          NumbersState(maxNumberOfDigits: 2, numbers: [number]),
        ],
        verify: (bloc) {
          verify(() => numbersRepository.watchNumbers(maxNumberOfDigits: 2))
              .called(1);
        },
      );
    });
  });
}
