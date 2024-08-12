// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/attributions/attributions.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/settings/settings.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockUserInfo extends Mock implements UserInfo {
  @override
  String get email => 'test@gmail.com';

  @override
  String get id => '1234';
}

void main() {
  const logoutButtonKey = Key('settingsPage_logout_listTile');
  const attributionsButtonKey = Key('settingsPage_attributions_listTile');

  group('SettingsPage', () {
    registerFallbackValue(const AuthenticationUnauthenticated());
    registerFallbackValue(AuthenticationLogoutRequested());

    late AuthenticationBloc authenticationBloc;
    late UserInfo user;

    Widget buildFrame() => BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
          child: MaterialApp(
            home: SettingsPage(),
          ),
        );

    setUp(() {
      authenticationBloc = MockAuthenticationBloc();
      user = MockUserInfo();
      whenListen<AuthenticationState>(
        authenticationBloc,
        Stream.fromIterable([AuthenticationAuthenticated(user)]),
        initialState: AuthenticationUnauthenticated(),
      );
    });

    group('renders', () {
      testWidgets('logout button', (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        expect(find.byKey(logoutButtonKey), findsOneWidget);
      });

      testWidgets('attributions button', (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        expect(find.byKey(attributionsButtonKey), findsOneWidget);
      });
    });

    group('calls', () {
      testWidgets('AuthenticationLogoutRequested when logout is pressed',
          (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(logoutButtonKey));
        verify(
          () => authenticationBloc.add(AuthenticationLogoutRequested()),
        ).called(1);
      });
    });
    group('navigates', () {
      testWidgets('to Attributions when attributions list tile is pressed',
          (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(attributionsButtonKey));
        await tester.pumpAndSettle();
        expect(find.byType(AttributionsPage), findsOneWidget);
      });
    });
  });
}
