import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'entities/entities.dart';

class FirebaseNumbersRepository implements NumbersRepository {
  final numberCollection = FirebaseFirestore.instance.collection('numbers');

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
      return snapshot.docs.map((doc) => Number.fromEntity(NumberEntity.fromSnapshot(doc))).toList();
    });
  }

  @override
  Future<void> updateNumber(Number update) {
    return numberCollection.doc(update.id).update(update.toEntity().toDocument());
  }
}
