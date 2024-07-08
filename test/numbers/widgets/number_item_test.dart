import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/numbers/numbers.dart';
import 'package:numbers_repository/numbers_repository.dart';

void main() {
  group('NumberItem', () {
    const id = '1234';
    const numberOfDigits = 2;
    const value = 42;
    const number = Number(id: id, numberOfDigits: numberOfDigits, value: value);

    testWidgets('renders ListTile', (tester) async {
      final widget = Material(
        child: NumberItem(
          number: number,
          onTap: () {},
        ),
      );
      await tester.pumpWidget(MaterialApp(home: widget));
      expect(find.byType(ListTile), findsOneWidget);
    });
  });
}
