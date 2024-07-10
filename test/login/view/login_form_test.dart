// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/login/login.dart';
import 'package:major_system/sign_up/sign_up.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

class MockEmail extends Mock implements Email {}

class MockPassword extends Mock implements Password {}

void main() {
  const loginButtonKey = Key('loginForm_continue_raisedButton');
  const signInWithGoogleButtonKey = Key('loginForm_googleLogin_raisedButton');
  const emailInputKey = Key('loginForm_emailInput_textField');
  const passwordInputKey = Key('loginForm_passwordInput_textField');
  const createAccountButtonKey = Key('loginForm_createAccount_flatButton');

  const testEmail = 'test@gmail.com';
  const testPassword = 'testP@ssw0rd1';

  group('LoginForm', () {
    registerFallbackValue(const LoginState());

    late LoginCubit loginCubit;

    MaterialApp buildFrame() {
      return MaterialApp(
        home: Scaffold(
          body: BlocProvider.value(
            value: loginCubit,
            child: LoginForm(),
          ),
        ),
      );
    }

    setUp(() {
      loginCubit = MockLoginCubit();
      whenListen(
        loginCubit,
        Stream<LoginState>.empty(),
        initialState: LoginState(),
      );
    });

    group('calls', () {
      testWidgets('emailChanged when email changes', (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        await tester.enterText(find.byKey(emailInputKey), testEmail);
        verify(() => loginCubit.emailChanged(testEmail)).called(1);
      });

      testWidgets('passwordChanged when password changes', (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.enterText(find.byKey(passwordInputKey), testPassword);
        verify(() => loginCubit.passwordChanged(testPassword)).called(1);
      });

      testWidgets('logInWithCredentials when login button is pressed',
          (tester) async {
        whenListen(
          loginCubit,
          Stream<LoginState>.fromIterable([]),
          initialState: LoginState(),
        );
        when(() => loginCubit.logInWithCredentials())
            .thenAnswer((_) => Future.value());
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(loginButtonKey));
        verify(() => loginCubit.logInWithCredentials()).called(1);
      });

      testWidgets('logInWithGoogle when sign in with google button is pressed',
          (tester) async {
        when(() => loginCubit.logInWithGoogle())
            .thenAnswer((_) => Future.value());
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(signInWithGoogleButtonKey));
        verify(() => loginCubit.logInWithGoogle()).called(1);
      });
    });

    group('renders', () {
      testWidgets('AuthenticationFailure SnackBar when submission fails',
          (tester) async {
        whenListen(
          loginCubit,
          Stream.fromIterable(const <LoginState>[
            LoginState(submissionStatus: FormzSubmissionStatus.inProgress),
            LoginState(submissionStatus: FormzSubmissionStatus.failure),
          ]),
          initialState: LoginState(),
        );
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        expect(find.text('Authentication Failure'), findsOneWidget);
      });

      testWidgets('invalid email error text when email is invalid',
          (tester) async {
        final email = MockEmail();
        when(() => email.isNotValid).thenReturn(true);
        whenListen(
          loginCubit,
          Stream.fromIterable(<LoginState>[
            LoginState(email: email),
          ]),
          initialState: LoginState(),
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
          loginCubit,
          Stream.fromIterable(<LoginState>[
            LoginState(password: password),
          ]),
          initialState: LoginState(),
        );
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        expect(find.text('invalid password'), findsOneWidget);
      });

      testWidgets('disabled login button when status is not valid',
          (tester) async {
        whenListen(
          loginCubit,
          Stream.fromIterable(<LoginState>[
            LoginState(isValid: false),
          ]),
          initialState: LoginState(),
        );
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        final loginButton = tester.widget<ElevatedButton>(
          find.byKey(loginButtonKey),
        );
        expect(loginButton.enabled, isFalse);
      });

      testWidgets('enabled login button when status is valid', (tester) async {
        whenListen(
          loginCubit,
          Stream.fromIterable(<LoginState>[
            LoginState(),
          ]),
          initialState: LoginState(isValid: false),
        );
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        final loginButton = tester.widget<ElevatedButton>(
          find.byKey(loginButtonKey),
        );
        expect(loginButton.enabled, isTrue);
      });

      testWidgets('Sign in with Google Button', (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        expect(find.byKey(signInWithGoogleButtonKey), findsOneWidget);
      });
    });

    group('navigates', () {
      testWidgets('to SignUpPage when Create Account is pressed',
          (tester) async {
        await tester.pumpWidget(
          RepositoryProvider<AuthenticationRepository>(
            create: (_) => MockAuthenticationRepository(),
            child: buildFrame(),
          ),
        );
        await tester.tap(find.byKey(createAccountButtonKey));
        await tester.pumpAndSettle();
        expect(find.byType(SignUpPage), findsOneWidget);
      });
    });
  });
}
