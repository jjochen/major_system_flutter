part of 'numbers_cubit.dart';

class NumbersState extends Equatable {
  const NumbersState({
    this.numbers = const <Number>[],
    this.loading = false,
  });

  final List<Number> numbers;
  final bool loading;

  NumbersState copyWith({
    List<Number> Function()? numbers,
    bool Function()? loading,
  }) {
    return NumbersState(
      numbers: numbers != null ? numbers() : this.numbers,
      loading: loading != null ? loading() : this.loading,
    );
  }

  @override
  List<Object?> get props => [
        numbers,
        loading,
      ];
}
