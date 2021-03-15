import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_repository/numbers_repository.dart';

void main() {
  test('test something', () {
    final number = Number('123', 2, 42);
    expect(number.value, 42);
  });
}
