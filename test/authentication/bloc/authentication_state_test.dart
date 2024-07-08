// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:mocktail/mocktail.dart';

// ignore: must_be_immutable
class MockUser extends Mock implements UserInfo {}

void main() {
  group('AuthenticationState', () {
    group('AuthenticationAuthenticated', () {
      test('supports value comparisons', () {
        final user = MockUser();
        expect(
          AuthenticationAuthenticated(user),
          AuthenticationAuthenticated(user),
        );
      });
    });

    group('AuthenticationUnauthenticated', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationUnauthenticated(),
          AuthenticationUnauthenticated(),
        );
      });
    });
  });
}
