import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:numbers_repository/src/entities/entities.dart';

void main() {
  group('User', () {
    const id = 'mock-id';
    const email = 'mock@mock.io';
    const name = 'Mock That';
    const maxNumberOfDigits = 3;

    test('uses name equality', () {
      expect(
        const User(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: maxNumberOfDigits,
        ),
        const User(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: maxNumberOfDigits,
        ),
      );

      expect(
        const User(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: maxNumberOfDigits,
        ),
        isNot(
          const User(
            id: 'different-id',
            email: email,
            name: name,
            maxNumberOfDigits: maxNumberOfDigits,
          ),
        ),
      );

      expect(
        const User(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: maxNumberOfDigits,
        ),
        isNot(
          const User(
            id: id,
            email: 'different-email',
            name: name,
            maxNumberOfDigits: maxNumberOfDigits,
          ),
        ),
      );

      expect(
        const User(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: maxNumberOfDigits,
        ),
        isNot(
          const User(
            id: id,
            email: email,
            name: 'different-name',
            maxNumberOfDigits: maxNumberOfDigits,
          ),
        ),
      );

      expect(
        const User(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: maxNumberOfDigits,
        ),
        isNot(
          const User(
            id: id,
            email: email,
            name: name,
            maxNumberOfDigits: 4,
          ),
        ),
      );
    });

    test('copies with new id', () {
      const newId = 'new-id';
      expect(
        const User(
          id: id,
          email: email,
          name: name,
        ).copyWith(id: () => newId),
        const User(
          id: newId,
          email: email,
          name: name,
        ),
      );
    });

    test('copies with new email', () {
      const newEmail = 'yo@yo.yo';
      expect(
        const User(
          id: id,
          email: email,
          name: name,
        ).copyWith(email: () => newEmail),
        const User(
          id: id,
          email: newEmail,
          name: name,
        ),
      );
    });

    test('copies with null email', () {
      expect(
        const User(
          id: id,
          email: email,
          name: name,
        ).copyWith(email: () => null),
        const User(
          id: id,
          name: name,
        ),
      );
    });

    test('copies with new name', () {
      const newName = 'Name That';
      expect(
        const User(
          id: id,
          email: email,
          name: name,
        ).copyWith(name: () => newName),
        const User(
          id: id,
          email: email,
          name: newName,
        ),
      );
    });

    test('copies with null name', () {
      expect(
        const User(
          id: id,
          email: email,
          name: name,
        ).copyWith(name: () => null),
        const User(
          id: id,
          email: email,
        ),
      );
    });

    test('copies with new maxNumberOfDigits', () {
      const newMaxNumberOfDigits = 4;
      expect(
        const User(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: maxNumberOfDigits,
        ).copyWith(maxNumberOfDigits: () => newMaxNumberOfDigits),
        const User(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: newMaxNumberOfDigits,
        ),
      );
    });

    test('model to entity', () {
      expect(
        const User(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: maxNumberOfDigits,
        ).toEntity(),
        const UserEntity(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: maxNumberOfDigits,
        ),
      );
    });

    test('model from entity', () {
      expect(
        User.fromEntity(
          const UserEntity(
            id: id,
            email: email,
            name: name,
            maxNumberOfDigits: maxNumberOfDigits,
          ),
        ),
        const User(
          id: id,
          email: email,
          name: name,
          maxNumberOfDigits: maxNumberOfDigits,
        ),
      );
    });
  });
}
