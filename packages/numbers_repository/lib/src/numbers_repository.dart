import 'dart:async';

import 'package:numbers_repository/numbers_repository.dart';

abstract class NumbersRepository {
  Future<String> addNewNumber(Number number);

  Stream<List<Number>> numbers();

  Future<Number?> getNumberWithId(String id);

  Future<void> deleteNumber(Number number);

  Future<void> updateNumber(Number number);

  Future<String> addNewWord(Word word, {required Number number});

  Stream<List<Word>> words({required Number number});

  Future<Word?> getWordWithId(String id, {required Number number});

  Future<void> deleteWord(Word word, {required Number number});

  Future<void> updateWord(Word word, {required Number number});

  Future<void> setWordAsMain(Word? word, {required Number number});
}
