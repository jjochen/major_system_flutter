import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_repository/src/entities/entities.dart';

void main() {
  group('UserEntity', () {
    const id = 'mock-id';
    const email = 'yo@test.com';
    const name = 'Darth Vader';
    const maxNumberOfDigits = 3;

    const snapshotData = {
      'email': email,
      'name': name,
      'max_number_of_digits': maxNumberOfDigits,
    };

    test('uses name equality', () {
      expect(
        const UserEntity(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: maxNumberOfDigits,
        ),
        const UserEntity(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: maxNumberOfDigits,
        ),
      );

      expect(
        const UserEntity(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: maxNumberOfDigits,
        ),
        isNot(
          const UserEntity(
            id: 'different-id',
            email: email,
            name: name,
            maxNumberOfDigits: maxNumberOfDigits,
          ),
        ),
      );

      expect(
        const UserEntity(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: maxNumberOfDigits,
        ),
        isNot(
          const UserEntity(
            id: id,
            email: 'different-email',
            name: name,
            maxNumberOfDigits: maxNumberOfDigits,
          ),
        ),
      );

      expect(
        const UserEntity(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: maxNumberOfDigits,
        ),
        isNot(
          const UserEntity(
            id: id,
            email: email,
            name: 'different-name',
            maxNumberOfDigits: maxNumberOfDigits,
          ),
        ),
      );

      expect(
        const UserEntity(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: maxNumberOfDigits,
        ),
        isNot(
          const UserEntity(
            id: id,
            email: email,
            name: name,
            maxNumberOfDigits: 4,
          ),
        ),
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
          maxNumberOfDigits: maxNumberOfDigits,
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
      expect(
        const UserEntity(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: maxNumberOfDigits,
        ).getDocumentData(),
        snapshotData,
      );
    });

    test('get update data', () {
      expect(
        UserEntity.getUpdateData(
          email: () => 'new-email',
          name: () => 'new-name',
          maxNumberOfDigits: () => 4,
        ),
        {
          'email': 'new-email',
          'name': 'new-name',
          'max_number_of_digits': 4,
        },
      );
    });
  });
}
