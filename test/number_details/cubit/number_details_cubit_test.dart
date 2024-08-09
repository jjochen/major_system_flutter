import 'package:bloc_test/bloc_test.dart';
import 'package:major_system/number_details/cubit/cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:test/test.dart';

import '../../mocks/number_repository_mocks.dart';

void main() {
  setUpAll(() async {
    registerFallbackValue(number1);
    registerFallbackValue(word1);
  });

  group('NumberDetailsCubit', () {
    late NumbersRepository numbersRepository;
    NumberDetailsCubit buildCubit() =>
        NumberDetailsCubit(numbersRepository: numbersRepository);

    setUp(() {
      numbersRepository = MockNumbersRepository();
    });

    test('initial state should be NumberDetailsState()', () {
      expect(
        buildCubit().state,
        equals(const NumberDetailsState()),
      );
    });

    group('selectNumber', () {
      blocTest<NumberDetailsCubit, NumberDetailsState>(
        'should load numbers from the repository',
        build: buildCubit,
        seed: () =>
            const NumberDetailsState(number: number2, words: [word1, word2]),
        act: (cubit) => cubit.selectNumber(number1),
        expect: () => const <NumberDetailsState>[
          NumberDetailsState(number: number1),
        ],
        verify: (bloc) {
          verify(() => numbersRepository.watchNumber(number1)).called(1);
          verify(() => numbersRepository.watchWords(number: number1)).called(1);
        },
      );
    });

    group('numberUpdated', () {
      final updatedNumber = number1.copyWith(mainWord: () => 'new');
      blocTest<NumberDetailsCubit, NumberDetailsState>(
        'should update the number in the state',
        build: buildCubit,
        seed: () =>
            const NumberDetailsState(number: number1, words: [word1, word2]),
        act: (cubit) => cubit.numberUpdated(updatedNumber),
        expect: () => <NumberDetailsState>[
          NumberDetailsState(
            number: updatedNumber,
            words: const [word1, word2],
          ),
        ],
      );
    });

    group('wordsUpdated', () {
      blocTest<NumberDetailsCubit, NumberDetailsState>(
        'should update the words in the state',
        build: buildCubit,
        seed: () => const NumberDetailsState(number: number1, words: [word1]),
        act: (cubit) => cubit.wordsUpdated([word1, word2]),
        expect: () => <NumberDetailsState>[
          const NumberDetailsState(
            number: number1,
            words: [word1, word2],
          ),
        ],
      );
    });

    group('selectMainWord', () {
      blocTest<NumberDetailsCubit, NumberDetailsState>(
        'should set the word as the main word',
        build: buildCubit,
        seed: () =>
            const NumberDetailsState(number: number1, words: [word1, word2]),
        act: (cubit) => cubit.selectMainWord(word2),
        expect: () => const <NumberDetailsState>[],
        verify: (bloc) {
          verify(() => numbersRepository.setWordAsMain(word2, number: number1))
              .called(1);
        },
      );

      blocTest<NumberDetailsCubit, NumberDetailsState>(
        'should not set the word as the main word when number is null',
        build: buildCubit,
        seed: () => const NumberDetailsState(),
        act: (cubit) => cubit.selectMainWord(word2),
        expect: () => const <NumberDetailsState>[],
        verify: (bloc) {
          verifyNever(
            () => numbersRepository.setWordAsMain(
              word2,
              number: any(named: 'number'),
            ),
          );
        },
      );
    });

    group('addWord', () {
      const value = 'new word';

      blocTest<NumberDetailsCubit, NumberDetailsState>(
        'should add the word to the repository',
        build: buildCubit,
        seed: () =>
            const NumberDetailsState(number: number1, words: [word1, word2]),
        act: (cubit) => cubit.addWord(value),
        expect: () => const <NumberDetailsState>[],
        verify: (bloc) {
          verify(
            () => numbersRepository.addNewWord(
              const Word(id: '', value: value),
              number: number1,
            ),
          ).called(1);
        },
      );

      blocTest<NumberDetailsCubit, NumberDetailsState>(
        'should not add the word to the repository when value is empty',
        build: buildCubit,
        seed: () =>
            const NumberDetailsState(number: number1, words: [word1, word2]),
        act: (cubit) => cubit.addWord(''),
        expect: () => const <NumberDetailsState>[],
        verify: (bloc) {
          verifyNever(
            () => numbersRepository.addNewWord(
              any(),
              number: any(named: 'number'),
            ),
          );
        },
      );

      blocTest<NumberDetailsCubit, NumberDetailsState>(
        'should not add the word to the repository when number is null',
        build: buildCubit,
        seed: () => const NumberDetailsState(),
        act: (cubit) => cubit.addWord(value),
        expect: () => const <NumberDetailsState>[],
        verify: (bloc) {
          verifyNever(
            () => numbersRepository.addNewWord(
              any(),
              number: any(named: 'number'),
            ),
          );
        },
      );
    });
  });
}
