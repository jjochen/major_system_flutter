part of 'numbers_bloc.dart';

abstract class NumbersEvent extends Equatable {
  const NumbersEvent();

  @override
  List<Object> get props => [];
}

class LoadNumbers extends NumbersEvent {
  const LoadNumbers();
}

class AddNumber extends NumbersEvent {
  const AddNumber(this.number);

  final Number number;

  @override
  List<Object> get props => [number];
}

class UpdateNumber extends NumbersEvent {
  const UpdateNumber(this.updatedNumber);

  final Number updatedNumber;

  @override
  List<Object> get props => [updatedNumber];
}

class DeleteNumber extends NumbersEvent {
  const DeleteNumber(this.number);

  final Number number;

  @override
  List<Object> get props => [number];
}

class SelectNumber extends NumbersEvent {
  const SelectNumber(this.number);

  final Number number;

  @override
  List<Object> get props => [number];
}

class NumbersUpdated extends NumbersEvent {
  const NumbersUpdated(this.numbers);

  final List<Number> numbers;

  @override
  List<Object> get props => [numbers];
}
