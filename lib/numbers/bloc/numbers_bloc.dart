import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:numbers_repository/numbers_repository.dart';

part 'numbers_event.dart';
part 'numbers_state.dart';

class NumbersBloc extends Bloc<NumbersEvent, NumbersState> {
  NumbersBloc({
    required NumbersRepository numbersRepository,
  })  : _numbersRepository = numbersRepository,
        super(const NumbersState()) {
    on<LoadNumbers>(_onLoadNumbers);
    on<AddNumber>(_onAddNumber);
    on<UpdateNumber>(_onUpdateNumber);
    on<DeleteNumber>(_onDeleteNumber);
    on<NumbersUpdated>(_onNumbersUpdated);
  }
  final NumbersRepository _numbersRepository;
  StreamSubscription<List<Number>>? _numbersSubscription;

  Future<void> _onLoadNumbers(
    LoadNumbers event,
    Emitter<NumbersState> emit,
  ) async {
    unawaited(_numbersSubscription?.cancel());
    _numbersSubscription = _numbersRepository.numbers().listen(
          (numbers) => add(NumbersUpdated(numbers)),
        );
  }

  Future<void> _onAddNumber(
    AddNumber event,
    Emitter<NumbersState> emit,
  ) async {
    await _numbersRepository.addNewNumber(event.number);
  }

  Future<void> _onUpdateNumber(
    UpdateNumber event,
    Emitter<NumbersState> emit,
  ) async {
    await _numbersRepository.updateNumber(event.updatedNumber);
  }

  Future<void> _onDeleteNumber(
    DeleteNumber event,
    Emitter<NumbersState> emit,
  ) async {
    await _numbersRepository.deleteNumber(event.number.id);
  }

  Future<void> _onNumbersUpdated(
    NumbersUpdated event,
    Emitter<NumbersState> emit,
  ) async {
    emit(
      state.copyWith(
        numbers: () => event.numbers,
        loading: () => false,
      ),
    );
  }

  @override
  Future<void> close() {
    _numbersSubscription?.cancel();
    return super.close();
  }
}
