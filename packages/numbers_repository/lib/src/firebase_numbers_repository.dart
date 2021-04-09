import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:path/path.dart' as path;

import 'entities/entities.dart';

class FirebaseNumbersRepository implements NumbersRepository {
  FirebaseNumbersRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;
  String? _userId;

  @override
  String? get userId => _userId;

  @override
  set userId(String? userId) {
    if (userId != _userId) {
      _userId = userId;
      configureFirestoreReferences();
    }
  }

  DocumentReference? _userDocument;
  CollectionReference? _numberCollection;
  void configureFirestoreReferences() {
    _userDocument =
        userId == null ? null : _firestore.doc(path.join('/', 'users', userId));
    _numberCollection =
        userId == null ? null : _userDocument?.collection('numbers');
  }

  @override
  Future<void> addNewNumber(Number number) {
    final numberCollection = _numberCollection;
    if (numberCollection == null) {
      return Future.value(null);
    }

    return numberCollection.add(number.toEntity().toDocument());
  }

  @override
  Future<void> deleteNumber(Number number) async {
    final numberCollection = _numberCollection;
    if (numberCollection == null) {
      return Future.value(null);
    }

    return numberCollection.doc(number.id).delete();
  }

  @override
  Future<void> updateNumber(Number update) {
    final numberCollection = _numberCollection;
    if (numberCollection == null) {
      return Future.value(null);
    }

    return numberCollection
        .doc(update.id)
        .update(update.toEntity().toDocument());
  }

  @override
  Stream<List<Number>> numbers() {
    final numberCollection = _numberCollection;
    if (numberCollection == null) {
      return const Stream.empty();
    }

    return numberCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Number.fromEntity(NumberEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
