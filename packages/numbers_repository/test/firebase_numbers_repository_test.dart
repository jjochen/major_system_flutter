import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'firebase_numbers_repository_test.mocks.dart';

//class _FakeDocumentReference extends Fake implements DocumentReference {}

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  QuerySnapshot,
  DocumentReference,
])
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

  const id = 'mock-id';
  const numberOfDigits = 2;
  const value = 23;
  final number = Number(
    id: id,
    numberOfDigits: numberOfDigits,
    value: value,
  );

  group('FirebaseNumbersRepository', () {
    // variables need initial value (null safety)
    var mockFirebaseFirestore = MockFirebaseFirestore();
    var mockNumberCollection = MockCollectionReference();
    var firebaseNumbersRepository = FirebaseNumbersRepository(
      firestore: mockFirebaseFirestore,
    );

    setUp(() {
      mockFirebaseFirestore = MockFirebaseFirestore();
      mockNumberCollection = MockCollectionReference();
      firebaseNumbersRepository = FirebaseNumbersRepository(
        firestore: mockFirebaseFirestore,
      );
      when(mockFirebaseFirestore.collection('numbers')).thenReturn(mockNumberCollection);
    });

    test('creates FirebaseFirestore instance internally when not injected', () {
      expect(() => FirebaseNumbersRepository(), isNot(throwsException));
    });

    test('calls add', () async {
      when(mockNumberCollection.add(any)).thenAnswer((_) async => MockDocumentReference());
      await firebaseNumbersRepository.addNewNumber(number);
      verify(mockNumberCollection.add({
        'number_of_digits': numberOfDigits,
        'value': value,
      })).called(1);
    });

    test('calls delete', () async {
      final mockDocumentReference = MockDocumentReference();
      when(mockNumberCollection.doc(id)).thenReturn(mockDocumentReference);
      await firebaseNumbersRepository.deleteNumber(number);
      verify(mockDocumentReference.delete()).called(1);
    });

    test('calls update', () async {
      final mockDocumentReference = MockDocumentReference();
      when(mockNumberCollection.doc(id)).thenReturn(mockDocumentReference);
      await firebaseNumbersRepository.updateNumber(number);
      verify(mockDocumentReference.update({
        'number_of_digits': numberOfDigits,
        'value': value,
      })).called(1);
    });
  });
}
