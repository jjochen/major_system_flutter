import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/settings/cubit/settings_cubit.dart';

void main() {
  group('SettingsState', () {
    test('should return correct default state', () {
      const state = SettingsState();

      expect(state.maxNumberOfDigits, 0);
    });

    test('supports value comparisons', () {
      expect(
        const SettingsState(
          maxNumberOfDigits: 2,
        ),
        const SettingsState(
          maxNumberOfDigits: 2,
        ),
      );

      expect(
        const SettingsState(
          maxNumberOfDigits: 2,
        ),
        isNot(
          const SettingsState(
            maxNumberOfDigits: 3,
          ),
        ),
      );
    });

    test('should copy state with new values', () {
      expect(
        const SettingsState(
          maxNumberOfDigits: 2,
        ).copyWith(
          maxNumberOfDigits: () => 5,
        ),
        const SettingsState(
          maxNumberOfDigits: 5,
        ),
      );
    });

    test('should copy state with existing values', () {
      expect(
        const SettingsState(
          maxNumberOfDigits: 2,
        ).copyWith(),
        const SettingsState(
          maxNumberOfDigits: 2,
        ),
      );
    });
  });
}
