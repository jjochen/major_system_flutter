// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/number_details/widgets/number_details_header.dart';
import 'package:numbers_repository/numbers_repository.dart';

import '../../mocks/number_repository_mocks.dart';

void main() {
  group('NumberDetailsHeader', () {
    Widget buildFrame(Number number) {
      return MaterialApp(
        home: Scaffold(
          body: NumberDetailsHeader(number: number),
        ),
      );
    }

    testWidgets('displays number and main word', (tester) async {
      await tester.pumpWidget(buildFrame(mainNumber));

      expect(find.text('Ronja'), findsOneWidget);
    });

    testWidgets('displays number without main word', (tester) async {
      await tester
          .pumpWidget(buildFrame(mainNumber.copyWith(mainWord: () => null)));

      expect(find.text('Ronja'), findsNothing);
    });
  });
}
