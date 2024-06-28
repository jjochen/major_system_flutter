// ignore_for_file: prefer_const_constructors, invalid_implementation_override

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:numbers_repository/numbers_repository.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  const id = 'mock-id';
  const numberOfDigits = 2;
  const value = 23;
  final number = Number(
    id: id,
    numberOfDigits: numberOfDigits,
    value: value,
  );

  group('FirebaseNumbersRepository', () {
    late FirebaseFirestore fakeFirebaseFirestore;
    late CollectionReference<Map<String, dynamic>> mockNumberCollection;
    late NumbersRepository firebaseNumbersRepository;

    setUp(() {
      fakeFirebaseFirestore = MockFirebaseFirestore();
      mockNumberCollection = MockCollectionReference();
      firebaseNumbersRepository = FirebaseNumbersRepository(
        firestore: fakeFirebaseFirestore,
      );
      when(() => fakeFirebaseFirestore.collection('numbers'))
          .thenReturn(mockNumberCollection);
    });

    // test('creates FirebaseFirestore instance internally when not injected',
    // () {
    //   expect(FirebaseNumbersRepository.new, isNot(throwsException));
    // });

    test('calls add', () async {
      when(() => mockNumberCollection.add(any()))
          .thenAnswer((_) async => MockDocumentReference());
      await firebaseNumbersRepository.addNewNumber(number);
      verify(
        () => mockNumberCollection.add({
          'number_of_digits': numberOfDigits,
          'value': value,
        }),
      ).called(1);
    });

    test('calls delete', () async {
      final mockDocumentReference = MockDocumentReference();
      when(mockDocumentReference.delete).thenAnswer((_) => Future.value());
      when(() => mockNumberCollection.doc(id))
          .thenReturn(mockDocumentReference);
      await firebaseNumbersRepository.deleteNumber(number);
      verify(mockDocumentReference.delete).called(1);
    });

    test('fetches stream of numbers', () async {
      final mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
      when(() => mockQueryDocumentSnapshot.id).thenReturn(id);
      when(mockQueryDocumentSnapshot.data).thenReturn({
        'number_of_digits': numberOfDigits,
        'value': value,
      });
      final mockQuerySnapshot = MockQuerySnapshot();
      when(() => mockQuerySnapshot.docs)
          .thenReturn([mockQueryDocumentSnapshot]);
      when(() => mockNumberCollection.snapshots()).thenAnswer(
        (_) => Stream<QuerySnapshot<Map<String, dynamic>>>.fromIterable(
          [mockQuerySnapshot],
        ),
      );

      await expectLater(
        firebaseNumbersRepository.numbers(),
        emitsInOrder([
          [number],
        ]),
      );
    });

    test('calls update', () async {
      final mockDocumentReference = MockDocumentReference();
      when(() => mockDocumentReference.update(any()))
          .thenAnswer((_) => Future.value());
      when(() => mockNumberCollection.doc(id))
          .thenReturn(mockDocumentReference);
      await firebaseNumbersRepository.updateNumber(number);
      verify(
        () => mockDocumentReference.update({
          'number_of_digits': numberOfDigits,
          'value': value,
        }),
      ).called(1);
    });
  });
}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockQuerySnapshotStream extends Mock
    implements Stream<QuerySnapshot<Map<String, dynamic>>> {}
