// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/numbers/widgets/loading_indicator.dart';

void main() {
  group('LoadingIndicator', () {
    testWidgets('Renders CircularProgressIndicator',
        (WidgetTester tester) async {
      await tester.pumpWidget(LoadingIndicator());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
