import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:numbers_repository/src/entities/entities.dart';

class FirebaseNumbersRepository implements NumbersRepository {
  const FirebaseNumbersRepository({
    required this.userId,
    required this.firestore,
  });

  final String userId;
  final FirebaseFirestore firestore;

  CollectionReference<Map<String, dynamic>> get _numbersCollection =>
      firestore.collection('users').doc(userId).collection('numbers');

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
    return _numbersCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final entity = NumberEntity.fromSnapshot(
          id: doc.id,
          data: doc.data(),
        );
        final words =
            doc.reference.collection('words').snapshots().map((snapshot) {
          return snapshot.docs.map((doc) {
            final entity = WordEntity.fromSnapshot(
              id: doc.id,
              data: doc.data(),
            );
            return Word.fromEntity(entity);
          }).toList();
        });
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
    return _numbersCollection.doc(id).delete();
  }

  @override
  Future<void> updateNumber(Number newNumber) {
    return _numbersCollection.doc(newNumber.id).update(
          newNumber.toEntity().toDocument(),
        );
  }
}
