// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:major_system/app/flow/app_flow.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/authentication/bloc/authentication_bloc.dart';
import 'package:major_system/login/login.dart';
import 'package:major_system/numbers/numbers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:numbers_repository/numbers_repository.dart';

// ignore: must_be_immutable
class MockAuthUser extends Mock implements UserInfo {
  @override
  String get id => 'id';

  @override
  String get name => 'Joe';

  @override
  String get email => 'joe@gmail.com';
}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockNumbersRepository extends Mock implements NumbersRepository {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockNumbersBloc extends MockBloc<NumbersEvent, NumbersState>
    implements NumbersBloc {}

void main() {
  group('AppFlow', () {
    late AuthenticationBloc authenticationBloc;
    late AuthenticationRepository authenticationRepository;
    late NumbersBloc numbersBloc;

    Widget buildFrame() {
      return MaterialApp(
        home: RepositoryProvider.value(
          value: authenticationRepository,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>(
                create: (context) => authenticationBloc,
              ),
              BlocProvider<NumbersBloc>(create: (context) => numbersBloc),
            ],
            child: AppFlow(),
          ),
        ),
      );
    }

    setUp(() {
      GetIt.instance.registerLazySingleton<FirebaseFirestore>(
        FakeFirebaseFirestore.new,
      );
      authenticationBloc = MockAuthenticationBloc();
      authenticationRepository = MockAuthenticationRepository();
      numbersBloc = MockNumbersBloc();
      whenListen(
        numbersBloc,
        Stream<NumbersState>.empty(),
        initialState: NumbersState(),
      );
    });

    tearDown(() {
      GetIt.instance.reset();
    });

    testWidgets('navigates to LoginPage when status is unauthenticated',
        (tester) async {
      whenListen(
        authenticationBloc,
        Stream<AuthenticationState>.empty(),
        initialState: const AuthenticationUnauthenticated(),
      );

      await tester.pumpWidget(buildFrame());
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('navigates to NumbersPage when status is authenticated',
        (tester) async {
      whenListen(
        authenticationBloc,
        Stream.value(AuthenticationAuthenticated(MockAuthUser())),
        initialState: const AuthenticationUnauthenticated(),
      );

      await tester.pumpWidget(buildFrame());
      await tester.pumpAndSettle();

      expect(find.byType(NumbersPage), findsOneWidget);
    });

    testWidgets('navigates back and forth when status changes', (tester) async {
      whenListen(
        authenticationBloc,
        Stream.fromIterable([
          AuthenticationAuthenticated(MockAuthUser()),
          AuthenticationUnauthenticated(),
        ]),
        initialState: const AuthenticationUnauthenticated(),
      );

      await tester.pumpWidget(buildFrame());
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
