import 'package:numbers_repository/numbers_repository.dart';
import 'package:numbers_repository/src/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';

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
      final newId = 'new-id';
      expect(
        const User(
          id: id,
          email: email,
          name: name,
        ).copyWith(id: newId),
        User(
          id: newId,
          email: email,
          name: name,
        ),
      );
    });

    test('copies with new email', () {
      final newEmail = 'yo@yo.yo';
      expect(
        const User(
          id: id,
          email: email,
          name: name,
        ).copyWith(email: newEmail),
        User(
          id: id,
          email: newEmail,
          name: name,
        ),
      );
    });

    test('copies with null email', () {
      final newEmail = null;
      expect(
        const User(
          id: id,
          email: email,
          name: name,
        ).copyWith(email: newEmail),
        User(
          id: id,
          email: newEmail,
          name: name,
        ),
      );
    });

    test('copies with new name', () {
      final newName = 'Name That';
      expect(
        const User(
          id: id,
          email: email,
          name: name,
        ).copyWith(name: newName),
        User(
          id: id,
          email: email,
          name: newName,
        ),
      );
    });

    test('copies with null name', () {
      final newName = null;
      expect(
        const User(
          id: id,
          email: email,
          name: name,
        ).copyWith(name: newName),
        User(
          id: id,
          email: email,
          name: newName,
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
        UserEntity(
          id: id,
          email: email,
          name: name,
        ),
      );
    });

    test('model from entity', () {
      expect(
        User.fromEntity(UserEntity(
          id: id,
          email: email,
          name: name,
        )),
        const User(
          id: id,
          email: email,
          name: name,
        ),
      );
    });
  });
}
