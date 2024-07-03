// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/numbers/numbers.dart';
import 'package:numbers_repository/numbers_repository.dart';

void main() {
  group('DeleteNumberSnackBar', () {
    const id = '1234';
    const numberOfDigits = 2;
    const value = 42;
    final number = Number(id: id, numberOfDigits: numberOfDigits, value: value);

    const key = Key('snack-bar-key');

    testWidgets('is presented on tap', (tester) async {
      final snackBar =
          DeleteNumberSnackBar(key: key, number: number, onUndo: () {});

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text('X'),
              );
            },
          ),
        ),
      ),);

      await tester.tap(find.text('X'));
      expect(find.byKey(key), findsNothing);
      await tester.pumpAndSettle();
      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets('calls action on undo', (tester) async {
      var actionPressed = false;
      final snackBar = DeleteNumberSnackBar(
          key: key,
          number: number,
          onUndo: () {
            actionPressed = true;
          },);

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text('X'),
              );
            },
          ),
        ),
      ),);

      await tester.tap(find.text('X'));
      await tester.pumpAndSettle();
      expect(actionPressed, isFalse);
      await tester.tap(find.text('Undo'));
      expect(actionPressed, isTrue);
    });
  });
}
