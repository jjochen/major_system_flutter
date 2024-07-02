// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/sign_up/sign_up.dart';

void main() {
  const email = Email.dirty('email');
  const passwordString = 'password';
  const password = Password.dirty(passwordString);
  const confirmedPassword = ConfirmedPassword.dirty(
    password: passwordString,
    value: passwordString,
  );
  group('SignUpState', () {
    test('supports value comparisons', () {
      expect(SignUpState(), SignUpState());
    });

    test('returns same object when no properties are passed', () {
      expect(SignUpState().copyWith(), SignUpState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        SignUpState().copyWith(),
        SignUpState(),
      );
    });

    test('returns object with updated email when email is passed', () {
      expect(
        SignUpState().copyWith(email: email),
        SignUpState(email: email),
      );
    });

    test('returns object with updated password when password is passed', () {
      expect(
        SignUpState().copyWith(password: password),
        SignUpState(password: password),
      );
    });

    test(
        'returns object with updated confirmedPassword'
        ' when confirmedPassword is passed', () {
      expect(
        SignUpState().copyWith(confirmedPassword: confirmedPassword),
        SignUpState(confirmedPassword: confirmedPassword),
      );
    });
  });
}
