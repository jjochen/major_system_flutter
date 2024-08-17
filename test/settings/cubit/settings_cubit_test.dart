import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/settings/cubit/settings_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:numbers_repository/numbers_repository.dart';

import '../../app/view/app_test.dart';

void main() {
  group('SettingsCubit', () {
    late NumbersRepository numbersRepository;
    late AuthenticationRepository authenticationRepository;

    SettingsCubit build() => SettingsCubit(
          numbersRepository: numbersRepository,
          authenticationRepository: authenticationRepository,
        );

    setUp(() {
      numbersRepository = MockNumbersRepository();
      authenticationRepository = MockAuthenticationRepository();
    });

    blocTest<SettingsCubit, SettingsState>(
      'emits [] when nothing is added',
      build: build,
      setUp: () {
        when(() => numbersRepository.watchMaxNumberOfDigits()).thenAnswer(
          (_) => const Stream<int>.empty(),
        );
      },
      seed: SettingsState.new,
      expect: () => <SettingsState>[],
      verify: (cubit) {
        verify(() => numbersRepository.watchMaxNumberOfDigits()).called(1);
        verifyNever(() => authenticationRepository.logOut());
      },
    );

    blocTest<SettingsCubit, SettingsState>(
      'emits [maxNumberOfDigits] when maxNumberOfDigits is added',
      build: build,
      setUp: () {
        when(() => numbersRepository.watchMaxNumberOfDigits()).thenAnswer(
          (_) => Stream<int>.fromIterable([2]),
        );
      },
      seed: SettingsState.new,
      expect: () => <SettingsState>[
        const SettingsState(maxNumberOfDigits: 2),
      ],
    );

    blocTest<SettingsCubit, SettingsState>(
      'set maxNumberOfDigits when setMaxNumberOfDigits is called',
      build: build,
      setUp: () {
        when(() => numbersRepository.watchMaxNumberOfDigits()).thenAnswer(
          (_) => const Stream<int>.empty(),
        );
        when(() => numbersRepository.setMaxNumberOfDigits(2)).thenAnswer(
          (_) async {},
        );
      },
      seed: SettingsState.new,
      act: (cubit) => cubit.setMaxNumberOfDigits(2),
      verify: (cubit) {
        verify(() => numbersRepository.setMaxNumberOfDigits(2)).called(1);
      },
    );

    blocTest<SettingsCubit, SettingsState>(
      'log out when logOut is called',
      build: build,
      setUp: () {
        when(() => numbersRepository.watchMaxNumberOfDigits()).thenAnswer(
          (_) => const Stream<int>.empty(),
        );
        when(() => authenticationRepository.logOut()).thenAnswer(
          (_) async {},
        );
      },
      seed: SettingsState.new,
      act: (cubit) => cubit.logOut(),
      verify: (cubit) {
        verify(() => authenticationRepository.logOut()).called(1);
      },
    );
  });
}
