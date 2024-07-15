import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:numbers_repository/numbers_repository.dart';

part 'number_details_state.dart';

class NumberDetailsCubit extends Cubit<NumberDetailsState> {
  NumberDetailsCubit({
    required this.numbersRepository,
  }) : super(const NumberDetailsInitial());

  final NumbersRepository numbersRepository;
  StreamSubscription<List<Word>>? _wordsSubscription;
  StreamSubscription<Number>? _numberSubscription;

  void selectNumber(Number number) {
    emit(NumberSelected(number));

    unawaited(_numberSubscription?.cancel());
    _numberSubscription =
        numbersRepository.watchNumber(number).listen((number) {
      emit(NumberSelected(number));
    });

    unawaited(_wordsSubscription?.cancel());
    _wordsSubscription =
        numbersRepository.watchWords(number: number).listen(wordsUpdated);
  }

  void numberUpdated(Number number) {
    final state = this.state;
    if (state is! NumberSelected) return;

    emit(state.copyWith(number: () => number));
  }

  void wordsUpdated(List<Word> words) {
    final state = this.state;
    if (state is! NumberSelected) return;

    emit(state.copyWith(words: () => words));
  }

  void selectMainWord(Word word) {
    final state = this.state;
    if (state is! NumberSelected) return;

    numbersRepository.setWordAsMain(word, number: state.number);
  }

  @override
  Future<void> close() {
    _wordsSubscription?.cancel();
    return super.close();
  }
}
