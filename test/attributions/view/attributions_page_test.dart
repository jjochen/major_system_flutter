// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/attributions/attributions.dart';

void main() {
  group('AttributionsPage', () {
    testWidgets('renders icon', (tester) async {
      await tester.pumpWidget(MaterialApp(home: AttributionsPage()));
      expect(find.byKey(const Key('application_icon_image')), findsOneWidget);
    });

    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(MaterialApp(home: AttributionsPage()));
      expect(find.text('Major System'), findsOneWidget);
    });

    testWidgets('renders copyright containing current year', (tester) async {
      await tester.pumpWidget(MaterialApp(home: AttributionsPage()));
      final currentYear = DateTime.now().year;
      expect(find.text('©$currentYear Jochen Pfeiffer'), findsOneWidget);
    });
  });
}
