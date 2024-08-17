part of 'settings_cubit.dart';

@immutable
class SettingsState extends Equatable {
  const SettingsState({
    this.maxNumberOfDigits = 0,
  });

  final int maxNumberOfDigits;

  SettingsState copyWith({
    int Function()? maxNumberOfDigits,
  }) {
    return SettingsState(
      maxNumberOfDigits: maxNumberOfDigits != null
          ? maxNumberOfDigits()
          : this.maxNumberOfDigits,
    );
  }

  @override
  List<Object> get props => [
        maxNumberOfDigits,
      ];
}
