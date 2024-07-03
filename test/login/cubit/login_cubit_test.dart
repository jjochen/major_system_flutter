// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/login/login.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  const invalidEmailString = 'invalid';
  const invalidEmail = Email.dirty(invalidEmailString);

  const validEmailString = 'test@gmail.com';
  const validEmail = Email.dirty(validEmailString);

  const invalidPasswordString = 'invalid';
  const invalidPassword = Password.dirty(invalidPasswordString);

  const validPasswordString = 't0pS3cret1234';
  const validPassword = Password.dirty(validPasswordString);

  group('LoginCubit', () {
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
    });

    test('initial state is LoginState', () {
      expect(LoginCubit(authenticationRepository).state, LoginState());
    });

    group('emailChanged', () {
      blocTest<LoginCubit, LoginState>(
        'emits [invalid] when email/password are invalid',
        build: () => LoginCubit(authenticationRepository),
        act: (cubit) => cubit.emailChanged(invalidEmailString),
        expect: () => const <LoginState>[
          LoginState(
            email: invalidEmail,
            isValid: false,
          ),
        ],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [valid] when email/password are valid',
        build: () => LoginCubit(authenticationRepository),
        seed: () => LoginState(password: validPassword),
        act: (cubit) => cubit.emailChanged(validEmailString),
        expect: () => const <LoginState>[
          LoginState(
            email: validEmail,
            password: validPassword,
          ),
        ],
      );
    });

    group('passwordChanged', () {
      blocTest<LoginCubit, LoginState>(
        'emits [invalid] when email/password are invalid',
        build: () => LoginCubit(authenticationRepository),
        act: (cubit) => cubit.passwordChanged(invalidPasswordString),
        expect: () => const <LoginState>[
          LoginState(
            password: invalidPassword,
            isValid: false,
          ),
        ],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [valid] when email/password are valid',
        build: () => LoginCubit(authenticationRepository),
        seed: () => LoginState(email: validEmail),
        act: (cubit) => cubit.passwordChanged(validPasswordString),
        expect: () => <LoginState>[
          LoginState(
            email: validEmail,
            password: validPassword,
          ),
        ],
      );
    });

    group('logInWithCredentials', () {
      // blocTest<LoginCubit, LoginState>(
      //   'does nothing when status is not validated',
      //   build: () => LoginCubit(authenticationRepository),
      //   act: (cubit) => cubit.logInWithCredentials(),
      //   expect: () => const <LoginState>[],
      // );

      blocTest<LoginCubit, LoginState>(
        'calls logInWithEmailAndPassword with correct email/password',
        build: () {
          when(
            () => authenticationRepository.logInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer((_) => Future.value());
          return LoginCubit(authenticationRepository);
        },
        seed: () => LoginState(
          email: validEmail,
          password: validPassword,
        ),
        act: (cubit) => cubit.logInWithCredentials(),
        verify: (_) {
          verify(
            () => authenticationRepository.logInWithEmailAndPassword(
              email: validEmailString,
              password: validPasswordString,
            ),
          ).called(1);
        },
      );

      blocTest<LoginCubit, LoginState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when logInWithEmailAndPassword succeeds',
        build: () {
          when(
            () => authenticationRepository.logInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer((_) => Future.value());
          return LoginCubit(authenticationRepository);
        },
        seed: () => LoginState(
          email: validEmail,
          password: validPassword,
        ),
        act: (cubit) => cubit.logInWithCredentials(),
        expect: () => const <LoginState>[
          LoginState(
            submissionStatus: FormzSubmissionStatus.inProgress,
            email: validEmail,
            password: validPassword,
          ),
          LoginState(
            submissionStatus: FormzSubmissionStatus.success,
            email: validEmail,
            password: validPassword,
          ),
        ],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [submissionInProgress, submissionFailure] '
        'when logInWithEmailAndPassword fails',
        build: () {
          when(
            () => authenticationRepository.logInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenThrow(Exception('oops'));
          return LoginCubit(authenticationRepository);
        },
        seed: () => LoginState(
          email: validEmail,
          password: validPassword,
        ),
        act: (cubit) => cubit.logInWithCredentials(),
        expect: () => const <LoginState>[
          LoginState(
            submissionStatus: FormzSubmissionStatus.inProgress,
            email: validEmail,
            password: validPassword,
          ),
          LoginState(
            submissionStatus: FormzSubmissionStatus.failure,
            email: validEmail,
            password: validPassword,
          ),
        ],
      );
    });

    group('logInWithGoogle', () {
      blocTest<LoginCubit, LoginState>(
        'calls logInWithGoogle',
        build: () {
          when(() => authenticationRepository.logInWithGoogle())
              .thenAnswer((_) => Future.value());
          return LoginCubit(authenticationRepository);
        },
        act: (cubit) => cubit.logInWithGoogle(),
        verify: (_) {
          verify(() => authenticationRepository.logInWithGoogle()).called(1);
        },
      );

      blocTest<LoginCubit, LoginState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when logInWithGoogle succeeds',
        build: () {
          when(() => authenticationRepository.logInWithGoogle())
              .thenAnswer((_) => Future.value());
          return LoginCubit(authenticationRepository);
        },
        act: (cubit) => cubit.logInWithGoogle(),
        expect: () => const <LoginState>[
          LoginState(submissionStatus: FormzSubmissionStatus.inProgress),
          LoginState(submissionStatus: FormzSubmissionStatus.success),
        ],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [submissionInProgress, submissionFailure] '
        'when logInWithGoogle fails',
        build: () {
          when(
            () => authenticationRepository.logInWithGoogle(),
          ).thenThrow(Exception('oops'));
          return LoginCubit(authenticationRepository);
        },
        act: (cubit) => cubit.logInWithGoogle(),
        expect: () => const <LoginState>[
          LoginState(submissionStatus: FormzSubmissionStatus.inProgress),
          LoginState(submissionStatus: FormzSubmissionStatus.failure),
        ],
      );

      // blocTest<LoginCubit, LoginState>(
      //   'emits [inProgress, initial] '
      //   'when logInWithGoogle is cancelled',
      //   setUp: () {
      //     when(
      //       () => authenticationRepository.logInWithGoogle(),
      //     ).thenThrow(Exception('oops'));
      //   },
      //   build: () {
      //     return LoginCubit(authenticationRepository);
      //   },
      //   act: (cubit) => cubit.logInWithGoogle(),
      //   expect: () => const <LoginState>[
      //     LoginState(submissionStatus: FormzSubmissionStatus.inProgress),
      //     LoginState(submissionStatus: FormzSubmissionStatus.initial),
      //   ],
      // );
    });
  });
}

class FakeInvocation extends Fake implements Invocation {}
