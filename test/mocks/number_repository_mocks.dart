import 'package:mocktail/mocktail.dart';
import 'package:numbers_repository/numbers_repository.dart';

const mainNumber = Number(
  id: 'main-id',
  numberOfDigits: 2,
  value: 42,
  mainWord: 'Ronja',
);
const number1 = Number(id: 'id-1', numberOfDigits: 1, value: 1);
const number2 = Number(id: 'id-2', numberOfDigits: 1, value: 2);
const numbers = [number1, number2];

const word1 = Word(id: 'id-1', value: 'one', isMain: true);
const word2 = Word(id: 'id-2', value: 'two');

class MockNumbersRepository extends Mock implements NumbersRepository {
  MockNumbersRepository() {
    when(watchNumbers).thenAnswer(
      (_) => const Stream.empty(),
    );
    when(() => watchNumber(any())).thenAnswer(
      (_) => const Stream.empty(),
    );
    when(
      () => watchWords(number: any(named: 'number')),
    ).thenAnswer(
      (_) => const Stream.empty(),
    );
    when(
      () => setWordAsMain(any(), number: any(named: 'number')),
    ).thenAnswer(
      (_) => Future.value(),
    );
    when(
      () => addNewWord(any(), number: any(named: 'number')),
    ).thenAnswer(
      (_) => Future.value('1'),
    );
  }
}
