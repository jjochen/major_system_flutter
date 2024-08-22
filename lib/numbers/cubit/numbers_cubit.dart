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

  Future<void> loadNumbers() async {
    await _numbersSubscription?.cancel();
    _numbersSubscription =
        _numbersRepository.watchNumbers().listen(numbersUpdated);
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

  @override
  Future<void> close() async {
    await _numbersSubscription?.cancel();
    return super.close();
  }
}
