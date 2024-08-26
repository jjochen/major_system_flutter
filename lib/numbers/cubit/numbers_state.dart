part of 'numbers_cubit.dart';

class NumbersState extends Equatable {
  const NumbersState({
    this.numbers = const <Number>[],
    this.maxNumberOfDigits = 0,
    this.loading = false,
  });

  final List<Number> numbers;
  final int maxNumberOfDigits;
  final bool loading;

  NumbersState copyWith({
    List<Number> Function()? numbers,
    int Function()? maxNumberOfDigits,
    bool Function()? loading,
  }) {
    return NumbersState(
      numbers: numbers != null ? numbers() : this.numbers,
      maxNumberOfDigits: maxNumberOfDigits != null
          ? maxNumberOfDigits()
          : this.maxNumberOfDigits,
      loading: loading != null ? loading() : this.loading,
    );
  }

  @override
  List<Object?> get props => [
        numbers,
        maxNumberOfDigits,
        loading,
      ];
}
