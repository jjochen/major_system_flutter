import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_repository/numbers_repository.dart';

void main() {
  test('test something', () {
    final number = Number(id: '123', numberOfDigits: 2, value: 42);
    expect(number.value, 42);
  });
}
