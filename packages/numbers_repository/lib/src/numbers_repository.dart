import 'dart:async';

import 'package:numbers_repository/numbers_repository.dart';

abstract class NumbersRepository {
  Future<void> setMaxNumberOfDigits(int maxNumberOfDigits);

  Stream<int> watchMaxNumberOfDigits();

  Stream<List<Number>> watchNumbers({required int maxNumberOfDigits});

  Stream<Number?> watchNumber(Number number);

  Future<Number?> getNumberWithId(String id);

  Future<Number> addNewNumber(Number number);

  Future<bool> hasNumber(Number number);

  Future<void> addMissingNumbers({required int maxNumberOfDigits});

  Future<void> updateNumber(Number number);

  Future<void> deleteNumber(Number number);

  Stream<List<Word>> watchWords({required Number number});

  Future<Word?> getWordWithId(String id, {required Number number});

  Future<Word> addNewWord(Word word, {required Number number});

  Future<void> updateWord(Word word, {required Number number});

  Future<void> setWordAsMain(Word? word, {required Number number});

  Future<void> deleteWord(Word word, {required Number number});
}
