// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/attributions/attributions.dart';
import 'package:major_system/settings/cubit/settings_cubit.dart';
import 'package:major_system/settings/settings.dart';
import 'package:mocktail/mocktail.dart';
import 'package:numbers_repository/numbers_repository.dart';

import '../../app/view/app_test.dart';

class MockSettingsCubit extends MockCubit<SettingsState>
    implements SettingsCubit {}

void main() {
  const logoutButtonKey = Key('settingsPage_logout_listTile');
  const attributionsButtonKey = Key('settingsPage_attributions_listTile');
  const maxNumberOfDigitsButtonKey =
      Key('settingsPage_maxNumberOfDigits_listTile');
  const maxNumberOfDigitsDropdownButtonKey =
      Key('settingsPage_maxNumberOfDigits_dropdownButton');
  Key maxNumberOfDigitsDropdownKey(int index) =>
      Key('settingsPage_maxNumberOfDigits_dropdownItem_$index');

  group('SettingsPage', () {
    late AuthenticationRepository authenticationRepository;
    late NumbersRepository numbersRepository;

    Widget buildFrame() => MaterialApp(
          home: SettingsPage(
            authenticationRepository: authenticationRepository,
            numbersRepository: numbersRepository,
          ),
        );

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      numbersRepository = MockNumbersRepository();
      when(() => authenticationRepository.logOut()).thenAnswer((_) async {});
      when(() => numbersRepository.watchMaxNumberOfDigits()).thenAnswer(
        (_) => Stream.empty(),
      );
    });

    group('AppBar', () {
      testWidgets('renders', (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        expect(find.text('Settings'), findsOneWidget);
      });
    });

    group('SettingsBody', () {
      testWidgets('renders', (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        expect(find.byType(SettingsBody), findsOneWidget);
      });
    });
  });

  group('SettingsBody', () {
    late SettingsCubit settingsCubit;

    Widget buildFrame() => BlocProvider<SettingsCubit>(
          create: (context) => settingsCubit,
          child: MaterialApp(
            home: Scaffold(
              body: SettingsBody(),
            ),
          ),
        );

    setUp(() {
      settingsCubit = MockSettingsCubit();
      whenListen<SettingsState>(
        settingsCubit,
        Stream.fromIterable([]),
        initialState: SettingsState(maxNumberOfDigits: 2),
      );
    });

    group('Max Number of Digits List Tile', () {
      testWidgets('renders', (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        expect(find.byKey(maxNumberOfDigitsButtonKey), findsOneWidget);
      });

      testWidgets('does nothing for now when pressed', (tester) async {
        // TODO(jjochen): Adjust test when functionality is implemented
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(maxNumberOfDigitsButtonKey));
        await tester.pumpAndSettle();
        expect(find.byKey(maxNumberOfDigitsButtonKey), findsOneWidget);
      });

      testWidgets('calls setMaxNumberOfDigits when dropdown value changes',
          (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(maxNumberOfDigitsDropdownButtonKey));
        await tester.pumpAndSettle();
        expect(find.byKey(maxNumberOfDigitsDropdownKey(0)), findsOneWidget);
        expect(
          find.byKey(maxNumberOfDigitsDropdownKey(1)),
          findsAtLeast(1),
        ); // Why two?
        expect(find.byKey(maxNumberOfDigitsDropdownKey(2)), findsOneWidget);

        await tester.tap(
          find.byKey(maxNumberOfDigitsDropdownKey(2)),
          warnIfMissed: false,
        );
        await tester.pumpAndSettle();
        verify(
          () => settingsCubit.setMaxNumberOfDigits(3),
        ).called(1);
      });
    });

    group('Attributions List Tile', () {
      testWidgets('renders', (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        expect(find.byKey(attributionsButtonKey), findsOneWidget);
      });

      testWidgets('navigates to AttributionsPage when pressed', (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(attributionsButtonKey));
        await tester.pumpAndSettle();
        expect(find.byType(AttributionsPage), findsOneWidget);
      });
    });

    group('Logout List Tile', () {
      testWidgets('renders', (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        expect(find.byKey(logoutButtonKey), findsOneWidget);
      });

      testWidgets('calls AuthenticationLogoutRequested when pressed',
          (tester) async {
        await tester.pumpWidget(buildFrame());
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(logoutButtonKey));
        verify(
          () => settingsCubit.logOut(),
        ).called(1);
      });
    });
  });
}
