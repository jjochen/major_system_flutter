// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/app/flow/app_flow.dart';
import 'package:major_system/app/view/app.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/authentication/bloc/authentication_bloc.dart';
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
  group('App', () {
    final UserInfo mockUser = MockAuthUser();
    registerFallbackValue(AuthenticationAuthenticated(mockUser));
    registerFallbackValue(AuthenticationUserInfoChanged(mockUser));

    late AuthenticationRepository authenticationRepository;

    registerFallbackValue(const NumbersState());
    registerFallbackValue(const NumbersUpdated([]));

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      when(() => authenticationRepository.userInfo).thenAnswer(
        (_) => const Stream.empty(),
      );
    });

    testWidgets('renders AppFlow', (tester) async {
      await tester.pumpWidget(
        App(
          authenticationRepository: authenticationRepository,
        ),
      );
      expect(find.byType(AppFlow), findsOneWidget);
    });

    testWidgets('provides authentication repository', (tester) async {
      await tester.pumpWidget(
        App(
          authenticationRepository: authenticationRepository,
        ),
      );
      final context = tester.element(find.byType(AppFlow));
      expect(
        RepositoryProvider.of<AuthenticationRepository>(context),
        authenticationRepository,
      );
    });
  });
}
