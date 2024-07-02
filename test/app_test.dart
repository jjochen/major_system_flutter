// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/app.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/authentication/bloc/authentication_bloc.dart';
import 'package:major_system/home/home.dart';
import 'package:major_system/login/login.dart';
import 'package:major_system/splash/splash.dart';
import 'package:mocktail/mocktail.dart';

// ignore: must_be_immutable
class MockUser extends Mock implements User {
  @override
  String get id => 'id';

  @override
  String get name => 'Joe';

  @override
  String get email => 'joe@gmail.com';
}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() {
  group('App', () {
    final User mockUser = MockUser();
    registerFallbackValue(AuthenticationState.authenticated(mockUser));
    registerFallbackValue(AuthenticationUserChanged(mockUser));

    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      when(() => authenticationRepository.user).thenAnswer(
        (_) => const Stream.empty(),
      );
    });

    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        App(authenticationRepository: authenticationRepository),
      );
      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    late AuthenticationBloc authenticationBloc;
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationBloc = MockAuthenticationBloc();
      authenticationRepository = MockAuthenticationRepository();
    });

    testWidgets('renders SplashPage by default', (tester) async {
      when(() => authenticationBloc.state)
          .thenReturn(const AuthenticationState.unknown());
      await tester.pumpWidget(
        BlocProvider.value(value: authenticationBloc, child: const AppView()),
      );
      await tester.pumpAndSettle();
      expect(find.byType(SplashPage), findsOneWidget);
    });

    testWidgets('navigates to LoginPage when status is unauthenticated',
        (tester) async {
      whenListen(
        authenticationBloc,
        Stream.value(const AuthenticationState.unauthenticated()),
        initialState: const AuthenticationState.unknown(),
      );
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: BlocProvider.value(
            value: authenticationBloc,
            child: const AppView(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('navigates to HomePage when status is authenticated',
        (tester) async {
      whenListen(
        authenticationBloc,
        Stream.value(AuthenticationState.authenticated(MockUser())),
        initialState: const AuthenticationState.unknown(),
      );
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: BlocProvider.value(
            value: authenticationBloc,
            child: const AppView(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
