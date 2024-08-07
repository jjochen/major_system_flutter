// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/authentication/authentication.dart';

void main() {
  const confirmedPasswordString = 'T0pS3cr3t123';
  const passwordString = 'T0pS3cr3t123';
  const password = Password.dirty(passwordString);
  group('confirmedPassword', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final confirmedPassword = ConfirmedPassword.pure();
        expect(confirmedPassword.value, '');
        expect(confirmedPassword.isPure, true);
      });

      test('dirty creates correct instance', () {
        final confirmedPassword = ConfirmedPassword.dirty(
          password: password.value,
          value: confirmedPasswordString,
        );
        expect(confirmedPassword.value, confirmedPasswordString);
        expect(confirmedPassword.password, password.value);
        expect(confirmedPassword.isPure, false);
      });
    });

    group('validator', () {
      test('returns invalid error when confirmedPassword is empty', () {
        expect(
          ConfirmedPassword.dirty(password: password.value).error,
          ConfirmedPasswordValidationError.invalid,
        );
      });

      test('is valid when confirmedPassword is not empty', () {
        expect(
          ConfirmedPassword.dirty(
            password: password.value,
            value: confirmedPasswordString,
          ).error,
          isNull,
        );
      });
    });
  });
}
