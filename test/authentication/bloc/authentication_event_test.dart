// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/authentication/authentication.dart';

void main() {
  group('AuthenticationEvent', () {
    group('LoggedOut', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationLogoutRequested(),
          AuthenticationLogoutRequested(),
        );
      });
    });

    group('AuthenticationUserChanged', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationUserChanged(User(id: 'some-id')),
          AuthenticationUserChanged(User(id: 'some-id')),
        );
      });
    });
  });
}
