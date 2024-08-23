// ignore_for_file: prefer_const_constructors, invalid_implementation_override

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_repository/numbers_repository.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  const userId = 'mock-user-id';
  const numberOfDigits = 2;
  const value = 23;
  const mainWordValue = 'main-word';
  final number = Number.transient(
    numberOfDigits: numberOfDigits,
    value: value,
    mainWord: mainWordValue,
  );
  final word = Word.transient(
    value: 'word',
  );
  const mainWord = Word.transient(
    value: mainWordValue,
    isMain: true,
  );

  group('FirebaseNumbersRepository', () {
    late FirebaseFirestore fakeFirebaseFirestore;
    late NumbersRepository firebaseNumbersRepository;

    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      firebaseNumbersRepository = FirebaseNumbersRepository(
        userId: userId,
        firestore: fakeFirebaseFirestore,
      );
    });

    tearDown(() {
      fakeFirebaseFirestore.clearPersistence();
    });

    group('setMaxNumberOfDigits', () {
      test('sets max number of digits', () async {
        await firebaseNumbersRepository.setMaxNumberOfDigits(2);

        final result = await fakeFirebaseFirestore
            .collection('users')
            .doc(userId)
            .get()
            .then((snapshot) => snapshot.data());

        expect(result, {'max_number_of_digits': 2});
      });
    });

    group('watchMaxNumberOfDigits', () {
      test('emits max number of digits', () async {
        unawaited(
          expectLater(
            firebaseNumbersRepository.watchMaxNumberOfDigits(),
            emitsInOrder([
              0,
              2,
              5,
            ]),
          ),
        );

        await firebaseNumbersRepository.setMaxNumberOfDigits(2);
        await firebaseNumbersRepository.setMaxNumberOfDigits(5);
      });
    });

    group('watchNumbers', () {
      test('emits empty list initially', () async {
        expect(
          firebaseNumbersRepository.watchNumbers(),
          emits(<Number>[]),
        );
      });

      test('emits updated list of numbers', () async {
        final newNumber = await firebaseNumbersRepository.addNewNumber(number);
        final updatedNumber = newNumber.copyWith(value: () => 42);

        unawaited(
          expectLater(
            firebaseNumbersRepository.watchNumbers(),
            emitsInOrder([
              [newNumber],
              [updatedNumber],
              <Number>[],
            ]),
          ),
        );

        await firebaseNumbersRepository.updateNumber(updatedNumber);
        await firebaseNumbersRepository.deleteNumber(newNumber);
      });

      test('emits numbers in correct order', () async {
        unawaited(
          expectLater(
            firebaseNumbersRepository.watchNumbers().map((numbers) {
              return numbers.map((number) => number.toString()).toList();
            }),
            emitsInOrder([
              <String>[],
              ['001'],
              ['2', '001'],
              ['2', '4', '001'],
            ]),
          ),
        );

        await firebaseNumbersRepository.addNewNumber(
          Number.transient(numberOfDigits: 3, value: 1),
        );
        await firebaseNumbersRepository.addNewNumber(
          Number.transient(numberOfDigits: 1, value: 2),
        );
        await firebaseNumbersRepository.addNewNumber(
          Number.transient(numberOfDigits: 1, value: 4),
        );
      });
    });

    group('watchNumber', () {
      test('emits number', () async {
        final newNumber = await firebaseNumbersRepository.addNewNumber(number);

        expect(
          firebaseNumbersRepository.watchNumber(newNumber),
          emits(newNumber),
        );
      });

      test('emits updated number when number is changed', () async {
        final newNumber = await firebaseNumbersRepository.addNewNumber(number);
        final updatedNumber = newNumber.copyWith(value: () => 100);

        expect(
          firebaseNumbersRepository.watchNumber(newNumber),
          emitsInOrder([
            newNumber,
            updatedNumber,
          ]),
        );

        await firebaseNumbersRepository.updateNumber(updatedNumber);
      });

      test('emits null when number is deleted', () async {
        final newNumber = await firebaseNumbersRepository.addNewNumber(number);

        expect(
          firebaseNumbersRepository.watchNumber(newNumber),
          emitsInOrder([
            newNumber,
            null,
          ]),
        );

        await firebaseNumbersRepository.deleteNumber(newNumber);
      });
    });

    group('hasNumber', () {
      test('returns true when number exists', () async {
        await firebaseNumbersRepository.addNewNumber(number);

        final result = await firebaseNumbersRepository.hasNumber(number);
        expect(result, isTrue);
      });

      test('returns false when number does not exist', () async {
        final result = await firebaseNumbersRepository.hasNumber(number);
        expect(result, isFalse);
      });
    });

    group('getNumberWithId', () {
      test('returns correct number', () async {
        final newNumber = await firebaseNumbersRepository.addNewNumber(number);
        expect(
          newNumber,
          number.copyWith(id: () => newNumber.id),
        );
      });

      test('returns null when no number is found', () async {
        final result =
            await firebaseNumbersRepository.getNumberWithId('non-existing-id');
        expect(result, isNull);
      });
    });

    group('addMissingNumbers', () {
      test('adds missing numbers up to 2 digits', () async {
        await firebaseNumbersRepository.addMissingNumbers(
          maxNumberOfDigits: 2,
        );

        final result = await firebaseNumbersRepository.watchNumbers().first;
        expect(result, hasLength(110));
      });

      test('does not overwrite existing numbers', () async {
        final newNumber = await firebaseNumbersRepository.addNewNumber(number);

        await firebaseNumbersRepository.addMissingNumbers(
          maxNumberOfDigits: 2,
        );

        final result = await firebaseNumbersRepository.watchNumbers().first;
        expect(result, contains(newNumber));
        expect(result, hasLength(110));
      });
    });

    group('deleteNumber', () {
      test('removes number', () async {
        final newNumber = await firebaseNumbersRepository.addNewNumber(number);
        await firebaseNumbersRepository.deleteNumber(newNumber);
        final result =
            await firebaseNumbersRepository.getNumberWithId(newNumber.id);
        expect(result, isNull);
      });
    });

    group('updateNumber', () {
      test('updates number', () async {
        final newNumber = await firebaseNumbersRepository.addNewNumber(number);
        final updatedNumber = newNumber.copyWith(
          value: () => 42,
        );

        await firebaseNumbersRepository.updateNumber(updatedNumber);

        final result =
            await firebaseNumbersRepository.getNumberWithId(newNumber.id);
        expect(result, updatedNumber);
      });
    });

    group('addWord', () {
      test('adds word for given number', () async {
        final newNumber = await firebaseNumbersRepository.addNewNumber(number);
        final newWord =
            await firebaseNumbersRepository.addNewWord(word, number: newNumber);
        final result = await firebaseNumbersRepository.getWordWithId(
          newWord.id,
          number: newNumber,
        );

        expect(result, newWord);
      });
    });

    group('getWordWithId', () {
      test('gets word for a given number', () async {
        final newNumber = await firebaseNumbersRepository.addNewNumber(number);
        final newWord =
            await firebaseNumbersRepository.addNewWord(word, number: newNumber);
        final wordId = newWord.id;
        final result = await firebaseNumbersRepository.getWordWithId(
          wordId,
          number: newNumber,
        );

        expect(result, newWord);
      });

      test('returns null when no word is found', () async {
        final newNumber = await firebaseNumbersRepository.addNewNumber(number);
        final result = await firebaseNumbersRepository.getWordWithId(
          'non-existing-id',
          number: newNumber,
        );

        expect(result, isNull);
      });
    });

    group('deleteWord', () {
      test('deletes word for given number', () async {
        final newNumber = await firebaseNumbersRepository.addNewNumber(number);

        final newWord =
            await firebaseNumbersRepository.addNewWord(word, number: newNumber);
        final wordId = newWord.id;
        await firebaseNumbersRepository.deleteWord(newWord, number: newNumber);
        final result = await firebaseNumbersRepository.getWordWithId(
          wordId,
          number: newNumber,
        );

        expect(result, isNull);
      });
    });

    group('updateWord', () {
      test('updates word for given number', () async {
        final newNumber = await firebaseNumbersRepository.addNewNumber(number);
        final newWord =
            await firebaseNumbersRepository.addNewWord(word, number: newNumber);
        final wordId = newWord.id;
        final updatedWord = newWord.copyWith(value: () => 'updated-word');

        await firebaseNumbersRepository.updateWord(
          updatedWord,
          number: newNumber,
        );

        final result = await firebaseNumbersRepository.getWordWithId(
          wordId,
          number: newNumber,
        );

        expect(result, updatedWord);
      });
    });

    group('setWordAsMain', () {
      test('sets word as main for given number', () async {
        final newNumber = await firebaseNumbersRepository.addNewNumber(number);
        final newWord =
            await firebaseNumbersRepository.addNewWord(word, number: newNumber);
        final wordId = newWord.id;

        await firebaseNumbersRepository.setWordAsMain(
          newWord,
          number: newNumber,
        );

        final result = await firebaseNumbersRepository.getWordWithId(
          wordId,
          number: newNumber,
        );

        expect(result, newWord.copyWith(isMain: () => true));
      });
    });

    group('watchWords', () {
      test('words has empty stream initially', () async {
        expect(
          firebaseNumbersRepository.watchWords(number: number),
          emits(<Number>[]),
        );
      });

      test('words stream emits updated list of words for a given number',
          () async {
        final newNumber = await firebaseNumbersRepository.addNewNumber(number);
        final newWord =
            await firebaseNumbersRepository.addNewWord(word, number: newNumber);
        final updatedWord = newWord.copyWith(value: () => 'updated-word');

        unawaited(
          expectLater(
            firebaseNumbersRepository.watchWords(number: newNumber),
            emitsInOrder(<List<Word>>[
              [newWord],
              [updatedWord],
              [updatedWord.copyWith(isMain: () => true)],
              [],
            ]),
          ),
        );

        await firebaseNumbersRepository.updateWord(
          updatedWord,
          number: newNumber,
        );
        await firebaseNumbersRepository.setWordAsMain(
          updatedWord,
          number: newNumber,
        );
        await firebaseNumbersRepository.deleteWord(
          newWord,
          number: newNumber,
        );
      });
    });

    group('setNewWordAsMain', () {
      test('sets new word as main', () async {
        final newNumber = await firebaseNumbersRepository.addNewNumber(number);
        final newWord =
            await firebaseNumbersRepository.addNewWord(word, number: newNumber);
        final newWordId = newWord.id;

        final newMainWord = await firebaseNumbersRepository.addNewWord(
          mainWord,
          number: newNumber,
        );
        final mainWordId = newMainWord.id;

        await firebaseNumbersRepository.setWordAsMain(
          newWord,
          number: newNumber,
        );

        final result =
            await firebaseNumbersRepository.getNumberWithId(newNumber.id);
        expect(result, newNumber.copyWith(mainWord: () => newWord.value));

        final mainWordResult = await firebaseNumbersRepository.getWordWithId(
          mainWordId,
          number: newNumber,
        );
        expect(mainWordResult, newMainWord.copyWith(isMain: () => false));

        final newWordResult = await firebaseNumbersRepository.getWordWithId(
          newWordId,
          number: newNumber,
        );
        expect(newWordResult, newWord.copyWith(isMain: () => true));
      });
    });
  });
}
