import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

// ignore: must_be_immutable
class MockUserInfo extends Mock implements UserInfo {}

void main() {
  final UserInfo userInfo = MockUserInfo();
  late AuthenticationRepository authenticationRepository;

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
    when(() => authenticationRepository.userInfo)
        .thenAnswer((_) => const Stream.empty());
  });

  group('AuthenticationBloc', () {
    test('initial state is AuthenticationUnauthenticated', () {
      final authenticationBloc = AuthenticationBloc(
        authenticationRepository: authenticationRepository,
      );
      expect(authenticationBloc.state, const AuthenticationUnauthenticated());
      authenticationBloc.close();
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'subscribes to user stream',
      build: () {
        when(() => authenticationRepository.userInfo).thenAnswer(
          (_) => Stream.value(userInfo),
        );
        return AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        );
      },
      expect: () => <AuthenticationState>[
        AuthenticationAuthenticated(userInfo),
      ],
    );

    group('AuthenticationUserChanged', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [authenticated] when user is not null',
        build: () => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) => bloc.add(AuthenticationUserInfoChanged(userInfo)),
        expect: () => <AuthenticationState>[
          AuthenticationAuthenticated(userInfo),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [unauthenticated] when user is empty',
        build: () => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) =>
            bloc.add(const AuthenticationUserInfoChanged(UserInfo.empty)),
        expect: () => const <AuthenticationState>[
          AuthenticationUnauthenticated(),
        ],
      );
    });

    group('AuthenticationLogoutRequested', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'calls logOut on authenticationRepository '
        'when AuthenticationLogoutRequested is added',
        setUp: () {
          when(() => authenticationRepository.logOut()).thenAnswer(
            (_) => Future<void>.value(),
          );
        },
        build: () => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) => bloc.add(AuthenticationLogoutRequested()),
        verify: (_) {
          verify(() => authenticationRepository.logOut()).called(1);
        },
      );
    });
  });
}
