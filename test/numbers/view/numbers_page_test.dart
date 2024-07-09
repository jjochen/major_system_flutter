// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:major_system/attributions/attributions.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/numbers/numbers.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockNumbersBloc extends MockBloc<NumbersEvent, NumbersState>
    implements NumbersBloc {}

class MockUserInfo extends Mock implements UserInfo {
  @override
  String get email => 'test@gmail.com';

  @override
  String get id => '1234';
}

void main() {
  const logoutButtonKey = Key('homePage_logout_iconButton');
  const attributionsButtonKey = Key('homePage_attributions_iconButton');

  group('NumbersPage', () {
    registerFallbackValue(const AuthenticationUnauthenticated());
    registerFallbackValue(AuthenticationLogoutRequested());

    registerFallbackValue(NumbersState());
    registerFallbackValue(LoadNumbers());

    late AuthenticationBloc authenticationBloc;
    late UserInfo user;

    setUp(() {
      GetIt.instance.registerLazySingleton<FirebaseFirestore>(
        FakeFirebaseFirestore.new,
      );

      authenticationBloc = MockAuthenticationBloc();
      user = MockUserInfo();
      whenListen<AuthenticationState>(
        authenticationBloc,
        Stream.fromIterable([AuthenticationAuthenticated(user)]),
        initialState: AuthenticationUnauthenticated(),
      );
    });

    tearDown(() {
      GetIt.instance.reset();
    });

    group('calls', () {
      testWidgets('AuthenticationLogoutRequested when logout is pressed',
          (tester) async {
        await tester.pumpWidget(
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
            child: MaterialApp(
              home: NumbersPage(),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(logoutButtonKey));
        verify(
          () => authenticationBloc.add(AuthenticationLogoutRequested()),
        ).called(1);
      });
    });

    group('renders', () {
      testWidgets('numbers widget', (tester) async {
        await tester.pumpWidget(
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
            child: MaterialApp(
              home: NumbersPage(),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(NumbersList), findsOneWidget);
      });
    });

    group('navigates', () {
      testWidgets('to Attributions when attributions icon is pressed',
          (tester) async {
        await tester.pumpWidget(
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
            child: MaterialApp(
              home: NumbersPage(),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(attributionsButtonKey));
        await tester.pumpAndSettle();
        expect(find.byType(AttributionsPage), findsOneWidget);
      });
    });
  });
}
