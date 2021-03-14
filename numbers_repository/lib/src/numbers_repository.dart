import 'dart:async';

import 'package:numbers_repository/numbers_repository.dart';

abstract class NumbersRepository {
  Future<void> addNewNumber(Number number);

  Future<void> deleteNumber(Number todo);

  Stream<List<Number>> numbers();

  Future<void> updateNumber(Number number);
}
