import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:numbers_repository/numbers_repository.dart';

part 'numbers_state.dart';

class NumbersCubit extends Cubit<NumbersState> {
  NumbersCubit({
    required NumbersRepository numbersRepository,
  })  : _numbersRepository = numbersRepository,
        super(const NumbersState());

  final NumbersRepository _numbersRepository;
  StreamSubscription<List<Number>>? _numbersSubscription;
  StreamSubscription<int>? _maxNumberOfDigitsSubscription;

  Future<void> initialize() async {
    // TODO(jjochen): needs testing
    await _maxNumberOfDigitsSubscription?.cancel();
    _maxNumberOfDigitsSubscription = _numbersRepository
        .watchMaxNumberOfDigits()
        .listen(maxNumberOfDigitsUpdated);
  }

  Future<void> reloadNumbers() async {
    await _numbersSubscription?.cancel();
    _numbersSubscription = _numbersRepository
        .watchNumbers(maxNumberOfDigits: state.maxNumberOfDigits)
        .listen(numbersUpdated);
  }

  Future<void> addNumber(Number number) async {
    await _numbersRepository.addNewNumber(number);
  }

  Future<void> updateNumber(Number number) async {
    await _numbersRepository.updateNumber(number);
  }

  Future<void> deleteNumber(Number number) async {
    await _numbersRepository.deleteNumber(number);
  }

  Future<void> numbersUpdated(List<Number> numbers) async {
    emit(
      state.copyWith(
        numbers: () => numbers,
        loading: () => false,
      ),
    );
  }

  Future<void> maxNumberOfDigitsUpdated(int maxNumberOfDigits) async {
    emit(
      state.copyWith(
        maxNumberOfDigits: () => maxNumberOfDigits,
      ),
    );

    // TODO(jjochen): does not work correctly
    await reloadNumbers();

    // TODO(jjochen): is this being called when the app starts?
    await _numbersRepository.addMissingNumbers(
      maxNumberOfDigits: maxNumberOfDigits,
    );
  }

  @override
  Future<void> close() async {
    await _numbersSubscription?.cancel();
    await _maxNumberOfDigitsSubscription?.cancel();
    return super.close();
  }
}
