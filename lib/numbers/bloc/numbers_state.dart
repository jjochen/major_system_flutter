part of 'numbers_bloc.dart';

abstract class NumbersState extends Equatable {
  const NumbersState();

  @override
  List<Object> get props => [];
}

class NumbersLoading extends NumbersState {
  const NumbersLoading();
}

class NumbersLoaded extends NumbersState {
  const NumbersLoaded(this.numbers);

  final List<Number> numbers;

  @override
  List<Object> get props => [numbers];
}

class NumbersNotLoaded extends NumbersState {
  const NumbersNotLoaded();
}
