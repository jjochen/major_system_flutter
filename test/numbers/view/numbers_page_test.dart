import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/attributions/attributions.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/numbers/numbers.dart';
import 'package:major_system/numbers/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
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
    registerFallbackValue<AuthenticationState>(
        const AuthenticationState.unknown());
    registerFallbackValue<AuthenticationEvent>(AuthenticationLogoutRequested());

    registerFallbackValue<NumbersState>(NumbersLoading());
    registerFallbackValue<NumbersEvent>(LoadNumbers());

    late AuthenticationBloc authenticationBloc;
    late NumbersBloc numbersBloc;
    late UserInfo user;

    setUp(() {
      authenticationBloc = MockAuthenticationBloc();
      numbersBloc = MockNumbersBloc();
      user = MockUserInfo();
      when(() => authenticationBloc.state).thenReturn(
        AuthenticationState.authenticated(user),
      );
      when(() => numbersBloc.state).thenReturn(
        const NumbersLoaded(),
      );
    });

    group('calls', () {
      testWidgets('AuthenticationLogoutRequested when logout is pressed',
          (tester) async {
        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>(
                  create: (context) => authenticationBloc),
              BlocProvider<NumbersBloc>(create: (context) => numbersBloc),
            ],
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
          MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>(
                  create: (context) => authenticationBloc),
              BlocProvider<NumbersBloc>(create: (context) => numbersBloc),
            ],
            child: MaterialApp(
              home: NumbersPage(),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(Numbers), findsOneWidget);
      });
    });

    group('navigates', () {
      testWidgets('to Attributions when attributions icon is pressed',
          (tester) async {
        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>(
                  create: (context) => authenticationBloc),
              BlocProvider<NumbersBloc>(create: (context) => numbersBloc),
            ],
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
