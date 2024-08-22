import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:numbers_repository/src/entities/entities.dart';

class FirebaseNumbersRepository implements NumbersRepository {
  const FirebaseNumbersRepository({
    required this.userId, // TODO(jjochen): Move userId to method arguments?
    required this.firestore,
  });

  final String userId;
  final FirebaseFirestore firestore;

  @override
  Future<void> setMaxNumberOfDigits(int maxNumberOfDigits) {
    return _userRef().set(
      UserEntity.getUpdateData(
        maxNumberOfDigits: () => maxNumberOfDigits,
      ),
      SetOptions(merge: true),
    );
  }

  @override
  Stream<int> watchMaxNumberOfDigits() {
    return _userRef().snapshots().map(
          (snapshot) => snapshot.toUser().maxNumberOfDigits,
        );
  }

  @override
  Stream<List<Number>> watchNumbers() {
    return _numbersCollectionRef().snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.toNumber()).toList(),
        );
  }

  @override
  Stream<Number?> watchNumber(Number number) {
    return _numberRef(number).snapshots().map(
          (snapshot) => snapshot.toNumberOrNull(),
        );
  }

  @override
  Future<bool> hasNumber(Number number) async {
    final snapshot = await _numbersCollectionRef()
        .where('number_of_digits', isEqualTo: number.numberOfDigits)
        .where('value', isEqualTo: number.value)
        .limit(1)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  @override
  Future<Number?> getNumberWithId(String id) async {
    final snapshot = await _numbersCollectionRef().doc(id).get();
    return snapshot.toNumberOrNull();
  }

  @override
  Future<String> addNewNumber(Number number) async {
    final documentReference = await _numbersCollectionRef().add(
      number.toEntity().getDocumentData(),
    );
    return documentReference.id;
  }

  @override
  Future<void> addMissingNumbers({required int maxNumberOfDigits}) async {
    final batch = firestore.batch();
    for (var numberOfDigits = 1;
        numberOfDigits <= maxNumberOfDigits;
        numberOfDigits++) {
      for (var value = 0; value < pow(10, numberOfDigits); value++) {
        final number = Number.transient(
          numberOfDigits: numberOfDigits,
          value: value,
        );

        final exists = await hasNumber(number);
        if (!exists) {
          batch.set(
            _numbersCollectionRef().doc(),
            number.toEntity().getDocumentData(),
          );
        }
      }
    }
    return batch.commit();
  }

  @override
  Future<void> updateNumber(Number updatedNumber) {
    return _numberRef(updatedNumber).update(
      updatedNumber.toEntity().getDocumentData(),
    );
  }

  @override
  Future<void> deleteNumber(Number number) async {
    return _numberRef(number).delete();
  }

  @override
  Stream<List<Word>> watchWords({required Number number}) {
    return _wordsCollectionRef(number).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.toWord()).toList(),
        );
  }

  @override
  Future<Word?> getWordWithId(String id, {required Number number}) async {
    final snapshot = await _wordsCollectionRef(number).doc(id).get();
    return snapshot.toWordOrNull();
  }

  @override
  Future<String> addNewWord(Word word, {required Number number}) async {
    final documentReference = await _wordsCollectionRef(number).add(
      word.toEntity().getDocumentData(),
    );
    return documentReference.id;
  }

  @override
  Future<void> updateWord(Word word, {required Number number}) {
    return _wordRef(word, number: number).update(
      word.toEntity().getDocumentData(),
    );
  }

  @override
  Future<void> setWordAsMain(Word? word, {required Number number}) async {
    final wordsSnapshot = await _wordsCollectionRef(number).get();
    final wordsDocs = wordsSnapshot.docs;

    final batch = firestore.batch();
    for (final doc in wordsDocs) {
      final newIsMainFlag = word != null && doc.id == word.id;
      final newData = WordEntity.getUpdateData(
        isMain: () => newIsMainFlag,
      );
      batch.update(doc.reference, newData);
    }
    await batch.commit();

    await updateNumber(number.copyWith(mainWord: () => word?.value));
  }

  @override
  Future<void> deleteWord(Word word, {required Number number}) {
    return _wordRef(word, number: number).delete();
  }

  DocumentReference<Map<String, dynamic>> _userRef() =>
      firestore.collection('users').doc(userId);

  CollectionReference<Map<String, dynamic>> _numbersCollectionRef() =>
      _userRef().collection('numbers');

  DocumentReference<Map<String, dynamic>> _numberRef(Number number) =>
      _numbersCollectionRef().doc(number.id);

  CollectionReference<Map<String, dynamic>> _wordsCollectionRef(
    Number number,
  ) =>
      _numberRef(number).collection('words');

  DocumentReference<Map<String, dynamic>> _wordRef(
    Word word, {
    required Number number,
  }) =>
      _wordsCollectionRef(number).doc(word.id);
}

extension _SnapshotConverter on DocumentSnapshot<Map<String, dynamic>> {
  User toUser() {
    final entity = UserEntity.fromSnapshot(
      id: id,
      data: data(),
    );
    return User.fromEntity(entity);
  }

  Number toNumber() {
    final entity = NumberEntity.fromSnapshot(
      id: id,
      data: data(),
    );
    return Number.fromEntity(entity);
  }

  Number? toNumberOrNull() {
    if (!exists) return null;
    return toNumber();
  }

  Word toWord() {
    final entity = WordEntity.fromSnapshot(
      id: id,
      data: data(),
    );
    return Word.fromEntity(entity);
  }

  Word? toWordOrNull() {
    if (!exists) return null;
    return toWord();
  }
}
