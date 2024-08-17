import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:numbers_repository/numbers_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required this.numbersRepository,
    required this.authenticationRepository,
  }) : super(const SettingsState()) {
    _userSubscription = numbersRepository.watchMaxNumberOfDigits().listen(
      (maxNumberOfDigits) {
        emit(
          state.copyWith(
            maxNumberOfDigits: () => maxNumberOfDigits,
          ),
        );
      },
    );
  }

  final NumbersRepository numbersRepository;
  final AuthenticationRepository authenticationRepository;
  StreamSubscription<int>? _userSubscription;

  void logOut() {
    authenticationRepository.logOut();
  }

  void setMaxNumberOfDigits(int maxNumberOfDigits) {
    numbersRepository.setMaxNumberOfDigits(maxNumberOfDigits);
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
