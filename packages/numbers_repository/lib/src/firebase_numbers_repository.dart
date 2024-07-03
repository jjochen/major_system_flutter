import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:numbers_repository/src/entities/entities.dart';
import 'package:path/path.dart' as path;

class FirebaseNumbersRepository implements NumbersRepository {
  FirebaseNumbersRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore? _firestore;
  FirebaseFirestore _getFirestore() => _firestore ?? FirebaseFirestore.instance;

  String? _userId;

  @override
  String? get userId => _userId;

  @override
  set userId(String? userId) {
    if (userId != _userId) {
      _userId = userId;
      configureFirestoreReferences();
      // TODO(jjochen): create user if doesn't exist
    }
  }

  DocumentReference? _userDocument;
  CollectionReference? _numberCollection;
  void configureFirestoreReferences() {
    _userDocument = userId == null
        ? null
        : _getFirestore().doc(path.join('/', 'users', userId));
    _numberCollection =
        userId == null ? null : _userDocument?.collection('numbers');
  }

  CollectionReference<Map<String, dynamic>> get _numbersCollection =>
      _getFirestore().collection('numbers');

  @override
  Future<Number?> getNumber(String id) async {
    final snapshot = await _numbersCollection.doc(id).get();
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
  Stream<List<Number>> numbers() {
    final numberCollection = _numberCollection;
    if (numberCollection == null) {
      return const Stream.empty();
    }

    return _numbersCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final entity = NumberEntity.fromSnapshot(id: doc.id, data: doc.data());
        return Number.fromEntity(entity);
      }).toList();
    });
  }

  @override
  Future<String> addNewNumber(Number number) async {
    final documentReference = await _numbersCollection.add(
      number.toEntity().toDocument(),
    );
    return documentReference.id;
  }

  @override
  Future<void> deleteNumber(String id) async {
    final numberCollection = _numberCollection;
    if (numberCollection == null) {
      return Future.value();
    }

    return _numbersCollection.doc(id).delete();
  }

  @override
  Future<void> updateNumber(Number update) {
    final numberCollection = _numberCollection;
    if (numberCollection == null) {
      return Future.value();
    }

    return numberCollection
        .doc(update.id)
        .update(update.toEntity().toDocument());
  }
}
