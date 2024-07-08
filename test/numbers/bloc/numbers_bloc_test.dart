import 'package:bloc_test/bloc_test.dart';
import 'package:major_system/numbers/bloc/numbers_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:test/test.dart';

class MockNumbersRepository extends Mock implements NumbersRepository {}

void main() {
  const number = Number(id: 'id', numberOfDigits: 1, value: 1);

  group('NumbersBloc', () {
    late NumbersRepository numbersRepository;
    NumbersBloc buildBloc() =>
        NumbersBloc(numbersRepository: numbersRepository);

    setUp(() {
      numbersRepository = MockNumbersRepository();
    });

    test('initial state should be NumbersLoading', () {
      expect(
        buildBloc().state,
        equals(const NumbersLoading()),
      );
    });

    group('LoadNumbers', () {
      blocTest<NumbersBloc, NumbersState>(
        'should load numbers from the repository',
        setUp: () {
          when(() => numbersRepository.numbers()).thenAnswer(
            (_) => Stream.value([number]),
          );
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const LoadNumbers()),
        expect: () => const <NumbersState>[
          NumbersLoaded([number]),
        ],
        verify: (bloc) {
          verify(() => numbersRepository.numbers()).called(1);
        },
      );
    });

    group('AddNumber', () {
      blocTest<NumbersBloc, NumbersState>(
        'should add a number to the repository',
        setUp: () {
          when(() => numbersRepository.addNewNumber(number)).thenAnswer(
            (_) => Future<String>.value('new_id'),
          );
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const AddNumber(number)),
        expect: () => const <NumbersState>[],
        verify: (bloc) {
          verify(() => numbersRepository.addNewNumber(number)).called(1);
        },
      );
    });

    group('UpdateNumber', () {
      blocTest<NumbersBloc, NumbersState>(
        'should update a number in the repository',
        setUp: () {
          when(() => numbersRepository.updateNumber(number)).thenAnswer(
            (_) => Future<void>.value(),
          );
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const UpdateNumber(number)),
        expect: () => const <NumbersState>[],
        verify: (bloc) {
          verify(() => numbersRepository.updateNumber(number)).called(1);
        },
      );
    });

    group('DeleteNumber', () {
      blocTest<NumbersBloc, NumbersState>(
        'should delete a number from the repository',
        setUp: () {
          when(() => numbersRepository.deleteNumber(number.id)).thenAnswer(
            (_) => Future<void>.value(),
          );
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const DeleteNumber(number)),
        expect: () => const <NumbersState>[],
        verify: (bloc) {
          verify(() => numbersRepository.deleteNumber(number.id)).called(1);
        },
      );
    });

    group('NumbersUpdated', () {
      blocTest<NumbersBloc, NumbersState>(
        'should emit NumbersLoaded when numbers are updated',
        build: buildBloc,
        act: (bloc) => bloc.add(const NumbersUpdated([number])),
        expect: () => const <NumbersState>[
          NumbersLoaded([number]),
        ],
      );
    });
  });
}
