part of 'number_details_cubit.dart';

class NumberDetailsState extends Equatable {
  const NumberDetailsState({
    this.number,
    this.words = const <Word>[],
  }) : super();

  final Number? number;
  final List<Word> words;

  NumberDetailsState copyWith({
    Number? Function()? number,
    List<Word> Function()? words,
  }) {
    return NumberDetailsState(
      number: number != null ? number() : this.number,
      words: words != null ? words() : this.words,
    );
  }

  @override
  List<Object?> get props => [
        number,
        words,
      ];
}
