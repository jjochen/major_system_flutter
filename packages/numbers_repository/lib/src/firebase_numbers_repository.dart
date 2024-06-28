import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:numbers_repository/src/entities/entities.dart';

class FirebaseNumbersRepository implements NumbersRepository {
  FirebaseNumbersRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>>? _numberCollection;
  CollectionReference<Map<String, dynamic>> get numberCollection =>
      _numberCollection ??= _firestore.collection('numbers');

  @override
  Future<void> addNewNumber(Number number) {
    return numberCollection.add(number.toEntity().toDocument());
  }

  @override
  Future<void> deleteNumber(Number number) async {
    return numberCollection.doc(number.id).delete();
  }

  @override
  Stream<List<Number>> numbers() {
    return numberCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Number.fromEntity(NumberEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateNumber(Number update) {
    return numberCollection
        .doc(update.id)
        .update(update.toEntity().toDocument());
  }
}
