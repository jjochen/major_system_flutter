// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/authentication/authentication.dart';

void main() {
  const emailString = 'test@gmail.com';
  group('Email', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final email = Email.pure();
        expect(email.value, '');
        expect(email.isPure, true);
      });

      test('dirty creates correct instance', () {
        final email = Email.dirty(emailString);
        expect(email.value, emailString);
        expect(email.isPure, false);
      });
    });

    group('validator', () {
      test('returns invalid error when email is empty', () {
        expect(
          Email.dirty().error,
          EmailValidationError.invalid,
        );
      });

      test('returns invalid error when email is malformed', () {
        expect(
          Email.dirty('test').error,
          EmailValidationError.invalid,
        );
      });

      test('is valid when email is valid', () {
        expect(
          Email.dirty(emailString).error,
          isNull,
        );
      });
    });
  });
}
