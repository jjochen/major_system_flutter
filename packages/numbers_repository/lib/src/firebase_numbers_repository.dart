import 'dart:async';

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
  Stream<List<Number>> numbers() {
    return _numbersCollectionRef().snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final entity = NumberEntity.fromSnapshot(
          id: doc.id,
          data: doc.data(),
        );
        return Number.fromEntity(entity);
      }).toList();
    });
  }

  @override
  Future<Number?> getNumberWithId(String id) async {
    final snapshot = await _numbersCollectionRef().doc(id).get();
    return snapshot.exists
        ? Number.fromEntity(
            NumberEntity.fromSnapshot(
              id: snapshot.id,
              data: snapshot.data(),
            ),
          )
        : null;
  }

  @override
  Future<String> addNewNumber(Number number) async {
    final documentReference = await _numbersCollectionRef().add(
      number.toEntity().getDocumentData(),
    );
    return documentReference.id;
  }

  @override
  Future<void> deleteNumber(Number number) async {
    return _numberRef(number).delete();
  }

  @override
  Future<void> updateNumber(Number updatedNumber) {
    return _numberRef(updatedNumber).update(
      updatedNumber.toEntity().getDocumentData(),
    );
  }

  @override
  Future<String> addNewWord(Word word, {required Number number}) async {
    final documentReference = await _wordsCollectionRef(number).add(
      word.toEntity().getDocumentData(),
    );
    return documentReference.id;
  }

  @override
  Stream<List<Word>> words({required Number number}) {
    return _wordsCollectionRef(number).snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          final entity = WordEntity.fromSnapshot(
            id: doc.id,
            data: doc.data(),
          );
          return Word.fromEntity(entity);
        }).toList();
      },
    );
  }

  @override
  Future<void> deleteWord(Word word, {required Number number}) {
    return _wordRef(word, number: number).delete();
  }

  @override
  Future<Word> getWordWithId(String id, {required Number number}) async {
    final snapshot = await _wordsCollectionRef(number).doc(id).get();
    return Word.fromEntity(
      WordEntity.fromSnapshot(
        id: snapshot.id,
        data: snapshot.data(),
      ),
    );
  }

  @override
  Future<void> updateWord(Word word, {required Number number}) {
    return _wordRef(word, number: number).update(
      word.toEntity().getDocumentData(),
    );
  }

  CollectionReference<Map<String, dynamic>> _numbersCollectionRef() =>
      firestore.collection('users').doc(userId).collection('numbers');

  DocumentReference<Map<String, dynamic>> _numberRef(Number number) =>
      _numbersCollectionRef().doc(number.id);

  CollectionReference<Map<String, dynamic>> _wordsCollectionRef(
    Number number,
  ) =>
      _numbersCollectionRef().doc(number.id).collection('words');

  DocumentReference<Map<String, dynamic>> _wordRef(
    Word word, {
    required Number number,
  }) =>
      _wordsCollectionRef(number).doc(word.id);
}
