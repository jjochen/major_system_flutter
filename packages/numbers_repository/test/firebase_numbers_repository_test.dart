import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';
import 'package:numbers_repository/numbers_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
    if (call.method == 'Firebase#initializeCore') {
      return [
        {
          'name': defaultFirebaseAppName,
          'options': {
            'apiKey': '123',
            'appId': '123',
            'messagingSenderId': '123',
            'projectId': '123',
          },
          'pluginConstants': const <String, String>{},
        }
      ];
    }

    if (call.method == 'Firebase#initializeApp') {
      return <String, dynamic>{
        'name': call.arguments['appName'],
        'options': call.arguments['options'],
        'pluginConstants': const <String, String>{},
      };
    }

    return null;
  });

  TestWidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  const userId = 'mock-user-id';
  const id = 'mock-number-id';
  const numberOfDigits = 2;
  const value = 23;
  final number = Number(
    id: id,
    numberOfDigits: numberOfDigits,
    value: value,
  );

  group('FirebaseNumbersRepository', () {
    late FirebaseFirestore mockFirebaseFirestore;
    late DocumentReference mockUserReference;
    late CollectionReference mockNumberCollection;
    late NumbersRepository firebaseNumbersRepository;

    setUp(() {
      mockFirebaseFirestore = MockFirebaseFirestore();

      mockUserReference = MockDocumentReference();
      when(() => mockFirebaseFirestore.doc('/users/mock-user-id'))
          .thenReturn(mockUserReference);

      mockNumberCollection = MockCollectionReference();
      when(() => mockUserReference.collection('numbers'))
          .thenReturn(mockNumberCollection);

      firebaseNumbersRepository = FirebaseNumbersRepository(
        firestore: mockFirebaseFirestore,
      );
    });

    test('creates FirebaseFirestore instance internally when not injected', () {
      expect(() => FirebaseNumbersRepository(), isNot(throwsException));
    });

    group('without user ID', () {
      setUp(() {
        firebaseNumbersRepository.userId = null;
      });

      test('does not call add', () async {
        when(() => mockNumberCollection.add(any()))
            .thenAnswer((_) async => MockDocumentReference());
        await firebaseNumbersRepository.addNewNumber(number);
        verifyNever(() => mockNumberCollection.add(any()));
      });

      test('does not call delete', () async {
        final mockDocumentReference = MockDocumentReference();
        when(mockDocumentReference.delete).thenAnswer((_) async => null);
        when(() => mockNumberCollection.doc(id))
            .thenReturn(mockDocumentReference);
        await firebaseNumbersRepository.deleteNumber(number);
        verifyNever(() => mockDocumentReference.update(any()));
        (mockDocumentReference.delete);
      });

      test('does not call update', () async {
        final mockDocumentReference = MockDocumentReference();
        when(() => mockDocumentReference.update(any()))
            .thenAnswer((_) async => null);
        when(() => mockNumberCollection.doc(id))
            .thenReturn(mockDocumentReference);
        await firebaseNumbersRepository.updateNumber(number);
        verifyNever(() => mockDocumentReference.update(any()));
      });

      test('fetches empty stream of numbers', () async {
        var mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
        when(() => mockQueryDocumentSnapshot.id).thenReturn(id);
        when(() => mockQueryDocumentSnapshot.data()).thenReturn({
          'number_of_digits': numberOfDigits,
          'value': value,
        });
        var mockQuerySnapshot = MockQuerySnapshot();
        when(() => mockQuerySnapshot.docs)
            .thenReturn([mockQueryDocumentSnapshot]);
        when(() => mockNumberCollection.snapshots()).thenAnswer(
            (_) => Stream<QuerySnapshot>.fromIterable([mockQuerySnapshot]));

        await expectLater(firebaseNumbersRepository.numbers(), emitsDone);
      });
    });

    group('with user ID', () {
      setUp(() {
        firebaseNumbersRepository.userId = userId;
      });

      test('calls add', () async {
        when(() => mockNumberCollection.add(any()))
            .thenAnswer((_) async => MockDocumentReference());
        await firebaseNumbersRepository.addNewNumber(number);
        verify(() => mockNumberCollection.add({
              'number_of_digits': numberOfDigits,
              'value': value,
            })).called(1);
      });

      test('calls delete', () async {
        final mockDocumentReference = MockDocumentReference();
        when(mockDocumentReference.delete).thenAnswer((_) async => null);
        when(() => mockNumberCollection.doc(id))
            .thenReturn(mockDocumentReference);
        await firebaseNumbersRepository.deleteNumber(number);
        verify(mockDocumentReference.delete).called(1);
      });

      test('calls update', () async {
        final mockDocumentReference = MockDocumentReference();
        when(() => mockDocumentReference.update(any()))
            .thenAnswer((_) async => null);
        when(() => mockNumberCollection.doc(id))
            .thenReturn(mockDocumentReference);
        await firebaseNumbersRepository.updateNumber(number);
        verify(() => mockDocumentReference.update({
              'number_of_digits': numberOfDigits,
              'value': value,
            })).called(1);
      });

      test('fetches stream of numbers', () async {
        var mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
        when(() => mockQueryDocumentSnapshot.id).thenReturn(id);
        when(() => mockQueryDocumentSnapshot.data()).thenReturn({
          'number_of_digits': numberOfDigits,
          'value': value,
        });
        var mockQuerySnapshot = MockQuerySnapshot();
        when(() => mockQuerySnapshot.docs)
            .thenReturn([mockQueryDocumentSnapshot]);
        when(() => mockNumberCollection.snapshots()).thenAnswer(
            (_) => Stream<QuerySnapshot>.fromIterable([mockQuerySnapshot]));

        await expectLater(
            firebaseNumbersRepository.numbers(),
            emitsInOrder([
              [number]
            ]));
      });
    });
  });
}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockQuerySnapshot extends Mock implements QuerySnapshot {}

class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot {}

class MockDocumentReference extends Mock implements DocumentReference {}

class MockQuerySnapshotStream extends Mock implements Stream<QuerySnapshot> {}
