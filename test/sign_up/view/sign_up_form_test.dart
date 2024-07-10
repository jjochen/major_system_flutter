// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/sign_up/sign_up.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockSignUpCubit extends MockCubit<SignUpState> implements SignUpCubit {}

class MockEmail extends Mock implements Email {}

class MockPassword extends Mock implements Password {}

class MockConfirmedPassword extends Mock implements ConfirmedPassword {}

void main() {
  const signUpButtonKey = Key('signUpForm_continue_raisedButton');
  const emailInputKey = Key('signUpForm_emailInput_textField');
  const passwordInputKey = Key('signUpForm_passwordInput_textField');
  const confirmedPasswordInputKey =
      Key('signUpForm_confirmedPasswordInput_textField');

  const testEmail = 'test@gmail.com';
  const testPassword = 'testP@ssw0rd1';
  const testConfirmedPassword = 'testP@ssw0rd1';

  group('SignUpForm', () {
    registerFallbackValue(const SignUpState());

    late SignUpCubit signUpCubit;

    Widget buildFrame() {
      return MaterialApp(
        home: Scaffold(
          body: BlocProvider.value(
            value: signUpCubit,
            child: SignUpForm(),
          ),
        ),
      );
    }

    setUp(() {
      signUpCubit = MockSignUpCubit();
      whenListen(
        signUpCubit,
        Stream<SignUpState>.empty(),
        initialState: SignUpState(),
      );
    });

    group('calls', () {
      testWidgets('emailChanged when email changes', (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        await tester.enterText(find.byKey(emailInputKey), testEmail);
        verify(() => signUpCubit.emailChanged(testEmail)).called(1);
      });

      testWidgets('passwordChanged when password changes', (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        await tester.enterText(find.byKey(passwordInputKey), testPassword);
        verify(() => signUpCubit.passwordChanged(testPassword)).called(1);
      });

      testWidgets('confirmedPasswordChanged when confirmedPassword changes',
          (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byKey(confirmedPasswordInputKey),
          testConfirmedPassword,
        );
        verify(
          () => signUpCubit.confirmedPasswordChanged(testConfirmedPassword),
        ).called(1);
      });

      testWidgets('signUpFormSubmitted when sign up button is pressed',
          (tester) async {
        when(() => signUpCubit.state).thenReturn(
          const SignUpState(),
        );
        when(() => signUpCubit.submitSignUpForm())
            .thenAnswer((_) => Future.value());
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(signUpButtonKey));
        verify(() => signUpCubit.submitSignUpForm()).called(1);
      });
    });

    group('renders', () {
      testWidgets('Sign Up Failure SnackBar when submission fails',
          (tester) async {
        whenListen(
          signUpCubit,
          Stream.fromIterable(const <SignUpState>[
            SignUpState(submissionStatus: FormzSubmissionStatus.inProgress),
            SignUpState(submissionStatus: FormzSubmissionStatus.failure),
          ]),
        );
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        await tester.pump();
        expect(find.text('Sign Up Failure'), findsOneWidget);
      });

      testWidgets('invalid email error text when email is invalid',
          (tester) async {
        final email = MockEmail();
        when(() => email.isNotValid).thenReturn(true);
        whenListen(
          signUpCubit,
          Stream<SignUpState>.fromIterable(<SignUpState>[
            SignUpState(email: email),
          ]),
          initialState: SignUpState(),
        );
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        expect(find.text('invalid email'), findsOneWidget);
      });

      testWidgets('invalid password error text when password is invalid',
          (tester) async {
        final password = MockPassword();
        when(() => password.isNotValid).thenReturn(true);
        whenListen(
          signUpCubit,
          Stream<SignUpState>.fromIterable(<SignUpState>[
            SignUpState(password: password),
          ]),
          initialState: SignUpState(),
        );
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        expect(find.text('invalid password'), findsOneWidget);
      });

      testWidgets(
          'invalid confirmedPassword error text'
          ' when confirmedPassword is invalid', (tester) async {
        final confirmedPassword = MockConfirmedPassword();
        when(() => confirmedPassword.isNotValid).thenReturn(true);
        whenListen(
          signUpCubit,
          Stream<SignUpState>.fromIterable(<SignUpState>[
            SignUpState(confirmedPassword: confirmedPassword),
          ]),
          initialState: SignUpState(),
        );
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        expect(find.text('passwords do not match'), findsOneWidget);
      });

      testWidgets('disabled sign up button when status is not validated',
          (tester) async {
        whenListen(
          signUpCubit,
          Stream<SignUpState>.fromIterable(<SignUpState>[
            SignUpState(isValid: false),
          ]),
          initialState: SignUpState(),
        );
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        final signUpButton = tester.widget<ElevatedButton>(
          find.byKey(signUpButtonKey),
        );
        expect(signUpButton.enabled, isFalse);
      });

      testWidgets('enabled sign up button when status is valid',
          (tester) async {
        whenListen(
          signUpCubit,
          Stream<SignUpState>.fromIterable(<SignUpState>[
            SignUpState(),
          ]),
          initialState: SignUpState(isValid: false),
        );
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        final signUpButton = tester.widget<ElevatedButton>(
          find.byKey(signUpButtonKey),
        );
        expect(signUpButton.enabled, isTrue);
      });
    });
  });
}
