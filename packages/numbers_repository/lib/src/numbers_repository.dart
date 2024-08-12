import 'dart:async';

import 'package:numbers_repository/numbers_repository.dart';

abstract class NumbersRepository {
  Stream<List<Number>> watchNumbers();

  Stream<Number?> watchNumber(Number number);

  Future<Number?> getNumberWithId(String id);

  Future<String> addNewNumber(Number number);

  Future<bool> hasNumber(Number number);

  Future<void> addMissingNumbers({required int maximumNumberOfDigits});

  Future<void> updateNumber(Number number);

  Future<void> deleteNumber(Number number);

  Stream<List<Word>> watchWords({required Number number});

  Future<Word?> getWordWithId(String id, {required Number number});

  Future<String> addNewWord(Word word, {required Number number});

  Future<void> updateWord(Word word, {required Number number});

  Future<void> setWordAsMain(Word? word, {required Number number});

  Future<void> deleteWord(Word word, {required Number number});
}
