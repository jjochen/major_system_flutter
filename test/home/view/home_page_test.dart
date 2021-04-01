import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/attributions/attributions.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/home/home.dart';
import 'package:major_system/home/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

// ignore: must_be_immutable
class MockUser extends Mock implements User {
  @override
  String get email => 'test@gmail.com';
}

void main() {
  const logoutButtonKey = Key('homePage_logout_iconButton');
  const attributionsButtonKey = Key('homePage_attributions_iconButton');
  group('HomePage', () {
    registerFallbackValue<AuthenticationState>(
        const AuthenticationState.unknown());
    registerFallbackValue<AuthenticationEvent>(AuthenticationLogoutRequested());
    late AuthenticationBloc authenticationBloc;
    late User user;

    setUp(() {
      authenticationBloc = MockAuthenticationBloc();
      user = MockUser();
      when(() => authenticationBloc.state).thenReturn(
        AuthenticationState.authenticated(user),
      );
    });

    group('calls', () {
      testWidgets('AuthenticationLogoutRequested when logout is pressed',
          (tester) async {
        await tester.pumpWidget(
          BlocProvider.value(
            value: authenticationBloc,
            child: MaterialApp(
              home: HomePage(),
            ),
          ),
        );
        await tester.tap(find.byKey(logoutButtonKey));
        verify(
          () => authenticationBloc.add(AuthenticationLogoutRequested()),
        ).called(1);
      });
    });

    group('renders', () {
      testWidgets('avatar widget', (tester) async {
        await tester.pumpWidget(
          BlocProvider.value(
            value: authenticationBloc,
            child: MaterialApp(
              home: HomePage(),
            ),
          ),
        );
        expect(find.byType(Avatar), findsOneWidget);
      });

      testWidgets('email address', (tester) async {
        await tester.pumpWidget(
          BlocProvider.value(
            value: authenticationBloc,
            child: MaterialApp(
              home: HomePage(),
            ),
          ),
        );
        expect(find.text('test@gmail.com'), findsOneWidget);
      });

      testWidgets('name', (tester) async {
        when(() => user.name).thenReturn('Joe');
        await tester.pumpWidget(
          BlocProvider.value(
            value: authenticationBloc,
            child: MaterialApp(
              home: HomePage(),
            ),
          ),
        );
        expect(find.text('Joe'), findsOneWidget);
      });
    });

    group('navigates', () {
      testWidgets('to Attributions when attributions icconns is pressed',
          (tester) async {
        await tester.pumpWidget(
          BlocProvider.value(
            value: authenticationBloc,
            child: MaterialApp(
              home: HomePage(),
            ),
          ),
        );
        await tester.tap(find.byKey(attributionsButtonKey));
        await tester.pumpAndSettle();
        expect(find.byType(AttributionsPage), findsOneWidget);
      });
    });
  });
}
