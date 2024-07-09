part of 'numbers_bloc.dart';

class NumbersState extends Equatable {
  const NumbersState({
    this.numbers = const <Number>[],
    this.loading = false,
    this.selectedNumber,
  });

  final List<Number> numbers;
  final bool loading;
  final Number? selectedNumber;

  NumbersState copyWith({
    List<Number> Function()? numbers,
    bool Function()? loading,
    Number? Function()? selectedNumber,
  }) {
    return NumbersState(
      numbers: numbers != null ? numbers() : this.numbers,
      loading: loading != null ? loading() : this.loading,
      selectedNumber:
          selectedNumber != null ? selectedNumber() : this.selectedNumber,
    );
  }

  @override
  List<Object?> get props => [
        numbers,
        loading,
        selectedNumber,
      ];
}
