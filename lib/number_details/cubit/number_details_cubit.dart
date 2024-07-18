import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:numbers_repository/numbers_repository.dart';

part 'number_details_state.dart';

class NumberDetailsCubit extends Cubit<NumberDetailsState> {
  NumberDetailsCubit({
    required this.numbersRepository,
  }) : super(const NumberDetailsState());

  final NumbersRepository numbersRepository;
  StreamSubscription<List<Word>>? _wordsSubscription;
  StreamSubscription<Number?>? _numberSubscription;

  void selectNumber(Number number) {
    emit(
      state.copyWith(
        number: () => number,
        words: () => const [],
      ),
    );

    unawaited(_numberSubscription?.cancel());
    _numberSubscription =
        numbersRepository.watchNumber(number).listen(numberUpdated);

    unawaited(_wordsSubscription?.cancel());
    _wordsSubscription =
        numbersRepository.watchWords(number: number).listen(wordsUpdated);
  }

  void numberUpdated(Number? number) {
    emit(
      state.copyWith(
        number: () => number,
      ),
    );
  }

  void wordsUpdated(List<Word> words) {
    emit(
      state.copyWith(
        words: () => words,
      ),
    );
  }

  void selectMainWord(Word word) {
    final number = state.number;
    if (number == null) return;

    numbersRepository.setWordAsMain(word, number: number);
  }

  void addWord(String value) {
    final number = state.number;
    if (number == null) return;

    final word = Word(id: '', value: value);
    numbersRepository.addNewWord(word, number: number);
  }

  @override
  Future<void> close() {
    _numberSubscription?.cancel();
    _wordsSubscription?.cancel();
    return super.close();
  }
}
