// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/numbers/numbers.dart';
import 'package:major_system/settings/settings.dart';
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
  group('NumbersPage', () {
    const settingsButtonKey = Key('homePage_settings_iconButton');

    registerFallbackValue(const AuthenticationUnauthenticated());
    registerFallbackValue(AuthenticationLogoutRequested());

    registerFallbackValue(NumbersState());
    registerFallbackValue(LoadNumbers());

    late AuthenticationBloc authenticationBloc;
    late UserInfo user;

    Widget buildFrame() => BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
          child: MaterialApp(
            home: NumbersPage(user: user),
          ),
        );

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

    group('renders', () {
      testWidgets('numbers widget', (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        expect(find.byType(NumbersList), findsOneWidget);
      });

      testWidgets('settings button', (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        expect(find.byKey(settingsButtonKey), findsOneWidget);
      });
    });

    group('navigates', () {
      testWidgets('to Settings when settings button is pressed',
          (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(settingsButtonKey));
        await tester.pumpAndSettle();
        expect(find.byType(SettingsPage), findsOneWidget);
      });
    });
  });
}
