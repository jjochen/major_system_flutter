// ignore_for_file: prefer_const_constructors, invalid_implementation_override

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_repository/numbers_repository.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  const numberOfDigits = 2;
  const value = 23;
  final number = Number(
    id: '',
    numberOfDigits: numberOfDigits,
    value: value,
  );

  group('FirebaseNumbersRepository', () {
    late FirebaseFirestore fakeFirebaseFirestore;
    late NumbersRepository firebaseNumbersRepository;

    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      firebaseNumbersRepository = FirebaseNumbersRepository(
        firestore: fakeFirebaseFirestore,
      );
    });

    test('getNumber returns correct number', () async {
      final newId = await firebaseNumbersRepository.addNewNumber(number);
      final result = await firebaseNumbersRepository.getNumber(newId);
      expect(
        result,
        number.copyWith(id: newId),
      );
    });

    test('deleteNumber removes number', () async {
      final newId = await firebaseNumbersRepository.addNewNumber(number);
      await firebaseNumbersRepository.deleteNumber(newId);
      final result = await firebaseNumbersRepository.getNumber(newId);
      expect(result, isNull);
    });

    test('updateNumber updates number', () async {
      final newId = await firebaseNumbersRepository.addNewNumber(number);
      final updatedNumber = number.copyWith(
        id: newId,
        value: 42,
      );
      await firebaseNumbersRepository.updateNumber(updatedNumber);
      final result = await firebaseNumbersRepository.getNumber(newId);
      expect(result, updatedNumber);
    });

    test('has empty stream initially', () async {
      expect(
        firebaseNumbersRepository.numbers(),
        emits(<Number>[]),
      );
    });

    test('stream emitts updated list of numbers', () async {
      final newId = await firebaseNumbersRepository.addNewNumber(number);
      final newNumber = number.copyWith(id: newId);
      final updatedNumber = newNumber.copyWith(value: 43);

      unawaited(
        expectLater(
          firebaseNumbersRepository.numbers(),
          emitsInOrder([
            [newNumber],
            [updatedNumber],
            <Number>[],
          ]),
        ),
      );

      await firebaseNumbersRepository.updateNumber(updatedNumber);
      await firebaseNumbersRepository.deleteNumber(newId);
    });
  });
}
