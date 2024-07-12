import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_repository/src/entities/entities.dart';

void main() {
  group('UserEntity', () {
    const id = 'mock-id';
    const email = 'yo@test.com';
    const name = 'Darth Vader';
    const snapshotData = {
      'email': email,
      'name': name,
    };

    test('uses name equality', () {
      expect(
        const UserEntity(
          id: id,
          email: email,
          name: name,
        ),
        const UserEntity(
          id: id,
          email: email,
          name: name,
        ),
      );
    });

    test('uses stringify', () {
      expect(
        const UserEntity(
          id: id,
          email: email,
          name: name,
        ).toString(),
        'UserEntity(mock-id, yo@test.com, Darth Vader)',
      );
    });

    test('from snapshot', () {
      expect(
        UserEntity.fromSnapshot(
          id: id,
          data: snapshotData,
        ),
        const UserEntity(
          id: id,
          email: email,
          name: name,
        ),
      );
    });

    test('from document without data', () {
      expect(
        UserEntity.fromSnapshot(
          id: id,
          data: null,
        ),
        const UserEntity(
          id: id,
        ),
      );
    });

    test('get document data', () {
      final document = {
        'email': email,
        'name': name,
      };
      expect(
        const UserEntity(
          id: id,
          email: email,
          name: name,
        ).getDocumentData(),
        document,
      );
    });
  });
}
