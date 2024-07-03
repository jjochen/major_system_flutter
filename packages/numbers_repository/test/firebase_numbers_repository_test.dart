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

  const userId = 'mock-user-id';
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
        userId: userId,
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
      final newNumber = number.copyWith(id: newId);
      final intermediateResult =
          await firebaseNumbersRepository.getNumber(newId);
      expect(
        intermediateResult,
        newNumber,
      );

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

    // test('does not call add', () async {
    //   when(() => mockNumberCollection.add(any()))
    //       .thenAnswer((_) async => MockDocumentReference());
    //   await firebaseNumbersRepository.addNewNumber(number);
    //   verifyNever(() => mockNumberCollection.add(any()));
    // });

    // test('does not call delete', () async {
    //   final mockDocumentReference = MockDocumentReference();
    //   when(mockDocumentReference.delete).thenAnswer((_) async => null);
    //   when(() => mockNumberCollection.doc(id))
    //       .thenReturn(mockDocumentReference);
    //   await firebaseNumbersRepository.deleteNumber(number);
    //   verifyNever(() => mockDocumentReference.update(any()));
    //   (mockDocumentReference.delete);
    // });

    // test('does not call update', () async {
    //   final mockDocumentReference = MockDocumentReference();
    //   when(() => mockDocumentReference.update(any()))
    //       .thenAnswer((_) async => null);
    //   when(() => mockNumberCollection.doc(id))
    //       .thenReturn(mockDocumentReference);
    //   await firebaseNumbersRepository.updateNumber(number);
    //   verifyNever(() => mockDocumentReference.update(any()));
    // });

    // test('fetches empty stream of numbers', () async {
    //   var mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
    //   when(() => mockQueryDocumentSnapshot.id).thenReturn(id);
    //   when(() => mockQueryDocumentSnapshot.data()).thenReturn({
    //     'number_of_digits': numberOfDigits,
    //     'value': value,
    //   });
    //   var mockQuerySnapshot = MockQuerySnapshot();
    //   when(() => mockQuerySnapshot.docs)
    //       .thenReturn([mockQueryDocumentSnapshot]);
    //   when(() => mockNumberCollection.snapshots()).thenAnswer(
    //       (_) => Stream<QuerySnapshot>.fromIterable([mockQuerySnapshot]));

    //   await expectLater(firebaseNumbersRepository.numbers(), emitsDone);
    // });

    // group('with user ID', () {
    //   setUp(() {
    //     firebaseNumbersRepository.userId = userId;
    //   });

    // test('calls add', () async {
    //   when(() => mockNumberCollection.add(any()))
    //       .thenAnswer((_) async => MockDocumentReference());
    //   await firebaseNumbersRepository.addNewNumber(number);
    //   verify(
    //     () => mockNumberCollection.add({
    //       'number_of_digits': numberOfDigits,
    //       'value': value,
    //     }),
    //   ).called(1);
    // });

    // test('calls delete', () async {
    //   final mockDocumentReference = MockDocumentReference();
    //   when(mockDocumentReference.delete).thenAnswer((_) async => null);
    //   when(() => mockNumberCollection.doc(id))
    //       .thenReturn(mockDocumentReference);
    //   await firebaseNumbersRepository.deleteNumber(number);
    //   verify(mockDocumentReference.delete).called(1);
    // });

    // test('calls update', () async {
    //   final mockDocumentReference = MockDocumentReference();
    //   when(() => mockDocumentReference.update(any()))
    //       .thenAnswer((_) async => null);
    //   when(() => mockNumberCollection.doc(id))
    //       .thenReturn(mockDocumentReference);
    //   await firebaseNumbersRepository.updateNumber(number);
    //   verify(
    //     () => mockDocumentReference.update({
    //       'number_of_digits': numberOfDigits,
    //       'value': value,
    //     }),
    //   ).called(1);
    // });

    // test('fetches stream of numbers', () async {
    //   final mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
    //   when(() => mockQueryDocumentSnapshot.id).thenReturn(id);
    //   when(mockQueryDocumentSnapshot.data).thenReturn({
    //     'number_of_digits': numberOfDigits,
    //     'value': value,
    //   });
    //   final mockQuerySnapshot = MockQuerySnapshot();
    //   when(() => mockQuerySnapshot.docs)
    //       .thenReturn([mockQueryDocumentSnapshot]);
    //   when(() => mockNumberCollection.snapshots()).thenAnswer(
    //     (_) => Stream<QuerySnapshot>.fromIterable([mockQuerySnapshot]),
    //   );

    //   await expectLater(
    //     firebaseNumbersRepository.numbers(),
    //     emitsInOrder([
    //       [number],
    //     ]),
    //   );
    // });
    // });
  });
}
