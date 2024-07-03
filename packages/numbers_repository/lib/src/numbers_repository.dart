import 'dart:async';

import 'package:numbers_repository/numbers_repository.dart';

abstract class NumbersRepository {
  String? userId;

  Future<String> addNewNumber(Number number);

  Future<Number?> getNumber(String id);

  Future<void> deleteNumber(String id);

  Stream<List<Number>> numbers();

  Future<void> updateNumber(Number number);
}
