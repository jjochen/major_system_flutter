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
  final number = Number(
    id: '',
    numberOfDigits: numberOfDigits,
    value: value,
    mainWord: mainWordValue,
  );
  final word = Word(
    id: '',
    value: 'word',
  );
  const mainWord = Word(
    id: '',
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

    test('getNumber returns correct number', () async {
      final newId = await firebaseNumbersRepository.addNewNumber(number);
      final result = await firebaseNumbersRepository.getNumberWithId(newId);
      expect(
        result,
        number.copyWith(id: () => newId),
      );
    });

    test('getNumberWithId returns null when no number is found', () async {
      final result =
          await firebaseNumbersRepository.getNumberWithId('non-existing-id');
      expect(result, isNull);
    });

    test('deleteNumber removes number', () async {
      final newId = await firebaseNumbersRepository.addNewNumber(number);
      final newNumber = number.copyWith(id: () => newId);
      final intermediateResult =
          await firebaseNumbersRepository.getNumberWithId(newId);
      expect(
        intermediateResult,
        newNumber,
      );

      await firebaseNumbersRepository.deleteNumber(newNumber);
      final result = await firebaseNumbersRepository.getNumberWithId(newId);
      expect(result, isNull);
    });

    test('updateNumber updates number', () async {
      final newId = await firebaseNumbersRepository.addNewNumber(number);
      final updatedNumber = number.copyWith(
        id: () => newId,
        value: () => 42,
      );

      await firebaseNumbersRepository.updateNumber(updatedNumber);

      final result = await firebaseNumbersRepository.getNumberWithId(newId);
      expect(result, updatedNumber);
    });

    test('has empty stream initially', () async {
      expect(
        firebaseNumbersRepository.numbers(),
        emits(<Number>[]),
      );
    });

    test('stream emits updated list of numbers', () async {
      final newId = await firebaseNumbersRepository.addNewNumber(number);
      final newNumber = number.copyWith(id: () => newId);
      final updatedNumber = newNumber.copyWith(value: () => 43);

      unawaited(
        expectLater(
          firebaseNumbersRepository.numbers(),
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

    test('adds word for given number', () async {
      final numberId = await firebaseNumbersRepository.addNewNumber(number);
      final newNumber = number.copyWith(id: () => numberId);

      final wordId =
          await firebaseNumbersRepository.addNewWord(word, number: newNumber);
      final newWord = word.copyWith(id: () => wordId);
      final result = await firebaseNumbersRepository.getWordWithId(
        wordId,
        number: newNumber,
      );

      expect(result, newWord);
    });

    test('gets word for a given number', () async {
      final numberId = await firebaseNumbersRepository.addNewNumber(number);
      final newNumber = number.copyWith(id: () => numberId);

      final wordId =
          await firebaseNumbersRepository.addNewWord(word, number: newNumber);
      final newWord = word.copyWith(id: () => wordId);
      final result = await firebaseNumbersRepository.getWordWithId(
        wordId,
        number: newNumber,
      );

      expect(result, newWord);
    });

    test('getWordWithId returns null when no word is found', () async {
      final numberId = await firebaseNumbersRepository.addNewNumber(number);
      final newNumber = number.copyWith(id: () => numberId);

      final result = await firebaseNumbersRepository.getWordWithId(
        'non-existing-id',
        number: newNumber,
      );

      expect(result, isNull);
    });

    test('deletes word for given number', () async {
      final numberId = await firebaseNumbersRepository.addNewNumber(number);
      final newNumber = number.copyWith(id: () => numberId);

      final wordId =
          await firebaseNumbersRepository.addNewWord(word, number: newNumber);
      final newWord = word.copyWith(id: () => wordId);
      final intermediateResult = await firebaseNumbersRepository.getWordWithId(
        wordId,
        number: newNumber,
      );
      expect(intermediateResult, newWord);

      await firebaseNumbersRepository.deleteWord(newWord, number: newNumber);
      final result = await firebaseNumbersRepository.getWordWithId(
        wordId,
        number: newNumber,
      );

      expect(result, isNull);
    });

    test('updates word for given number', () async {
      final numberId = await firebaseNumbersRepository.addNewNumber(number);
      final newNumber = number.copyWith(id: () => numberId);

      final wordId =
          await firebaseNumbersRepository.addNewWord(word, number: newNumber);
      final newWord = word.copyWith(id: () => wordId);
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

    test('sets word as main for given number', () async {
      final numberId = await firebaseNumbersRepository.addNewNumber(number);
      final newNumber = number.copyWith(id: () => numberId);

      final wordId =
          await firebaseNumbersRepository.addNewWord(word, number: newNumber);
      final newWord = word.copyWith(id: () => wordId);

      await firebaseNumbersRepository.setWordAsMain(newWord, number: newNumber);

      final result = await firebaseNumbersRepository.getWordWithId(
        wordId,
        number: newNumber,
      );

      expect(result, newWord.copyWith(isMain: () => true));
    });

    test('words has empty stream initially', () async {
      expect(
        firebaseNumbersRepository.words(number: number),
        emits(<Number>[]),
      );
    });

    test('words stream emits updated list of words for a given number',
        () async {
      final newId = await firebaseNumbersRepository.addNewNumber(number);
      final newNumber = number.copyWith(id: () => newId);
      final newWordId =
          await firebaseNumbersRepository.addNewWord(word, number: newNumber);
      final newWord = word.copyWith(id: () => newWordId);
      final updatedWord = newWord.copyWith(value: () => 'updated-word');

      unawaited(
        expectLater(
          firebaseNumbersRepository.words(number: newNumber),
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

    test('sets new word as main', () async {
      final numberId = await firebaseNumbersRepository.addNewNumber(number);
      final newNumber = number.copyWith(id: () => numberId);
      final newWordId =
          await firebaseNumbersRepository.addNewWord(word, number: newNumber);
      final newWord = word.copyWith(id: () => newWordId);
      final mainWordId = await firebaseNumbersRepository.addNewWord(
        mainWord,
        number: newNumber,
      );
      final newMainWord = mainWord.copyWith(id: () => mainWordId);

      await firebaseNumbersRepository.setWordAsMain(newWord, number: newNumber);

      final result = await firebaseNumbersRepository.getNumberWithId(numberId);
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
}
