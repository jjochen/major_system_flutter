import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:numbers_repository/numbers_repository.dart';
import 'package:pedantic/pedantic.dart';

part 'numbers_event.dart';
part 'numbers_state.dart';

class NumbersBloc extends Bloc<NumbersEvent, NumbersState> {
  NumbersBloc({
    required NumbersRepository numbersRepository,
  })   : _numbersRepository = numbersRepository,
        super(NumbersLoading());

  final NumbersRepository _numbersRepository;
  StreamSubscription? _numbersSubscription;

  @override
  Stream<NumbersState> mapEventToState(NumbersEvent event) async* {
    if (event is LoadNumbers) {
      yield* _mapLoadNumbersToState();
    } else if (event is AddNumber) {
      yield* _mapAddNumberToState(event);
    } else if (event is UpdateNumber) {
      yield* _mapUpdateNumberToState(event);
    } else if (event is DeleteNumber) {
      yield* _mapDeleteNumberToState(event);
    } else if (event is NumbersUpdated) {
      yield* _mapNumbersUpdateToState(event);
    }
  }

  Stream<NumbersState> _mapLoadNumbersToState() async* {
    unawaited(_numbersSubscription?.cancel());
    _numbersSubscription = _numbersRepository.numbers().listen(
          (numbers) => add(NumbersUpdated(numbers)),
        );
  }

  Stream<NumbersState> _mapAddNumberToState(AddNumber event) async* {
    unawaited(_numbersRepository.addNewNumber(event.number));
  }

  Stream<NumbersState> _mapUpdateNumberToState(UpdateNumber event) async* {
    unawaited(_numbersRepository.updateNumber(event.updatedNumber));
  }

  Stream<NumbersState> _mapDeleteNumberToState(DeleteNumber event) async* {
    unawaited(_numbersRepository.deleteNumber(event.number));
  }

  Stream<NumbersState> _mapNumbersUpdateToState(NumbersUpdated event) async* {
    yield NumbersLoaded(event.numbers);
  }

  @override
  Future<void> close() {
    _numbersSubscription?.cancel();
    return super.close();
  }
}
