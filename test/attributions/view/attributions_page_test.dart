import 'package:flutter/material.dart';
import 'package:major_system/attributions/attributions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AttributionsPage', () {
    testWidgets('renders icon', (tester) async {
      await tester.pumpWidget(MaterialApp(home: AttributionsPage()));
      expect(find.byKey(const Key('application_icon_image')), findsOneWidget);
    });
  });
}
