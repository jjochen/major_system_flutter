import 'package:numbers_repository/src/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'number_entity_test.mocks.dart';

@GenerateMocks([
  DocumentSnapshot,
])
void main() {
  group('NumberEntity', () {
    const id = 'mock-id';
    const numberOfDigits = 2;
    const value = 23;

    test('uses value equality', () {
      expect(
        NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
        NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
      );
    });

    test('uses stringify', () {
      expect(
        NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ).toString(),
        'NumberEntity(mock-id, 2, 23)',
      );
    });

    test('from json', () {
      final json = {
        'id': id,
        'number_of_digits': numberOfDigits,
        'value': value,
      };
      expect(
        NumberEntity.fromJson(json),
        NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ),
      );
    });

    test('to json', () {
      final json = {
        'id': id,
        'number_of_digits': numberOfDigits,
        'value': value,
      };
      expect(
        NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ).toJson(),
        json,
      );
    });

    test('from document', () {
      final snapshotData = {
        'number_of_digits': numberOfDigits,
        'value': value,
      };
      final snap = MockDocumentSnapshot();
      when(snap.id).thenReturn(id);
      when(snap.data()).thenReturn(snapshotData);
      expect(
          NumberEntity.fromSnapshot(snap),
          NumberEntity(
            id: id,
            numberOfDigits: numberOfDigits,
            value: value,
          ));
    });

    test('from document without data', () {
      final snap = MockDocumentSnapshot();
      when(snap.id).thenReturn(id);
      when(snap.data()).thenReturn(null);
      expect(
          NumberEntity.fromSnapshot(snap),
          NumberEntity(
            id: id,
            numberOfDigits: 0,
            value: 0,
          ));
    });

    test('to document', () {
      final document = {
        'number_of_digits': numberOfDigits,
        'value': value,
      };
      expect(
        NumberEntity(
          id: id,
          numberOfDigits: numberOfDigits,
          value: value,
        ).toDocument(),
        document,
      );
    });
  });
}
