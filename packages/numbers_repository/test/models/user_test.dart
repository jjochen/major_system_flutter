import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:numbers_repository/src/entities/entities.dart';

void main() {
  group('User', () {
    const id = 'mock-id';
    const email = 'mock@mock.io';
    const name = 'Mock That';

    test('uses name equality', () {
      expect(
        const User(
          id: id,
          email: email,
          name: name,
        ),
        const User(
          id: id,
          email: email,
          name: name,
        ),
      );
    });

    test('uses stringify', () {
      expect(
        const User(
          id: id,
          email: email,
          name: name,
        ).toString(),
        'User(mock-id, mock@mock.io, Mock That)',
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
        ).copyWith(),
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
        ).copyWith(),
        const User(
          id: id,
          email: email,
        ),
      );
    });

    test('model to entity', () {
      expect(
        const User(
          id: id,
          email: email,
          name: name,
        ).toEntity(),
        const UserEntity(
          id: id,
          email: email,
          name: name,
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
          ),
        ),
        const User(
          id: id,
          email: email,
          name: name,
        ),
      );
    });
  });
}
