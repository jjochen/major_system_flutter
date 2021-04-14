import 'package:numbers_repository/src/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('UserEntity', () {
    const id = 'mock-id';
    const email = 'yo@test.com';
    const name = 'Darth Vader';

    test('uses name equality', () {
      expect(
        UserEntity(
          id: id,
          email: email,
          name: name,
        ),
        UserEntity(
          id: id,
          email: email,
          name: name,
        ),
      );
    });

    test('uses stringify', () {
      expect(
        UserEntity(
          id: id,
          email: email,
          name: name,
        ).toString(),
        'UserEntity(mock-id, yo@test.com, Darth Vader)',
      );
    });

    test('from json', () {
      final json = {
        'id': id,
        'email': email,
        'name': name,
      };
      expect(
        UserEntity.fromJson(json),
        UserEntity(
          id: id,
          email: email,
          name: name,
        ),
      );
    });

    test('to json', () {
      final json = {
        'id': id,
        'email': email,
        'name': name,
      };
      expect(
        UserEntity(
          id: id,
          email: email,
          name: name,
        ).toJson(),
        json,
      );
    });

    test('from document', () {
      final snapshotData = {
        'email': email,
        'name': name,
      };
      final snap = MockDocumentSnapshot();
      when(() => snap.id).thenReturn(id);
      when(snap.data).thenReturn(snapshotData);
      expect(
          UserEntity.fromSnapshot(snap),
          UserEntity(
            id: id,
            email: email,
            name: name,
          ));
    });

    test('from document without data', () {
      final snap = MockDocumentSnapshot();
      when(() => snap.id).thenReturn(id);
      when(snap.data).thenReturn(null);
      expect(
          UserEntity.fromSnapshot(snap),
          UserEntity(
            id: id,
            email: null,
            name: null,
          ));
    });

    test('to document', () {
      final document = {
        'email': email,
        'name': name,
      };
      expect(
        UserEntity(
          id: id,
          email: email,
          name: name,
        ).toDocument(),
        document,
      );
    });
  });
}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}
