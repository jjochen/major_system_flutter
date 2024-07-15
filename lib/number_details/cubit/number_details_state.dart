part of 'number_details_cubit.dart';

sealed class NumberDetailsState extends Equatable {
  const NumberDetailsState();
}

class NumberDetailsInitial extends NumberDetailsState {
  const NumberDetailsInitial();

  @override
  List<Object> get props => [];
}

class NumberSelected extends NumberDetailsState {
  const NumberSelected(
    this.number, {
    this.words = const <Word>[],
  }) : super();

  final Number number;
  final List<Word> words;

  NumberSelected copyWith({
    Number Function()? number,
    List<Word> Function()? words,
  }) {
    return NumberSelected(
      number != null ? number() : this.number,
      words: words != null ? words() : this.words,
    );
  }

  @override
  List<Object?> get props => [
        number,
        words,
      ];
}
